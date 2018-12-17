//
//  SidebarTableViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "SidebarTableViewController.h"
#import "SWRevealViewController.h"
#import "SidebarTableViewCell.h"


@interface SidebarTableViewController ()

@end

@implementation SidebarTableViewController {
    NSArray *menuItems;
    NSUserDefaults *isLogin;
    NSUserDefaults *ColorCode, *Userprofileimg,*UserData;
    NSString *strColor;
    NSMutableDictionary *userDictData;
    NSUserDefaults *userLanguage;
    NSString *strLang;
    NSString *port ;
    MFMailComposeViewController *mailCont;
    NSString *osVersion ,*deviceName ,*appVersion;
    NSString *strTheme;
    NSString *strToken, *strUDID, *strAccountID;
    NSMutableDictionary *dictUserData;
    NSUserDefaults *userArrColors, *userSelectedIndex, *UserToken, *UserDictData, *UserUDID;
    NSDictionary *dictUserSettings;
    NSUserDefaults *UserSettings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLogin = [NSUserDefaults standardUserDefaults];
    
    UserSettings = [NSUserDefaults standardUserDefaults];
    dictUserSettings = [[NSMutableDictionary alloc]init];
    strAccountID = [[dictUserSettings objectForKey:@"user"] valueForKey:@"wallet"];
    
    ColorCode = [NSUserDefaults standardUserDefaults];
    strColor = [NSString stringWithFormat:@"%@",[ColorCode valueForKey:@"colorcode"]];
    
    menuItems = @[@"logo",@"Applications", @"dash", @"settings", @"security", @"send", @"receive", @"account", @"others", @"activity", @"faq", @"logout"];
    
    Userprofileimg = [NSUserDefaults standardUserDefaults];
    UserData = [NSUserDefaults standardUserDefaults];
    userDictData = [[NSMutableDictionary alloc]init];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    userLanguage = [NSUserDefaults standardUserDefaults];
    strLang = [userLanguage valueForKey:@"AppleLanguages"];
    
    //  Day/Night Mode Setting
    strTheme = [[NSUserDefaults standardUserDefaults]
                stringForKey:@"theme"];
    
    if ([strTheme isEqualToString:@"1"]) {
        [self.tableView setBackgroundColor:[UIColor blackColor]];
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    }
    else{
        [self.tableView setBackgroundColor:[UIColor whiteColor]];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:20.0f/255.0f green:181.0f/255.0f blue:201.0f/255.0f alpha:1.0];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UserDictData = [NSUserDefaults standardUserDefaults];
    UserToken = [NSUserDefaults standardUserDefaults];
    dictUserData = [[NSMutableDictionary alloc]init];
    UserUDID = [NSUserDefaults standardUserDefaults];
    
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    dictUserData = [UserDictData objectForKey:@"userdata"];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
    
    
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}


//MARK:ConnectionCheck
-(void)CheckConnection{
    NSString *strError = NSLocalizedString(@"Device is not connected to Internet!! Please connect to the Internet and try again!!", @"");
    NSString *strAlert = NSLocalizedString(@"Alert!!", @"");
    UIAlertController * alertController1 = [UIAlertController alertControllerWithTitle: strAlert
                                                                               message: strError
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    [alertController1 addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController1 animated:YES completion:nil];
}

-(void)ApiLogout{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_LOGOUT];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_LOGOUT];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    SidebarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    cell.lblAccountID.text = [[dictUserData objectForKey:@"data"] valueForKey:@"wallet"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 11) {
        
        NSString *strLogout = NSLocalizedString(@"Are you sure you want to logout?", @"");
        NSString *strLogoutAtt = NSLocalizedString(@"Attention!!", @"");
        NSString *strYES = NSLocalizedString(@"YES", @"");
        NSString *strNO = NSLocalizedString(@"NO", @"");
        
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:strLogoutAtt
                                     message:strLogout
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:strYES
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                           
                                        [self ApiLogout];

                                       
                                    }];
        UIAlertAction* noButton = [UIAlertAction
                                    actionWithTitle:strNO
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                             
                                    }];
        [alert addAction:yesButton];
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // CGFloat height;
    if(indexPath.row==0)
    {
        return   140;
    }
    else if(indexPath.row==1 || indexPath.row == 8)
    {
        return   30;
    }
    else
    {
        return 50;
    }

}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString*)deviceModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //MARK: More official list is at
    //http://theiphonewiki.com/wiki/Models
    //MARK: You may just return machineName. Following is for convenience
    
    NSDictionary *commonNamesDictionary =
    @{
      @"i386":     @"i386 Simulator",
      @"x86_64":   @"x86_64 Simulator",
      
      @"iPhone1,1":    @"iPhone",
      @"iPhone1,2":    @"iPhone 3G",
      @"iPhone2,1":    @"iPhone 3GS",
      @"iPhone3,1":    @"iPhone 4",
      @"iPhone3,2":    @"iPhone 4(Rev A)",
      @"iPhone3,3":    @"iPhone 4(CDMA)",
      @"iPhone4,1":    @"iPhone 4S",
      @"iPhone5,1":    @"iPhone 5(GSM)",
      @"iPhone5,2":    @"iPhone 5(GSM+CDMA)",
      @"iPhone5,3":    @"iPhone 5c(GSM)",
      @"iPhone5,4":    @"iPhone 5c(GSM+CDMA)",
      @"iPhone6,1":    @"iPhone 5s(GSM)",
      @"iPhone6,2":    @"iPhone 5s(GSM+CDMA)",
      
      @"iPhone7,1":    @"iPhone 6+(GSM+CDMA)",
      @"iPhone7,2":    @"iPhone 6(GSM+CDMA)",
      
      @"iPhone8,1":    @"iPhone 6S(GSM+CDMA)",
      @"iPhone8,2":    @"iPhone 6S+(GSM+CDMA)",
      @"iPhone8,4":    @"iPhone SE(GSM+CDMA)",
      @"iPhone9,1":    @"iPhone 7(GSM+CDMA)",
      @"iPhone9,2":    @"iPhone 7+(GSM+CDMA)",
      @"iPhone9,3":    @"iPhone 7(GSM+CDMA)",
      @"iPhone9,4":    @"iPhone 7+(GSM+CDMA)",
      
      @"iPhone10,1":    @"iPhone 8",
      @"iPhone10,2":    @"iPhone 8+",
      @"iPhone10,3":    @"iPhone X",
      @"iPhone10,4":    @"iPhone 8",
      @"iPhone10,5":    @"iPhone 8+",
      @"iPhone10,6":    @"iPhone X",
      
      @"iPad1,1":  @"iPad",
      @"iPad2,1":  @"iPad 2(WiFi)",
      @"iPad2,2":  @"iPad 2(GSM)",
      @"iPad2,3":  @"iPad 2(CDMA)",
      @"iPad2,4":  @"iPad 2(WiFi Rev A)",
      @"iPad2,5":  @"iPad Mini 1G (WiFi)",
      @"iPad2,6":  @"iPad Mini 1G (GSM)",
      @"iPad2,7":  @"iPad Mini 1G (GSM+CDMA)",
      @"iPad3,1":  @"iPad 3(WiFi)",
      @"iPad3,2":  @"iPad 3(GSM+CDMA)",
      @"iPad3,3":  @"iPad 3(GSM)",
      @"iPad3,4":  @"iPad 4(WiFi)",
      @"iPad3,5":  @"iPad 4(GSM)",
      @"iPad3,6":  @"iPad 4(GSM+CDMA)",
      
      @"iPad4,1":  @"iPad Air(WiFi)",
      @"iPad4,2":  @"iPad Air(GSM)",
      @"iPad4,3":  @"iPad Air(GSM+CDMA)",
      
      @"iPad5,3":  @"iPad Air 2 (WiFi)",
      @"iPad5,4":  @"iPad Air 2 (GSM+CDMA)",
      
      @"iPad4,4":  @"iPad Mini 2G (WiFi)",
      @"iPad4,5":  @"iPad Mini 2G (GSM)",
      @"iPad4,6":  @"iPad Mini 2G (GSM+CDMA)",
      
      @"iPad4,7":  @"iPad Mini 3G (WiFi)",
      @"iPad4,8":  @"iPad Mini 3G (GSM)",
      @"iPad4,9":  @"iPad Mini 3G (GSM+CDMA)",
      
      @"iPod1,1":  @"iPod 1st Gen",
      @"iPod2,1":  @"iPod 2nd Gen",
      @"iPod3,1":  @"iPod 3rd Gen",
      @"iPod4,1":  @"iPod 4th Gen",
      @"iPod5,1":  @"iPod 5th Gen",
      @"iPod7,1":  @"iPod 6th Gen",
      };
    
    deviceName = commonNamesDictionary[machineName];
    if (deviceName == nil) {
        deviceName = machineName;
    }
    return deviceName;
}


#pragma mark - ApiCallManagerDelegate

- (void)parserDidFailWithError:(NSError *)error andCallType:(CallTypeEnum)callType{
    NSLog(@"%s : Error : %@",__FUNCTION__, [error localizedDescription]);
}

- (void)requestHandler:(HTTPRequestHandler *)requestHandler didFailedWithError:(NSError *)error andCallBack:(CallTypeEnum)callType
{
    [SVProgressHUD dismiss];
    
    NSString *strError = NSLocalizedString(@"Something went wrong!!, Please try again", @"");
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:strError
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)requestHandler:(HTTPRequestHandler *)requestHandler didFinishWithData:(NSData *)data andCallBack:(CallTypeEnum)callType{
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonRes = [response JSONValue];
    if ([[jsonRes valueForKey:@"message"] isEqualToString:@"Unauthenticated"]) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
            isLogin = [NSUserDefaults standardUserDefaults];
            [isLogin setInteger:0 forKey:@"isLogin"];
            [isLogin synchronize];
            
            NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
            [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
            
            [self performSegueWithIdentifier:@"logout" sender:self];
        }];
        [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
    }
    else{
            if (callType == CALL_TYPE_LOGOUT){
                NSLog(@"%@",jsonRes);
                NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
                NSLog(@"%@",status);
                if ([status isEqualToString:@"1"]) {
                    isLogin = [NSUserDefaults standardUserDefaults];
                    [isLogin setInteger:0 forKey:@"isLogin"];
                    [isLogin synchronize];
                    
                    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
                    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
                    
                    [self performSegueWithIdentifier:@"logout" sender:self];
                }
                else{
                    SCLAlertView *alert = [[SCLAlertView alloc] init];
                    [alert addButton:@"OK" actionBlock:^(void) {
                    }];
                    [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
                }
            }
        }
}

@end
