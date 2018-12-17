//
//  WalletSecurityViewController.m
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "WalletSecurityViewController.h"

@interface WalletSecurityViewController ()

@end

@implementation WalletSecurityViewController{
    NSUserDefaults *UserSettings, *UserToken, *UserUDID;
    NSDictionary *dictUserSettings;
    NSString *str2FAStatus, *strEmailVerificationStatus, *strActivitySatus, *strCallType, *strToken, *strUDID, *strQR;
    NSUserDefaults *isLogin;
    int isMaintain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollWalletSecurity.frame = CGRectMake(0, 0, self.view.frame.size.width, 656);
    [_scrollWalletSecurity setContentSize:CGSizeMake(self.view.frame.size.width, 656)];
    
    _txtAuthCode.delegate = self;
    _txtEnterPassword.delegate = self;
    _txtOldPassword.delegate = self;
    _txtConfirmPass.delegate = self;
    _txtNewPassWord.delegate = self;
    _txtTransPass.delegate = self;
    _txtReEnterTransPass.delegate = self;
    
    _viewPasswordUpdate.hidden = YES;
    _view2FAUpdate.hidden = YES;
    _viewTransPass.hidden = YES;
    
    _viewOldPass.layer.borderWidth = 0.5f;
    _viewOldPass.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewNewPass.layer.borderWidth = 0.5f;
    _viewNewPass.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewConfirmPass.layer.borderWidth = 0.5f;
    _viewConfirmPass.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewAuthKey.layer.borderWidth = 0.5f;
    _viewAuthKey.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewEnterPass.layer.borderWidth = 0.5f;
    _viewEnterPass.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewAuthCode.layer.borderWidth = 0.5f;
    _viewAuthCode.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewEnterTransPass.layer.borderWidth = 0.5f;
    _viewEnterTransPass.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewReEnterTransPass.layer.borderWidth = 0.5f;
    _viewReEnterTransPass.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    NSUserDefaults *UserSettings = [NSUserDefaults standardUserDefaults];
    dictUserSettings = [[NSDictionary alloc]init];
    dictUserSettings = [UserSettings objectForKey:@"usersettings"];
    
    UserToken = [NSUserDefaults standardUserDefaults];
    UserUDID = [NSUserDefaults standardUserDefaults];
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
    strQR = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"user"] valueForKey:@"secure_key"]];
    
     NSString *resultAsString = [NSString stringWithFormat:@"otpauth://totp/AWP-S0134SWIFTT13:swpadmin?secret=%@&issuer=AWP-S0134TESTT13&algorithm=SHA1&digits=8&period=30",strQR];
    
    UIImage *imgQRCode = [UIImage mdQRCodeForString:resultAsString size:100.0f];
    _imgQR.image = imgQRCode;
    
    _lblAuthKey.text = strQR;
    
    NSString *str2FA = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"user"] valueForKey:@"is_2fa"]];
    
    NSString *strBackUp = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"user"] valueForKey:@"is_genrated"]];
    
    NSString *strEmailVerify = [NSString stringWithFormat:@"%@",[dictUserSettings valueForKey:@"email_verification"]];
    
    NSString *strActivity = [NSString stringWithFormat:@"%@",[dictUserSettings valueForKey:@"activity_log"]];
    NSString *strTransPass = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"transaction"] valueForKey:@"status"]];
    
    _viewMaintenance.hidden = YES;
    
    
    if ([strTransPass isEqualToString:@"1"]){
        [_switchTransPassword setOn:YES];
        _lblTransPasswordStatus.text = @"Enable";
    }
    else{
        [_switchTransPassword setOn:NO];
        _lblTransPasswordStatus.text = @"Disable";
    }
    
    if ([strBackUp isEqualToString:@"1"]){
        _btnBackUpSeeds.hidden = YES;
        _lblBackUpSeeds.text = @"Generated";
    }
    else{
        _btnBackUpSeeds.hidden = NO;
        _lblBackUpSeeds.text = @"Backup Seeds";
    }
    
    if ([str2FA isEqualToString:@"1"]){
        [_switchTwoFactor setOn:YES];
        _lblTwoFactor.text = @"Enable";
    }
    else{
        [_switchTwoFactor setOn:NO];
        _lblTwoFactor.text = @"Disable";
    }
    
    if ([strActivity isEqualToString:@"1"]){
        [_switchActivityLog setOn:YES];
        _lblActivityLog.text = @"Enable";
    }
    else{
        [_switchActivityLog setOn:NO];
        _lblActivityLog.text = @"Disable";
    }
    
    if ([strEmailVerify isEqualToString:@"1"]){
        [_switchEmailVerification setOn:YES];
        _lblEmailVerification.text = @"Enable";
    }
    else{
        [_switchEmailVerification setOn:NO];
        _lblEmailVerification.text = @"Disable";
    }

    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
   [self Maintenance];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self ApiGetUserSettings];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Maintenance) name:@"SecurityMaintain" object:nil];
    
}

-(void)Maintenance{
    
    NSDictionary *SettingMaintain = [[NSDictionary alloc]init];
    NSUserDefaults *userSecurityMaintain = [NSUserDefaults standardUserDefaults];
    SettingMaintain = [userSecurityMaintain objectForKey:@"userSecurityMaintain"];
    
    NSString *strMaintain = [NSString stringWithFormat:@"%@",[SettingMaintain valueForKey:@"status"]];
    
    if ([strMaintain isEqualToString:@"1"]) {
        _viewMaintenance.hidden = NO;
        _lblMaintenanceMessage.text = [SettingMaintain valueForKey:@"message"];
    }
    else{
        _viewMaintenance.hidden = YES;
    }
}

#pragma mark - keyboard movements

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    int allowedLength;
    switch(textField.tag) {
        case 1:
            allowedLength = 8;      // triggered for input fields with tag = 1
            break;
        default:
            allowedLength = 20;   // length default when no tag (=0) value =255
            break;
    }
    
    if (textField.text.length >= allowedLength && range.length == 0) {
        return NO; // Change not allowed
    } else {
        return YES; // Change allowed
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -keyboardSize.height;
        [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
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
    [_txtNewPassWord resignFirstResponder];
    [_txtConfirmPass resignFirstResponder];
    [_txtOldPassword resignFirstResponder];
    [_txtAuthCode resignFirstResponder];
    [_txtEnterPassword resignFirstResponder];
    [_txtTransPass resignFirstResponder];
    [_txtReEnterTransPass resignFirstResponder];
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

- (IBAction)onChangePasswordClicked:(id)sender {
    _viewPasswordUpdate.hidden = NO;
}

- (IBAction)onSwitch2FAClicked:(id)sender {
    if([sender isOn]){
        str2FAStatus = @"1";
    }
    else{
        str2FAStatus = @"2";
    }
    _view2FAUpdate.hidden = NO;
}

- (IBAction)onSwitchEmailVerificationClicked:(id)sender {
    if([sender isOn]){
        strEmailVerificationStatus = @"true";
        _lblEmailVerification.text = @"Enable";
    }
    else{
        strEmailVerificationStatus = @"false";
        _lblEmailVerification.text = @"Disable";
    }
    [self ApiUpdateEmail];
}

- (IBAction)onSwitchActivityLogsClicked:(id)sender {
    if([sender isOn]){
        strActivitySatus = @"true";
         _lblActivityLog.text = @"Enable";
    }
    else{
        strActivitySatus = @"false";
        _lblActivityLog.text = @"Disable";
    }
    [self ApiUpdateActivity];
}

- (IBAction)onHidePassClicked:(id)sender {
    _viewPasswordUpdate.hidden = YES;
    _view2FAUpdate.hidden = YES;
    _viewTransPass.hidden = YES;
}

- (IBAction)onUpdatePassClicked:(id)sender {
    if (_txtOldPassword.text.length == 0 || _txtNewPassWord.text.length == 0 || _txtConfirmPass.text.length == 0 || ![_txtNewPassWord.text isEqualToString:_txtConfirmPass.text]) {
        if (_txtOldPassword.text.length == 0 && _txtNewPassWord.text.length == 0 && _txtConfirmPass.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Information" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtOldPassword.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Old Password" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtNewPassWord.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter New Password" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtConfirmPass.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Confirm" closeButtonTitle:nil duration:0.0f];
        }
        else if(![_txtNewPassWord.text isEqualToString:_txtConfirmPass.text]){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"New Password and Confirm Password must be same" closeButtonTitle:nil duration:0.0f];
        }
    }
    else{
        [self ApiUpdatePassword];
    }
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

-(void)ApiUpdateEmail{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
      //  [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strEmailVerificationStatus,@"email_verification",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_UPDATE_EMAIL_VERIFICATION];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_UPDATE_EMAIL_VERIFICATION];
        strCallType = @"email";
    }
}

-(void)ApiUpdateActivity{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
      //  [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strActivitySatus,@"activity_log",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_UPDATE_ACTIVITY];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_UPDATE_ACTIVITY];
        strCallType = @"activity";
    }
}

-(void)ApiUpdatePassword{
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
                             _txtOldPassword.text,@"password",
                             _txtConfirmPass.text,@"newpassword",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_CHANGE_PASSWORD];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_CHANGE_PASSWORD];
        strCallType = @"password";
    }
}

-(void)ApiUpdate2FA{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSInteger status2fa;
        if ([str2FAStatus isEqualToString:@"1"]) {
            status2fa = 1;
        }
        else{
            status2fa = 2;
        }
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             str2FAStatus,@"type",
                             strQR,@"secret",
                             _txtEnterPassword.text,@"password",
                             _txtAuthCode.text,@"code",
                             nil];

        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_2FA];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_2FA];
        strCallType = @"2fa";
    }
}


-(void)ApiTransPass{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSInteger status2fa;
        if ([str2FAStatus isEqualToString:@"1"]) {
            status2fa = 1;
        }
        else{
            status2fa = 2;
        }
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             _txtTransPass.text,@"key",
                             nil];
        
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_TRANSACTION_PASS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_TRANSACTION_PASS];
        strCallType = @"transPass";
    }
}

-(void)ApiGenerateSeeds{
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
                             nil];
        
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_GENERATE_SEED];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_GENERATE_SEED];
        strCallType = @"GenerateSeeds";
    }
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

#pragma mark - ApiCallManagerDelegate

- (void)parserDidFailWithError:(NSError *)error andCallType:(CallTypeEnum)callType{
    self.view.userInteractionEnabled = YES;
    NSLog(@"%s : Error : %@",__FUNCTION__, [error localizedDescription]);
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
    
    if ([strCallType isEqualToString:@"email"]){
        if (callType == CALL_TYPE_UPDATE_EMAIL_VERIFICATION)
        {
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
    else if ([strCallType isEqualToString:@"activity"]){
        if (callType == CALL_TYPE_UPDATE_ACTIVITY)
        {
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
    else if ([strCallType isEqualToString:@"2fa"]){
        if (callType == CALL_TYPE_2FA)
        {
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                _view2FAUpdate.hidden = YES;
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
    else if ([strCallType isEqualToString:@"password"]){
        if (callType == CALL_TYPE_CHANGE_PASSWORD)
        {
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                _viewPasswordUpdate.hidden = YES;
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
    else if ([strCallType isEqualToString:@"transPass"]){
        if (callType == CALL_TYPE_TRANSACTION_PASS)
        {
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"message"]];
            if ([status isEqualToString:@"1"]) {
                [_switchTransPassword setOn:YES];
                _viewTransPass.hidden = YES;
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
            else if ([status isEqualToString:@"0"]){
                [_switchTransPassword setOn:NO];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
                }
            }
        }
    else if ([strCallType isEqualToString:@"GenerateSeeds"]){
        if (callType == CALL_TYPE_GENERATE_SEED)
        {
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"message"]];
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
            else if ([status isEqualToString:@"0"]){
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
        
     else if ([strCallType isEqualToString:@"userSettings"]){
            if (callType == CALL_TYPE_SETTINGS){
                NSLog(@"%@",[jsonRes valueForKey:@"data"]);
                NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
                if ([status isEqualToString:@"1"]) {
                    
                    dictUserSettings = [jsonRes valueForKey:@"data"];
                    UserSettings = [NSUserDefaults standardUserDefaults];
                    [UserSettings setObject:dictUserSettings forKey:@"usersettings"];
                    [UserSettings synchronize];
                    
                     NSString *strBackUp = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"user"] valueForKey:@"is_genrated"]];
                    
                    if ([strBackUp isEqualToString:@"1"]){
                        _btnBackUpSeeds.hidden = YES;
                        _lblBackUpSeeds.text = @"Generated";
                    }
                    else{
                        _btnBackUpSeeds.hidden = NO;
                        _lblBackUpSeeds.text = @"Backup Seeds";
                    }
                    
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

- (IBAction)onCopyClicked:(id)sender {
    UIPasteboard *pasteboard1 = [UIPasteboard generalPasteboard];
    pasteboard1.string = [NSString stringWithFormat:@"%@",strQR];
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor orangeColor];
    [self.view makeToast:@"Address Copied Successful."
                duration:3.0
                position:CSToastPositionBottom
                   style:style];
    
    [CSToastManager setSharedStyle:style];
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setQueueEnabled:YES];
}

- (IBAction)onUpdateAuthCicked:(id)sender {
    if (_txtEnterPassword.text.length == 0 || _txtAuthCode.text.length == 0) {
        if (_txtEnterPassword.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Please Enter Password" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtAuthCode.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Please Enter AuthCode" closeButtonTitle:nil duration:0.0f];
        }
    }
    else{
        [self keyboardWillHide];
        [self ApiUpdate2FA];
    }
}
- (IBAction)onSwitchTransClicked:(id)sender {
    _viewTransPass.hidden = NO;
}

- (IBAction)onEditTransPassClicked:(id)sender {
}

- (IBAction)onChangeTransPassClicked:(id)sender {
    if (_txtTransPass.text.length == 0 || _txtReEnterTransPass.text.length == 0 || _txtTransPass.text.length < 8) {
        if (_txtTransPass.text.length == 0 && _txtReEnterTransPass.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Please Enter Details" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtReEnterTransPass.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Please Re-Enter Password" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtTransPass.text.length == 0 ) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Please Enter Password" closeButtonTitle:nil duration:0.0f];
        }
        else if ( _txtTransPass.text.length < 8) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Password length must be greater than 8 characters" closeButtonTitle:nil duration:0.0f];
        }
    }
    else if (![_txtReEnterTransPass.text isEqualToString:_txtTransPass.text]) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Password not matched" closeButtonTitle:nil duration:0.0f];
    }
    else{
        [self keyboardWillHide];
        [self ApiTransPass];
    }
}

- (IBAction)onBackUpSeedsClicked:(id)sender {
    [self performSegueWithIdentifier:@"backup" sender:self];
    //[self ApiGenerateSeeds];
}

@end
