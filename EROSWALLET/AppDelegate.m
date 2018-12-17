//
//  AppDelegate.m
//  ERW
//
//  Created by nestcode on 3/27/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "AppDelegate.h"

@import UIKit;

@interface AppDelegate ()

@end

@implementation AppDelegate{
    DashboardViewController *DashBoardView;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  //  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (IS_IPHONE_X){
        [application setStatusBarHidden:NO];
    }
    
   // [self ConnectSocket];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    NSUserDefaults *userSelectedCurr = [NSUserDefaults standardUserDefaults];
    [userSelectedCurr setValue:@"USD" forKey:@"userSelectedCurr"];
    [userSelectedCurr synchronize];
    
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    
    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
    
    [FIRApp configure];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)
                                                 name:kFIRInstanceIDTokenRefreshNotification object:nil];
    [FIRMessaging messaging].delegate = self;
    
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    [[NSUserDefaults standardUserDefaults]setValue:fcmToken forKey:@"FireBaseToken"];
    
    return YES;
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token: %@", fcmToken);
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Notification : %@",userInfo);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive)
    {
        /*UIAlertController *alertController = [UIAlertController
         alertControllerWithTitle:@"Reminder"
         message:notification.alertBody
         preferredStyle:UIAlertControllerStyleAlert];
         [self presentViewController:alertController animated:YES completion:nil];*/
        //   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"message:notification.alertBody delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //  [alert show];
    }
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

// [START refresh_token]
- (void)tokenRefreshNotification:(NSNotification *)notification {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    NSLog(@"InstanceID token: %@", refreshedToken);
    // Connect to FCM since connection may have failed when attempted before having a token.
    [self connectToFcm];
    
    // TODO: If necessary send token to appliation server.
}
// [END refresh_token]

// [START connect_to_fcm]
- (void)connectToFcm {
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Unable to connect to FCM. %@", error);
        } else {
            NSLog(@"Connected to FCM.");
        }
    }];
}
// [END connect_to_fcm]

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    NSLog(@"Hooray! I'm registered!");
    [[FIRMessaging messaging] subscribeToTopic:@"Brain"];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    [FIRMessaging messaging].APNSToken = deviceToken;
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as you need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSUserDefaults *pref=[NSUserDefaults standardUserDefaults];
    [pref setObject:token forKey:@"DeviceId"];
}


-(void)ConnectSocket{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DashBoardView = [[DashboardViewController alloc]init];
    
   // NSURL* url = [[NSURL alloc] initWithString:@"http://10.0.1.102:8000/"];
    NSURL* url = [[NSURL alloc] initWithString:@"https://beta.eroscoin.org"];
   // _manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"log":@YES,@"websocket":@YES,@"reconnect":@YES}];
     _manager = [[SocketManager alloc] initWithSocketURL:url config:@{@"websocket":@YES,@"reconnect":@YES}];
    SocketIOClient* socket = [_manager socketForNamespace:@"/account"];
    
    NSUserDefaults *UserID = [NSUserDefaults standardUserDefaults];
    NSString *strID = [UserID valueForKey:@"userID"];

    NSArray *arr = [[NSArray alloc]init];
    
    [socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
        [socket emit:@"IAMCONNECTED" with:@[@{@"passport": strID}]];
        [socket emit:@"getMaintenance" with:arr];
    }];
    
    [socket connect];
    
    [socket on:@"added" callback:^(NSArray* data, SocketAckEmitter* ack) {
         NSLog(@"%@",data);
    }];
    
    [socket on:@"confirmation" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"%@",data);
        NSDictionary *dictSocketData = [[NSDictionary alloc]init];
        dictSocketData = [data objectAtIndex:0];
        
        NSString *strDone = [dictSocketData valueForKey:@"cnf"];
        NSString *strRequired = [dictSocketData valueForKey:@"required"];
        DashBoardView.strID = [dictSocketData valueForKey:@"id"];
        
        NSUserDefaults *userConfirm = [NSUserDefaults standardUserDefaults];
        [userConfirm setFloat:[strDone floatValue] forKey:@"confirm"];
        [userConfirm synchronize];
        
        NSUserDefaults *userReq = [NSUserDefaults standardUserDefaults];
        [userReq setFloat:[strRequired floatValue] forKey:@"req"];
        [userReq synchronize];
        
        NSUserDefaults *userTID = [NSUserDefaults standardUserDefaults];
        [userTID setValue:[dictSocketData valueForKey:@"id"] forKey:@"SocketID"];
        [userTID synchronize];
        
        if ([strRequired floatValue] == [strDone floatValue]) {
            [userTID setValue:@"" forKey:@"SocketID"];
            [userTID synchronize];
        }
        
        [DashBoardView.tableTransactions reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reload_data" object:self];
    }];
    
    [socket on:@"logout" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Logout_user" object:self];
    }];
    
    [socket on:@"maintenance_app" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"%@",data);
        NSDictionary *dictDashMaintain = [[data objectAtIndex:0] valueForKey:@"dashboard"];
        NSUserDefaults *userDashMaintain = [NSUserDefaults standardUserDefaults];
        [userDashMaintain setObject:dictDashMaintain forKey:@"userDashMaintain"];
        [userDashMaintain synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DashMaintain" object:self];
        
        NSDictionary *dictReceiveMaintain = [[data objectAtIndex:0] valueForKey:@"receive"];
        NSUserDefaults *userReceiveMaintain = [NSUserDefaults standardUserDefaults];
        [userReceiveMaintain setObject:dictReceiveMaintain forKey:@"userReceiveMaintain"];
        [userReceiveMaintain synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReceiveMaintain" object:self];
        
        NSDictionary *dictSecurityMaintain = [[data objectAtIndex:0] valueForKey:@"security"];
        NSUserDefaults *userSecurityMaintain = [NSUserDefaults standardUserDefaults];
        [userSecurityMaintain setObject:dictSecurityMaintain forKey:@"userSecurityMaintain"];
        [userSecurityMaintain synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SecurityMaintain" object:self];
        
        NSDictionary *dictSendMaintain = [[data objectAtIndex:0] valueForKey:@"send"];
        NSUserDefaults *userSendMaintain = [NSUserDefaults standardUserDefaults];
        [userSendMaintain setObject:dictSendMaintain forKey:@"userSendMaintain"];
        [userSendMaintain synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SendMaintain" object:self];
        
        NSDictionary *dictSettingMaintain = [[data objectAtIndex:0] valueForKey:@"settings"];
        NSUserDefaults *userSettingMaintain = [NSUserDefaults standardUserDefaults];
        [userSettingMaintain setObject:dictSettingMaintain forKey:@"userSettingMaintain"];
        [userSettingMaintain synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingMaintain" object:self];
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[FIRMessaging messaging] disconnect];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self connectToFcm];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
