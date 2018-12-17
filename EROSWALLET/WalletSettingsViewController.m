//
//  WalletSettingsViewController.m
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "WalletSettingsViewController.h"

@interface WalletSettingsViewController ()

@end

@implementation WalletSettingsViewController{
    NSString *strCallType, *strEmailAddress, *strMobileNumber, *strToken, *strUDID, *strEmailNotify, *strPushNotify, *strEmailVerify, *strWalletCurrency;
    NSInteger isEmail, isPushNotification;
    NSUserDefaults *UserData, *UserToken, *UserUDID;
    NSDictionary *dictUserData;
    NSUserDefaults *UserSettings, *isLogin;
    NSDictionary *dictUserSettings;
    NSUserDefaults *UserWalletCurrency, *UserWalletCurr, *userSelectedCurr;
    NSMutableArray *arrWalletCurr;
     int selectedsort, selectedCurrency;
    NSString *strSelectedCurr;
    NSMutableArray *arrSearchData, *arrNames;
    NSArray *arrSearchResult;
    BOOL searchEnabled;
    int isMaintain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewUpdates.hidden = YES;
    _txtMobileNumber.delegate = self;
    _txtEmaiID.delegate = self;
    
    _viewMaintenance.hidden = YES;
    _viewCurrencies.hidden = YES;
    
    userSelectedCurr = [NSUserDefaults standardUserDefaults];
    strSelectedCurr = [userSelectedCurr valueForKey:@"userSelectedCurr"] ;
    
    _lblWalletCurrencies.text = strSelectedCurr;
    
    UserWalletCurrency = [NSUserDefaults standardUserDefaults];
    strWalletCurrency = [UserWalletCurrency valueForKey:@"walletCurrency"];
    if ([strWalletCurrency isEqualToString:@"USD"]) {
        _segmentWalletCurrency.selectedSegmentIndex = 0;
    }
    else{
        _segmentWalletCurrency.selectedSegmentIndex = 1;
    }
    
    //TODO: UserWalletCurr is coming from API --------------------------------------
    arrWalletCurr = [[NSMutableArray alloc]init];
    UserWalletCurr = [NSUserDefaults standardUserDefaults];
    arrWalletCurr = [UserWalletCurr objectForKey:@"UserWalletCurr"];
    
    UserSettings = [NSUserDefaults standardUserDefaults];
    dictUserSettings = [[NSDictionary alloc]init];
    dictUserSettings = [UserSettings objectForKey:@"usersettings"];
    
    strEmailVerify = [NSString stringWithFormat:@"%@",[dictUserSettings valueForKey:@"email_verification"]];
    
    _lblisEMAILVerified.layer.cornerRadius = 9;
    _lblisEMAILVerified.layer.masksToBounds = YES;
    
    if ([strEmailVerify isEqualToString:@"1"]) {
        _lblisEMAILVerified.text = @"verified";
        [_lblisEMAILVerified setBackgroundColor:[UIColor greenColor]];
    }
    else{
        _lblisEMAILVerified.text = @"not verified";
        [_lblisEMAILVerified setBackgroundColor:[UIColor redColor]];
    }
    
    UserData = [NSUserDefaults standardUserDefaults];
    dictUserData = [[NSDictionary alloc]init];
    dictUserData = [UserData objectForKey:@"userdata"];
    UserToken = [NSUserDefaults standardUserDefaults];
    UserUDID = [NSUserDefaults standardUserDefaults];
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
    _scrollWalletSettings.frame = CGRectMake(0, 0, self.view.frame.size.width, 636);
    [_scrollWalletSettings setContentSize:CGSizeMake(self.view.frame.size.width, 636)];

    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    _viewWalletID.clipsToBounds = YES;
    _viewEmailAdd.clipsToBounds = YES;
    _viewMobileNum.clipsToBounds = YES;
    _viewWalletLanguage.clipsToBounds = YES;
    _viewWalletCurrency.clipsToBounds = YES;
    _viewNotifications.clipsToBounds = YES;
    _viewMobileNum.hidden = YES;
    _viewWalletLanguage.hidden = YES;
    
    _viewForEmailChange.layer.borderWidth = 0.5f;
    _viewForEmailChange.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewForMobileChange.layer.borderWidth = 0.5f;
    _viewForMobileChange.layer.borderColor = [[UIColor grayColor]CGColor];
    
    _lblWalletCurrencies.layer.borderWidth = 1.5f;
    _lblWalletCurrencies.layer.borderColor = [self colorWithHexString:@"41426D"].CGColor;
    
    [self ApiGetUserSettings];
    
    [self Maintenance];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Maintenance) name:@"SettingMaintain" object:nil];

}

-(void)Maintenance{
    NSDictionary *SettingMaintain = [[NSDictionary alloc]init];
    NSUserDefaults *userSettingMaintain = [NSUserDefaults standardUserDefaults];
    SettingMaintain = [userSettingMaintain objectForKey:@"userSettingMaintain"];
    
    NSString *strMaintain = [NSString stringWithFormat:@"%@",[SettingMaintain valueForKey:@"status"]];
    
    if ([strMaintain isEqualToString:@"1"]) {
        _viewMaintenance.hidden = NO;
        _lblMaintenanceMessage.text = [SettingMaintain valueForKey:@"message"];
    }
    else{
        _viewMaintenance.hidden = YES;
    }
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


#pragma mark - keyboard movements

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        [self.view setFrame:CGRectMake(0,-310,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}


-(void)dismissKeyboard {
    
    NSLog(@"dismiss");
    [self keyboardWillHide];
}

- (IBAction)dismissKeyboard:(id)sender;
{
    NSLog(@"dismiss");
    [self keyboardWillHide];
    [_txtEmaiID resignFirstResponder];
    [_txtMobileNumber resignFirstResponder];
}

-(void)keyboardWillHide
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField reloadInputViews];
    [textField resignFirstResponder];
    [self keyboardWillHide];
    return NO;
}


- (IBAction)onEmailChangeClicked:(id)sender {
    _viewChangeEmail.hidden = NO;
    _viewChangeMobile.hidden = YES;
    _viewUpdates.hidden = NO;
}

- (IBAction)onMobileNumChangedClicked:(id)sender {
    _viewChangeMobile.hidden = NO;
    _viewChangeEmail.hidden = YES;
    _viewUpdates.hidden = NO;
}

- (IBAction)onWalletCurrencyClicked:(id)sender {
}

- (IBAction)onEmailNotificationSwichClicked:(id)sender {
    if([sender isOn]){
        strEmailNotify = @"true";
    }
    else{
        strEmailNotify = @"false";
    }
    [self ApiUpdateNotifications];
}

- (IBAction)onPushNotificationSwitchClicked:(id)sender {
    if([sender isOn]){
        strPushNotify = @"true";
    }
    else{
        strPushNotify = @"false";
    }
    [self ApiUpdateNotifications];
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

-(void)ApiGetUserSettings{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_SETTINGS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_SETTINGS];
        strCallType = @"userSettings";
    }
}

-(void)ApiWalletCurrencies{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        // [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_WALLET_CURRENCIES];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_WALLET_CURRENCIES];
        strCallType = @"walletcurr";
    }
}


-(void)ApiEmailChanged{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             _txtEmaiID.text,@"email",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_VERIFY_EMAIL];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_VERIFY_EMAIL];
        strCallType = @"email";
    }
}

-(void)ApiMobileChanged{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             _txtMobileNumber.text,@"phone",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_UPDATE_PHONE];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_UPDATE_PHONE];
        strCallType = @"updatePhone";
    }
}

-(void)ApiUpdateNotifications{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
       // [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strEmailNotify,@"email_notification",
                             strPushNotify,@"push_notification",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_UPDATE_NOTIFICATION];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_UPDATE_NOTIFICATION];
        strCallType = @"updateNotification";
    }
}

#pragma mark - ApiCallManagerDelegate

- (void)parserDidFailWithError:(NSError *)error andCallType:(CallTypeEnum)callType{
    NSLog(@"%s : Error : %@",__FUNCTION__, [error localizedDescription]);
    self.view.userInteractionEnabled = YES;
}

- (void)requestHandler:(HTTPRequestHandler *)requestHandler didFailedWithError:(NSError *)error andCallBack:(CallTypeEnum)callType
{
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
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
    self.view.userInteractionEnabled = YES;
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonRes = [response JSONValue];
    
    if ([[jsonRes valueForKey:@"message"] isEqualToString:@"Unauthenticated"]) {
        [SVProgressHUD dismiss];
        
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
    
    if ([strCallType isEqualToString:@"userSettings"]){
        if (callType == CALL_TYPE_SETTINGS){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                
                NSDictionary *dictUserSettings = [jsonRes valueForKey:@"data"];
                NSUserDefaults *UserSettings = [NSUserDefaults standardUserDefaults];
                [UserSettings setObject:dictUserSettings forKey:@"usersettings"];
                [UserSettings synchronize];
                
                _lblCurrency.text = [dictUserSettings valueForKey:@"wallet_currency"];
                _lblWalletID.text = [[dictUserSettings objectForKey:@"user"] valueForKey:@"wallet"];
                _lblEmailID.text = [[dictUserSettings objectForKey:@"user"] valueForKey:@"email"];
                _lblMobileNumber.text = [[dictUserSettings objectForKey:@"user"] valueForKey:@"phone"];
                
                strEmailNotify = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"notification"] valueForKey:@"email_notification"]];
                
                strPushNotify = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"notification"] valueForKey:@"push_notification"]];
                
                if ([strEmailNotify isEqualToString:@"1"]){
                    [_switchEmail setOn:YES];
                }
                else{
                    [_switchEmail setOn:NO];
                }
                
                if ([strPushNotify isEqualToString:@"1"]){
                    [_switchPushNotification setOn:YES];
                }
                else{
                    [_switchPushNotification setOn:NO];
                }
                [self ApiWalletCurrencies];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"walletcurr"]){
        if (callType == CALL_TYPE_WALLET_CURRENCIES){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                
                arrWalletCurr = [jsonRes valueForKey:@"data"];
                NSUserDefaults *UserWalletCurr = [NSUserDefaults standardUserDefaults];
                [UserWalletCurr setObject:arrWalletCurr forKey:@"UserWalletCurr"];
                [UserWalletCurr synchronize];
                
                [self Names];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    
   else if ([strCallType isEqualToString:@"email"]){
       if (callType == CALL_TYPE_VERIFY_EMAIL){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.messageColor = [UIColor orangeColor];
                [self.view makeToast:[jsonRes valueForKey:@"message"]
                            duration:3.0
                            position:CSToastPositionBottom
                               style:style];
                
                [CSToastManager setSharedStyle:style];
                [CSToastManager setTapToDismissEnabled:YES];
                [CSToastManager setQueueEnabled:YES];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"updatePhone"]){
        if (callType == CALL_TYPE_UPDATE_PHONE){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.messageColor = [UIColor orangeColor];
                [self.view makeToast:[jsonRes valueForKey:@"message"]
                            duration:3.0
                            position:CSToastPositionBottom
                               style:style];
                
                [CSToastManager setSharedStyle:style];
                [CSToastManager setTapToDismissEnabled:YES];
                [CSToastManager setQueueEnabled:YES];
                
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"updateNotification"]){
        if (callType == CALL_TYPE_UPDATE_NOTIFICATION){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.messageColor = [UIColor orangeColor];
                [self.view makeToast:[jsonRes valueForKey:@"message"]
                            duration:3.0
                            position:CSToastPositionBottom
                               style:style];
                
                [CSToastManager setSharedStyle:style];
                [CSToastManager setTapToDismissEnabled:YES];
                [CSToastManager setQueueEnabled:YES];
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
}


- (IBAction)onEmailChangeDoneClicked:(id)sender {
    if (_txtEmaiID.text.length == 0) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Email ID" closeButtonTitle:nil duration:0.0f];
    }
    else{
        [self ApiEmailChanged];
    }
}

- (IBAction)onMobileChangeDoneClicked:(id)sender {
    if (_txtMobileNumber.text.length == 0) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Mobile Number" closeButtonTitle:nil duration:0.0f];
    }
    else{
        [self ApiMobileChanged];
    }
    
}

- (IBAction)onCloseUpdateClicked:(id)sender {
    _viewUpdates.hidden = YES;
}


- (IBAction)onSegmentWalletCurrencyClicked:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            strWalletCurrency = @"USD";
            break;
        case 1:
            strWalletCurrency = @"BTC";
            break;
        default:
            strWalletCurrency = @"USD";
            break;
    }
    UserWalletCurrency = [NSUserDefaults standardUserDefaults];
    [UserWalletCurrency setValue:strWalletCurrency forKey:@"walletCurrency"];
    [UserWalletCurrency synchronize];
}

- (IBAction)onEditTransPassClicked:(id)sender {
}

- (IBAction)onWalletCurrClicked:(id)sender {
    _viewCurrencies.hidden = NO;
 /*   NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
    NSMutableDictionary *dictTemp = [[NSMutableDictionary alloc]init];
    for (int i = 0; i< [arrWalletCurr count]; i++) {
        dictTemp = [arrWalletCurr objectAtIndex:i];
        NSString *strTemp = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
        [arrTemp addObject:strTemp];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Currency" rows:arrTemp initialSelection:selectedCurrency
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue)
     {
         
         selectedCurrency = (int)selectedIndex;
         _lblWalletCurrencies.text = [[arrWalletCurr objectAtIndex:selectedCurrency] valueForKey:@"symbol"];
         NSUserDefaults *userSelectedCurrIndex = [NSUserDefaults standardUserDefaults];
         [userSelectedCurrIndex setInteger:selectedIndex forKey:@"userSelectedCurrIndex"];
         [userSelectedCurrIndex synchronize];
         
         NSUserDefaults *userSelectedCurr = [NSUserDefaults standardUserDefaults];
         [userSelectedCurr setValue:_lblWalletCurrencies.text forKey:@"userSelectedCurr"];
         [userSelectedCurr synchronize];
         
         
     }cancelBlock:^(ActionSheetStringPicker *picker)
     {
         
     }origin:sender];*/
}


- (IBAction)onCloseCurrenciesClicked:(id)sender {
    _viewCurrencies.hidden = YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searchEnabled) {
        return arrSearchData.count;
    }
    else{
        return arrWalletCurr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WalletCurrencyTableViewCell *cell = [self.tableCurrencies dequeueReusableCellWithIdentifier:@"WalletCurrencyTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictTemp = [[NSDictionary alloc]init];
    
    if (searchEnabled) {
        dictTemp = [arrSearchData objectAtIndex:indexPath.row];
    }
    else{
        dictTemp = [arrWalletCurr objectAtIndex:indexPath.row];
    }
    
    cell.lblCurrencyName.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
    
    return cell;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictTemp = [[NSDictionary alloc]init];
    
    if (searchEnabled) {
        dictTemp = [arrSearchData objectAtIndex:indexPath.row];
    }
    else{
        dictTemp = [arrWalletCurr objectAtIndex:indexPath.row];
    }
    
    _lblWalletCurrencies.text = [dictTemp valueForKey:@"symbol"];
    NSUserDefaults *userSelectedCurrIndex = [NSUserDefaults standardUserDefaults];
    [userSelectedCurrIndex setInteger:indexPath.row forKey:@"userSelectedCurrIndex"];
    [userSelectedCurrIndex synchronize];
    
    NSUserDefaults *userSelectedCurr = [NSUserDefaults standardUserDefaults];
    [userSelectedCurr setValue:_lblWalletCurrencies.text forKey:@"userSelectedCurr"];
    [userSelectedCurr synchronize];
    
    _viewCurrencies.hidden = YES;

}

-(void)Names{
    arrNames = [[NSMutableArray alloc]init];
    arrNames = [arrWalletCurr valueForKey:@"name"];
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    arrSearchData = [[NSMutableArray alloc]init];
    NSPredicate *resultPredicate = [NSCompoundPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    
    arrSearchResult = [arrNames filteredArrayUsingPredicate:resultPredicate];
    
    for (int i=0; i<[arrSearchResult count]; i++) {
        NSString *str = [arrSearchResult objectAtIndex:i];
        for ( NSDictionary *dic2 in arrWalletCurr)
        {
            if ([[dic2 valueForKey:@"name"] isEqual:str])
            {
                [arrSearchData addObject:dic2];
            }
        }
    }
    NSLog(@"%@",arrSearchData);
    [_tableCurrencies reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        searchEnabled = NO;
        [_tableCurrencies reloadData];
    }
    else {
        searchEnabled = YES;
        [self filterContentForSearchText:searchBar.text];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchEnabled = YES;
    [self keyboardWillHide];
    [self filterContentForSearchText:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    searchEnabled = NO;
    [self keyboardWillHide];
    [_tableCurrencies reloadData];
}


















@end
