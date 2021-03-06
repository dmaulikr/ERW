//
//  RegisterViewController.m
//  ERW
//
//  Created by nestcode on 4/4/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    NSString *strToken, *strCallType;
    NSMutableDictionary *DictLoginData;
    NSString *osVersion ,*deviceName ,*appVersion;
    int pageCounter;
    CATransition *transition;
    int code1, code2, code3, code4;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     pageCounter = 0;
    
    if (IS_IPHONE_5){
        _imgDistance.constant = 0;
    }
    else{
        _imgDistance.constant = -25.0f;
    }
    
    _txtName.delegate = self;
    _txtEmail.delegate = self;
    _txtPassword.delegate = self;
    _txtCode1.delegate = self;
    _txtCode2.delegate = self;
    _txtCode3.delegate = self;
    _txtCode4.delegate = self;
    
    _viewSeeds.hidden = YES;
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    _viewName.layer.borderWidth = 0.5f;
    _viewName.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewEmail.layer.borderWidth = 0.5f;
    _viewEmail.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewPassword.layer.borderWidth = 0.5f;
    _viewPassword.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewCode1.layer.borderWidth = 0.5f;
    _viewCode1.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode2.layer.borderWidth = 0.5f;
    _viewCode2.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode3.layer.borderWidth = 0.5f;
    _viewCode3.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode4.layer.borderWidth = 0.5f;
    _viewCode4.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode5.layer.borderWidth = 0.5f;
    _viewCode5.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode6.layer.borderWidth = 0.5f;
    _viewCode6.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode7.layer.borderWidth = 0.5f;
    _viewCode7.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode8.layer.borderWidth = 0.5f;
    _viewCode8.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode9.layer.borderWidth = 0.5f;
    _viewCode9.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode10.layer.borderWidth = 0.5f;
    _viewCode10.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode11.layer.borderWidth = 0.5f;
    _viewCode11.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewCode12.layer.borderWidth = 0.5f;
    _viewCode12.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewSeeds1.layer.borderWidth = 0.5f;
    _viewSeeds1.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewSeeds2.layer.borderWidth = 0.5f;
    _viewSeeds2.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewSeeds3.layer.borderWidth = 0.5f;
    _viewSeeds3.layer.borderColor = [[UIColor grayColor]CGColor];
    _viewSeeds4.layer.borderWidth = 0.5f;
    _viewSeeds4.layer.borderColor = [[UIColor grayColor]CGColor];
    
    [self hideView];
    _view1.hidden = NO;
}

-(void)hideView{
    _view1.hidden = YES;
    _view2.hidden = YES;
    _view3.hidden = YES;
    _viewEnterSeeds.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [_txtCode2 resignFirstResponder];
    [_txtCode3 resignFirstResponder];
    [_txtCode4 resignFirstResponder];
    [_txtCode1 resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtName resignFirstResponder];
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


// Swipe View [ Left & Right Side ]
-(void)viewPages
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

// Swipe direction To Swipe
- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (pageCounter == 0) {
            pageCounter +=1;
            
        }
        else if (pageCounter == 1) {
            pageCounter +=1;
        }
        else if (pageCounter == 2){
            pageCounter +=1;
        }
        else if (pageCounter == 3) {
            pageCounter +=1;
        }
        transition = [CATransition animation];
        transition.duration = 1.0;//kAnimationDuration
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype =kCATransitionFromRight;
        transition.delegate = self;
        [_view1.layer addAnimation:transition forKey:nil];
        [_view2.layer addAnimation:transition forKey:nil];
        [_view3.layer addAnimation:transition forKey:nil];
        [_viewEnterSeeds.layer addAnimation:transition forKey:nil];
        [self pagination:pageCounter];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (pageCounter ==0)
        {
            pageCounter =0;
        }
        else
        {
            pageCounter -=1;
            // _pageController.currentPage = pageCounter;
            transition = [CATransition animation];
            transition.duration = 0.9;//kAnimationDuration
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype =kCATransitionFromLeft;
            transition.delegate = self;
            
            [_view1.layer addAnimation:transition forKey:nil];
            [_view2.layer addAnimation:transition forKey:nil];
            [_view3.layer addAnimation:transition forKey:nil];
            [_viewEnterSeeds.layer addAnimation:transition forKey:nil];
        }
    }
    [self pagination:pageCounter];
}

- (void)pagination:(int)count{
    switch (count) {
        case 0:
            [self hideView];
            _view1.hidden = NO;
            break;
        case 1:
            [self hideView];
            _view2.hidden = NO;
            break;
        case 2:
            [self hideView];
            _view3.hidden = NO;
            break;
        case 3:
            code1 = 1+arc4random_uniform((uint32_t)(3 - 1 + 1));
            code2 = 4+arc4random_uniform((uint32_t)(6 - 4 + 1));
            code3 = 7+arc4random_uniform((uint32_t)(9 - 7 + 1));
            code4 = 10+arc4random_uniform((uint32_t)(12 - 10 + 1));
            
            NSLog(@"%d %d %d %d",code1,code2,code3,code4);
            
            _lblSeeds1.text = [NSString stringWithFormat:@"  CODE %d",code3];
            _lblSeeds2.text = [NSString stringWithFormat:@"  CODE %d",code1];
            _lblSeeds3.text = [NSString stringWithFormat:@"  CODE %d",code4];
            _lblSeeds4.text = [NSString stringWithFormat:@"  CODE %d",code2];
            
            [self hideView];
            _viewEnterSeeds.hidden = NO;
        default:
            break;
    }
}

- (IBAction)onBackClicked:(id)sender {
    if (pageCounter ==0)
    {
        pageCounter =0;
    }
    else
    {
        pageCounter -=1;
        // _pageController.currentPage = pageCounter;
        transition = [CATransition animation];
        transition.duration = 0.9;//kAnimationDuration
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype =kCATransitionFromLeft;
        transition.delegate = self;
        
        [_view1.layer addAnimation:transition forKey:nil];
        [_view2.layer addAnimation:transition forKey:nil];
        [_view3.layer addAnimation:transition forKey:nil];
        [_viewEnterSeeds.layer addAnimation:transition forKey:nil];
    }
    [self pagination:pageCounter];
}

- (IBAction)onNextClicked:(id)sender {
    if (pageCounter == 0) {
        pageCounter +=1;
        [self GoAhead];
    }
    else if (pageCounter == 1) {
        pageCounter +=1;
        [self GoAhead];
    }
    else if (pageCounter == 2){
        
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"I've Written" validationBlock:^BOOL{
            return YES;
           
        } actionBlock:^{
            pageCounter +=1;
            [self GoAhead];
        }];
        
        [alert showEdit:self title:@"Alert" subTitle:@"Have You Written All 12 Backup Seeds? If not Please Go Back and Write Because If You Go Ahead You Won't Able to Go Back To Write BackUp Seeds!" closeButtonTitle:@"Go Back" duration:0];

        
    }
    else if (pageCounter == 3) {
        pageCounter +=1;
        [self GoAhead];
    }
    
}

-(void)GoAhead{
    transition = [CATransition animation];
    transition.duration = 1.0;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype =kCATransitionFromRight;
    transition.delegate = self;
    [_view1.layer addAnimation:transition forKey:nil];
    [_view2.layer addAnimation:transition forKey:nil];
    [_view3.layer addAnimation:transition forKey:nil];
    [_viewEnterSeeds.layer addAnimation:transition forKey:nil];
    [self pagination:pageCounter];
}

- (IBAction)onSubmitAndRegisterClicked:(id)sender {
    if (_txtCode1.text.length == 0 || _txtCode2.text.length == 0 || _txtCode3.text.length == 0 || _txtCode4.text.length == 0) {
        if (_txtCode1.text.length == 0 && _txtCode2.text.length == 0 && _txtCode3.text.length == 0 && _txtCode4.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter All Codes" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtCode1.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Codes" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtCode2.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Codes" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtCode3.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Codes" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtCode4.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Codes" closeButtonTitle:nil duration:0.0f];
        }
    }
    else{
        [self ApiRegister];
    }
}

- (IBAction)onLoginClicked:(id)sender {
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

- (IBAction)onRegisterClicked:(id)sender {
    if (_txtName.text.length == 0 || _txtEmail.text.length == 0 || _txtPassword.text.length == 0) {
        if (_txtName.text.length == 0 && _txtEmail.text.length == 0 && _txtPassword.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Details" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtName.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Name to Continue" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtEmail.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Email Address" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtPassword.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Password" closeButtonTitle:nil duration:0.0f];
        }
    }
    else if (_txtPassword.text.length < 5) {
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Password Must be more than 6 digits" closeButtonTitle:nil duration:0.0f];
    }
    else{
        [self ApiRegister];
    }
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

-(void)ApiSeeds{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             _txtEmail.text, @"email",
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
        strCallType = @"seeds";
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

-(void)ApiRegister{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        NSString *strCode1 = [NSString stringWithFormat:@"%d",code1];
        NSString *strCode2 = [NSString stringWithFormat:@"%d",code2];
        NSString *strCode3 = [NSString stringWithFormat:@"%d",code3];
        NSString *strCode4 = [NSString stringWithFormat:@"%d",code4];
        
        NSDictionary *dictSeeds = [[NSDictionary alloc] initWithObjectsAndKeys:
                             _txtCode1.text,strCode3,
                             _txtCode2.text,strCode1,
                             _txtCode3.text,strCode4,
                             _txtCode4.text,strCode2,
                             nil];
        
      //  NSString *strSeedString = [NSString stringWithFormat:@"%@",dictSeeds];
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictSeeds options:0 error:nil];
        NSString * strSeedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             _txtEmail.text, @"email",
                             _txtName.text,@"name",
                             _txtPassword.text,@"password",
                   //          strSeedString,@"seed",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_REGISTER];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_REGISTER];
        strCallType = @"register";
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
    else if ([strCallType isEqualToString:@"seeds"]) {
        if (callType == CALL_TYPE_GENERATE_SEED){
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            NSLog(@"%@",status);
            if ([status isEqualToString:@"1"]) {
                
                NSString *strSeed = [jsonRes valueForKey:@"message"];
                
                NSArray *arrSeeds = [strSeed componentsSeparatedByString:@" "];
                
                NSLog(@"%@",arrSeeds);
                
                _lblCode1.text = [arrSeeds objectAtIndex:0];
                _lblCode2.text = [arrSeeds objectAtIndex:1];
                _lblCode3.text = [arrSeeds objectAtIndex:2];
                _lblCode4.text = [arrSeeds objectAtIndex:3];
                _lblCode5.text = [arrSeeds objectAtIndex:4];
                _lblCode6.text = [arrSeeds objectAtIndex:5];
                _lblCode7.text = [arrSeeds objectAtIndex:6];
                _lblCode8.text = [arrSeeds objectAtIndex:7];
                _lblCode9.text = [arrSeeds objectAtIndex:8];
                _lblCode10.text = [arrSeeds objectAtIndex:9];
                _lblCode11.text = [arrSeeds objectAtIndex:10];
                _lblCode12.text = [arrSeeds objectAtIndex:11];
                
                _viewSeeds.hidden = NO;
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"register"]) {
        if (callType == CALL_TYPE_REGISTER){
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            NSLog(@"%@",status);
            if ([status isEqualToString:@"1"]) {
                _viewSeeds.hidden = YES;

                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
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
}


- (IBAction)onCloseClicked:(id)sender {
    _viewSeeds.hidden = YES;
    pageCounter = 0;
    [self GoAhead];
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
