//
//  LoginViewController.m
//  ERW
//
//  Created by nestcode on 4/4/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    NSString *strToken, *strCallType;
    NSMutableDictionary *DictLoginData;
    NSString *osVersion, *deviceName, *appVersion;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    _txtWalletID.delegate = self;
    _txtPassword.delegate = self;
    
    _viewWalletID.layer.borderWidth = 0.5f;
    _viewWalletID.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    _viewPassword.layer.borderWidth = 0.5f;
    _viewPassword.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark - keyboard movements

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
    [_txtPassword resignFirstResponder];
    [_txtWalletID resignFirstResponder];
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

- (IBAction)onScanClicked:(id)sender {
    DYQRCodeDecoderViewController *vc = [[DYQRCodeDecoderViewController alloc] initWithCompletion:^(BOOL succeeded, NSString *result) {
        if (succeeded) {
            strToken = result;
            NSUserDefaults *UserToken = [NSUserDefaults standardUserDefaults];
            [UserToken setValue:strToken forKey:@"userToken"];
            [UserToken synchronize];
            [self ApiLogin];
        }
    }];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:NULL];
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
    [SVProgressHUD dismiss];
    self.view.userInteractionEnabled = YES;
}

- (NSString*)deviceModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
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

-(void)ApiForLogin{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        osVersion = [NSString stringWithFormat:@"iOS %@", [[UIDevice currentDevice] systemVersion] ];
        deviceName = [self deviceModelName];
        appVersion = [NSString stringWithFormat:@"App Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        NSString *strdeviceUDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSUserDefaults *UserUDID = [NSUserDefaults standardUserDefaults];
        [UserUDID setValue:strdeviceUDID forKey:@"userUDID"];
        [UserUDID synchronize];
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             deviceName, @"deviceName",
                             strdeviceUDID,@"device",
                             osVersion,@"deviceOs",
                             _txtWalletID.text,@"wallet",
                             _txtPassword.text,@"password",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_LOGIN_X];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_LOGIN_X];
        strCallType = @"loginX";
    }
}


-(void)ApiLogin{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        osVersion = [NSString stringWithFormat:@"iOS %@", [[UIDevice currentDevice] systemVersion] ];
        deviceName = [self deviceModelName];
        appVersion = [NSString stringWithFormat:@"App Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        NSString *strdeviceUDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSUserDefaults *UserUDID = [NSUserDefaults standardUserDefaults];
        [UserUDID setValue:strdeviceUDID forKey:@"userUDID"];
        [UserUDID synchronize];
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             deviceName, @"deviceName",
                             strdeviceUDID,@"device",
                             strToken,@"token",
                             osVersion,@"deviceOs",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_LOGIN];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
       // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_LOGIN];
        strCallType = @"login";
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
    
    DictLoginData = [[NSMutableDictionary alloc]init];
    if ([strCallType isEqualToString:@"login"]) {
        if (callType == CALL_TYPE_LOGIN){
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            NSLog(@"%@",status);
            if ([status isEqualToString:@"1"]) {
                
                NSUserDefaults *isLogin = [NSUserDefaults standardUserDefaults];
                [isLogin setInteger:1 forKey:@"isLogin"];
                [isLogin synchronize];
                
                NSUserDefaults *UserDictData = [NSUserDefaults standardUserDefaults];
                [UserDictData setObject:jsonRes forKey:@"userdata"];
                [UserDictData synchronize];
                [self performSegueWithIdentifier:@"LoginToHome" sender:self];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"loginX"]) {
        if (callType == CALL_TYPE_LOGIN_X){
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            NSLog(@"%@",status);
            if ([status isEqualToString:@"1"]) {
                
                //token
                
                strToken = [NSString stringWithFormat:@"%@",[[jsonRes objectForKey:@"data"]valueForKey:@"token"]];
                
                NSUserDefaults *UserToken = [NSUserDefaults standardUserDefaults];
                [UserToken setValue:strToken forKey:@"userToken"];
                [UserToken synchronize];
                
                NSUserDefaults *isLogin = [NSUserDefaults standardUserDefaults];
                [isLogin setInteger:1 forKey:@"isLogin"];
                [isLogin synchronize];
                
                NSUserDefaults *UserDictData = [NSUserDefaults standardUserDefaults];
                [UserDictData setObject:jsonRes forKey:@"userdata"];
                [UserDictData synchronize];
                [self performSegueWithIdentifier:@"LoginToHome" sender:self];
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

- (IBAction)onLoginClicked:(id)sender {
    if (_txtWalletID.text.length == 0 || _txtPassword.text.length == 0) {
        if (_txtWalletID.text.length == 0 || _txtPassword.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Details" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtWalletID.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Wallet ID" closeButtonTitle:nil duration:0.0f];
        }
        else if ( _txtPassword.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Password" closeButtonTitle:nil duration:0.0f];
        }
    }
    else{
        [self ApiForLogin];
    }
}

- (IBAction)onShowPasswordClicked:(id)sender {
    if (_btnShowPass.selected)
    {
        _btnShowPass.selected = NO;
        _txtPassword.secureTextEntry = YES;
        if (_txtPassword.isFirstResponder) {
            [_txtPassword resignFirstResponder];
            [_txtPassword becomeFirstResponder];
        }
    }
    else
    {
        _btnShowPass.selected = YES;
        _txtPassword.secureTextEntry = NO;
        if (_txtPassword.isFirstResponder) {
            [_txtPassword resignFirstResponder];
            [_txtPassword becomeFirstResponder];
        }
    }
}

@end
