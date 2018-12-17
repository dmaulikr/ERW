//
//  BackupSeedsViewController.m
//  ERW
//
//  Created by nestcode on 7/6/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "BackupSeedsViewController.h"
#define CTitlePadding   15

@interface BackupSeedsViewController ()

@end

@implementation BackupSeedsViewController{
    int i;
    NSUserDefaults *UserSettings, *UserToken, *UserUDID;
    NSDictionary *dictUserSettings;
    NSString *str2FAStatus, *strEmailVerificationStatus, *strActivitySatus, *strCallType, *strToken, *strUDID, *strQR;
    NSUserDefaults *isLogin;
    NSMutableArray *arrSeeds,*arrSeedsCopy, *arrSelectedSeeds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 0;
    
    arrSeeds = [[NSMutableArray alloc]init];
    arrSeedsCopy = [[NSMutableArray alloc]init];
    arrSelectedSeeds = [[NSMutableArray alloc]init];
    
    _txtPassword.delegate = self;
    
    _btnSubmit.enabled = NO;
    
    _btnClose.hidden = YES;
    _viewWriteSeeds.hidden = YES;
    _viewNoScreenShot.hidden = YES;
    _viewWriteSeedsScreen.hidden = YES;
    _viewNoteSeeds.hidden = YES;
    
    _viewPassword.layer.borderWidth = 0.5f;
    _viewPassword.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    
    UserToken = [NSUserDefaults standardUserDefaults];
    UserUDID = [NSUserDefaults standardUserDefaults];
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
    MICollectionViewBubbleLayout *layout = [[MICollectionViewBubbleLayout alloc] initWithDelegate:self];
    [layout setMinimumLineSpacing:6.0f];
    [layout setMinimumInteritemSpacing:6.0f];
    
    [_collectionSeeds setCollectionViewLayout:layout];
    _collectionSeeds.allowsMultipleSelection = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
    [_txtPassword resignFirstResponder];
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


- (IBAction)onCheckMarkClicked:(id)sender {
    if (i == 0) {
        _imgCheckMark.image = [UIImage imageNamed:@"checked.png"];
        // [_btnChecked1 setBackgroundImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        
        i = 1;
    }
    else if(i == 1){
        _imgCheckMark.image = [UIImage imageNamed:@"check_empty.png"];
        // [_btnChecked1 setBackgroundImage:[UIImage imageNamed:@"check_empty.png"] forState:UIControlStateNormal];
        i = 0;
    }
}

- (IBAction)onGenerateSeedsClicked:(id)sender {
    if (i == 0) {
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        style.messageColor = [self colorWithHexString:ThemeColor];
        style.backgroundColor = [UIColor whiteColor];
        [self.view makeToast:@"Please check checkbox"
                    duration:3.0
                    position:CSToastPositionBottom
                       style:style];
        
        [CSToastManager setSharedStyle:style];
        [CSToastManager setTapToDismissEnabled:YES];
        [CSToastManager setQueueEnabled:YES];
    }
    else{
        _btnClose.hidden = NO;
        _viewNoScreenShot.hidden = NO;
    }
}



- (IBAction)onCloseNoSSClicked:(id)sender {
    _btnClose.hidden = YES;
    _viewNoScreenShot.hidden = YES;
}

- (IBAction)onUnderstandClicked:(id)sender {
    _btnClose.hidden = YES;
    _viewWriteSeeds.hidden = NO;
    _viewNoScreenShot.hidden = YES;
    _viewNoteSeeds.hidden = NO;
}


- (IBAction)onIWrittenClicedk:(id)sender {
    _viewWriteSeedsScreen.hidden = NO;
}

- (IBAction)onExitClicked:(id)sender {
    _viewWriteSeeds.hidden = YES;
    _viewNoScreenShot.hidden = YES;
    _viewNoteSeeds.hidden = YES;
}

- (IBAction)onVerifyClicked:(id)sender {
    if (_txtPassword.text.length == 0) {
        
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"Please Enter Password" closeButtonTitle:nil duration:0.0f];
        
    }
    else{
        [_txtPassword resignFirstResponder];
        [self keyboardWillHide];
        [self ApiGenerateSeeds];
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
                             _txtPassword.text,@"password",
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

-(void)ApiSubmitSeeds{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:arrSelectedSeeds options:0 error:nil];
        NSString *strSeedString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strSeedString,@"seed",
                             nil];
        
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_STORE_SEEDS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_STORE_SEEDS];
        strCallType = @"SelectedSeeds";
    }
}

#pragma mark -
#pragma mark - UICollectionView Delegate & Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arrSeeds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *indentifier = @"SeedsCollectionViewCell";
    SeedsCollectionViewCell *cell = [_collectionSeeds dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    [cell.lblSeedName setText:[arrSeeds objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark -
#pragma mark - MICollectionViewBubbleLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView itemSizeAtIndexPath:(NSIndexPath *)indexPath {
    
        NSString *title = [arrSeeds objectAtIndex:indexPath.row];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]}];
        size.width = ceilf(size.width + CTitlePadding * 2);
        size.height = 30;
        
        if (size.width > collectionView.frame.size.width)
            size.width = collectionView.frame.size.width;
        return size;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str_valueis = [arrSeeds objectAtIndex:indexPath.row];
    [self Seeds:1:str_valueis];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *str_valueis = [arrSeeds objectAtIndex:indexPath.row];
    [self Seeds:0:str_valueis];
}
-(void)Seeds:(int)flag :(NSString*)strvalue
{
    NSString *str = strvalue;
    
    if (flag == 0)
    {
        if (arrSelectedSeeds.count == 0)
        {
            [arrSelectedSeeds removeAllObjects];
        }
        else
        {
            for (int i=0; i<[arrSelectedSeeds count]; i++)
            {
                if ([arrSelectedSeeds containsObject:str])
                {
                    [arrSelectedSeeds removeObject:str];
                    NSLog(@"%@ is Exist",str);
                    break;
                }
            }
        }
    }
    else
    {
        if (arrSelectedSeeds.count == 0)
        {
            [arrSelectedSeeds insertObject:str atIndex:[arrSelectedSeeds count]];
        }
        else
        {
            for (int i=0; i<[arrSelectedSeeds count]; i++)
            {
                if ([arrSelectedSeeds containsObject:str])
                {
                    break;
                }
                else{
                    [arrSelectedSeeds insertObject:str atIndex:[arrSelectedSeeds count]];
                    break;
                }
            }
        }
    }
    _lblWrittenSeeds.text = [arrSelectedSeeds componentsJoinedByString:@"  "];
    if (arrSelectedSeeds.count == 12) {
        _btnSubmit.enabled = YES;
    }
    else{
        _btnSubmit.enabled = NO;
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
        
        if ([strCallType isEqualToString:@"GenerateSeeds"]){
            if (callType == CALL_TYPE_GENERATE_SEED)
            {
                NSLog(@"%@",[jsonRes valueForKey:@"data"]);
                NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
                if ([status isEqualToString:@"1"]) {
                    arrSeeds = [jsonRes valueForKey:@"data"];
                    arrSeedsCopy = [jsonRes valueForKey:@"data"];
                    _lblSeeds.text = [arrSeeds componentsJoinedByString:@"  "];
                    _btnWriteSeedsClose.hidden = YES;
                    _viewEnterPassword.hidden = YES;
                    
                    [self shuffle];
                    [_collectionSeeds reloadData];
                }
            }
        }
        else if ([strCallType isEqualToString:@"SelectedSeeds"]){
            if (callType == CALL_TYPE_STORE_SEEDS)
            {
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
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }
        }
    }
}

- (void)shuffle
{
    NSUInteger count = [arrSeeds count];
    if (count <= 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [arrSeeds exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}


- (IBAction)onSubmitBackUpClicked:(id)sender {
    [self ApiSubmitSeeds];
}

- (IBAction)btnSubmit:(id)sender {
}
@end
