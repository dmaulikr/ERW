//
//  ActivityLogViewController.m
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "ActivityLogViewController.h"

@interface ActivityLogViewController ()

@end

@implementation ActivityLogViewController{
    NSMutableArray *arrActivityData;
    NSUserDefaults *UserData, *UserToken, *UserUDID;
    NSDictionary *dictUserData;
    NSString *strCallType, *strToken, *strUDID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserData = [NSUserDefaults standardUserDefaults];
    dictUserData = [[NSDictionary alloc]init];
    
    dictUserData = [UserData objectForKey:@"userdata"];
    
    UserToken = [NSUserDefaults standardUserDefaults];
    UserUDID = [NSUserDefaults standardUserDefaults];
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];

    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self ApiActivities];
}


//MARK: APIWORK
-(void)CheckConnection{
    NSString *strError = NSLocalizedString(@"Device is not connected to Internet!! Please connect to the Internet and try again!!", @"");
    NSString *strAlert = NSLocalizedString(@"Alert!!", @"");
    UIAlertController * alertController1 = [UIAlertController alertControllerWithTitle: strAlert
                                                                               message: strError
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    [alertController1 addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController1 animated:YES completion:nil];
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrActivityData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityLogsTableViewCell *cell = [self.tableActivities dequeueReusableCellWithIdentifier:@"ActivityLogsTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictTemp = [arrActivityData objectAtIndex:indexPath.row];
    
    
    NSString *strActivityType = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"type"]];
    
    if ([strActivityType isEqualToString:@"1"]) {
        cell.lblActivityType.text = @"Profile";
        cell.imgActivityType.image = [UIImage imageNamed:@"user"];
        cell.lblActivity.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"activity"]];
        
    }
    else if ([strActivityType isEqualToString:@"2"]) {
        cell.lblActivityType.text = @"Transaction";
        cell.imgActivityType.image = [UIImage imageNamed:@"money-transfer"];
        
        NSString *strJsonActivity = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"activity"]];
        
        NSData *jsonData = [strJsonActivity dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        cell.lblActivity.text = [NSString stringWithFormat:@"Type: %@\nFrom: %@\nAmount: %@",[jsonObject valueForKey:@"type"],[jsonObject valueForKey:@"from"],[jsonObject valueForKey:@"amount"]];
    }
    else{
        cell.lblActivityType.text = @"Security";
        cell.imgActivityType.image = [UIImage imageNamed:@"ActivitySecurity"];
         NSString *strActivity = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"activity"]];
        
        if ([strActivity containsString:@"and"]) {
            strActivity = [strActivity stringByReplacingOccurrencesOfString:@"and"
                                                 withString:@"\n"];
        }
        
        if ([strActivity containsString:@"updated"]) {
            strActivity = [strActivity stringByReplacingOccurrencesOfString:@"updated"
                                                                 withString:@""];
        }
        
        cell.lblActivity.text = strActivity;
    }
    
    NSString *strOS = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"os"]];
    NSString *strBrowser = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"browser"]];
    
    if ([strOS containsString:@"ubuntu"]) {
        cell.imgOS.image = [UIImage imageNamed:@"ubuntu-logo"];
    }
    else if ([strOS containsString:@"windows"]) {
        cell.imgOS.image = [UIImage imageNamed:@"windows-8"];
    }
    else if ([strOS containsString:@"OS"]) {
        cell.imgOS.image = [UIImage imageNamed:@"apple"];
    }
    else if ([strOS containsString:@"linux"]) {
        cell.imgOS.image = [UIImage imageNamed:@"linux"];
    }
    
    if ([strBrowser containsString:@"chrome"]) {
        cell.imgBrowser.image = [UIImage imageNamed:@"chrome"];
    }
    else if ([strBrowser containsString:@"firefox"]) {
        cell.imgBrowser.image = [UIImage imageNamed:@"mozilla-firefox"];
    }
    else if ([strBrowser containsString:@"ie"]) {
        cell.imgBrowser.image = [UIImage imageNamed:@"internet-explorer"];
    }
    else if ([strBrowser containsString:@"opera"]) {
        cell.imgBrowser.image = [UIImage imageNamed:@"opera"];
    }
    else if ([strBrowser containsString:@"safari"]) {
        cell.imgBrowser.image = [UIImage imageNamed:@"safari"];
    }
    
    cell.lblIPAddress.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"ip"]];
        
    NSString *strTempDate = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"created_at"]];
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate * convrtedDate = [formatter dateFromString:strTempDate];
    [formatter setDateFormat:@"dd MMM yy hh:mm a"];
    cell.lblTime.text = [formatter stringFromDate:convrtedDate];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictTemp = [arrActivityData objectAtIndex:indexPath.row];
    
     NSString *str = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"type"]];
    
    if ([str isEqualToString:@"2"]) {
        return 110;
    }
    return 92;
}

-(void)ApiActivities{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             @"0",@"offset",
                             @"40",@"limit",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_ACTIVITYLOG];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_ACTIVITYLOG];
        strCallType = @"activityLog";
    }
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
    [SVProgressHUD dismiss];
    
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonRes = [response JSONValue];
    
    if ([strCallType isEqualToString:@"activityLog"]){
        if (callType == CALL_TYPE_ACTIVITYLOG){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                arrActivityData = [[NSMutableArray alloc]init];
                arrActivityData = [jsonRes valueForKey:@"data"];
                [_tableActivities reloadData];
            }
        }
    }
}

@end
