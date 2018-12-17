//
//  SendViewController.m
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "SendViewController.h"


@interface SendViewController ()

@end

//0, 52, uiview.width, 35

@implementation SendViewController{
    BOOL isOut;
    NSUserDefaults *userArrColors, *userSelectedIndex, *UserToken, *UserDictData, *UserUDID, *userAccounts, *userCurrency;
    NSString *strFrom, *strTo, *strAmountUSD, *strToken, *strNote, *strAmount;
    NSString *strUDID, *strCallType, *strOffset, *strLimit, *strFilter, *strCoin, *strSearch, *strAccount, *strCoinID, *str2FA, *strEmailVerify;
    NSMutableArray *arrColors, *arrAccounts, *arrTokenData, *arrNames;
    NSInteger btnSelected;
    BOOL isExpanded;
    NSInteger TokenPressed;
    NSMutableDictionary *dictUserData;
    NSString *strUSD, *strERO, *strMinSend, *strMaxSend;
    double intMin, intMax, intUSD, intBTC, intERO, isMax, isMin;
    double amount, amountUSD, amountERO;
    UIToolbar *Cat_toolbar;
    NSUserDefaults *UserSettings;
    NSDictionary *dictUserSettings;
    NSString *strPassword, *str2FACode, *strEmailCode, *strFromID, *strTOAddress;
    NSString *strWalletCurrency;
    NSUserDefaults *UserWalletCurrency;
    NSString *strTransPass;
    NSUserDefaults *userSelectedCurrIndex, *userSelectedCurr;
    NSInteger currIndex;
    NSString *strSelectedCurr;
    NSMutableArray *arrSearchData;
    NSArray *arrSearchResult;
    BOOL searchEnabled;
    NSUserDefaults *isLogin;
    int isMaintain;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SEND";
    
    _viewMaintenance.hidden = YES;
    
    arrSearchResult = [[NSArray alloc]init];
    arrSearchData = [[NSMutableArray alloc]init];
    
    userSelectedCurrIndex = [NSUserDefaults standardUserDefaults];
    userSelectedCurr = [NSUserDefaults standardUserDefaults];
    
    currIndex = [userSelectedCurrIndex integerForKey:@"userSelectedCurrIndex"];
    strSelectedCurr = [[userSelectedCurr valueForKey:@"userSelectedCurr"] lowercaseString];
    
    _viewVerification.hidden = YES;
    UserSettings = [NSUserDefaults standardUserDefaults];
    dictUserSettings = [[NSDictionary alloc]init];
    dictUserSettings = [UserSettings objectForKey:@"usersettings"];
    
    str2FA = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"user"] valueForKey:@"is_2fa"]];
    
    strTransPass = [NSString stringWithFormat:@"%@",[[dictUserSettings objectForKey:@"transaction"] valueForKey:@"status"]];
    
    strEmailVerify = [NSString stringWithFormat:@"%@",[dictUserSettings valueForKey:@"email_verification"]];
    
    UserWalletCurrency = [NSUserDefaults standardUserDefaults];
    strWalletCurrency = [UserWalletCurrency valueForKey:@"walletCurrency"];
    if ([strWalletCurrency isEqualToString:@""]) {
        strWalletCurrency = @"USD";
    }
    
    _lblCurrency.text = [NSString stringWithFormat:@" %@",strWalletCurrency];
    
    strCoin = @"";
    _viewTokens.hidden = YES;
    
    _txtTo.delegate = self;
    _txtCurrency.delegate = self;
    _txtERO.delegate = self;
    _txtNote.delegate = self;
    _txt2FAverifyCode.delegate = self;
    _txtPassword.delegate = self;
    _txtEmailVerify.delegate = self;
    
    NSLog(@"%@",_dictACData);
    
    strAccount = [NSString stringWithFormat:@"%@",[_dictACData valueForKey:@"_id"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.viewToken addGestureRecognizer:tap];
    [self.viewEro addGestureRecognizer:tap];
    [self.viewTo addGestureRecognizer:tap];
    [self.viewFrom addGestureRecognizer:tap];
    [self.viewCurrency addGestureRecognizer:tap];
    [self.viewNote addGestureRecognizer:tap];
    
    Cat_toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [Cat_toolbar setBarStyle:UIBarStyleBlackTranslucent];
    
   // UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)];
    
    UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    Cat_toolbar.items = @[flexibleButton,flexibleButton,doneButton];
    
    doneButton.tintColor = [UIColor whiteColor];
   
    _txtCurrency.inputAccessoryView = Cat_toolbar;
    _txtERO.inputAccessoryView = Cat_toolbar;
    
    [_txtERO addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
    
    [_txtCurrency addTarget:self
                     action:@selector(textFieldDidChange:)
           forControlEvents:UIControlEventEditingChanged];
    
    
    userSelectedIndex = [NSUserDefaults standardUserDefaults];
    userCurrency = [NSUserDefaults standardUserDefaults];
    UserDictData = [NSUserDefaults standardUserDefaults];
    UserToken = [NSUserDefaults standardUserDefaults];
    dictUserData = [[NSMutableDictionary alloc]init];
    UserUDID = [NSUserDefaults standardUserDefaults];
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    dictUserData = [UserDictData objectForKey:@"userdata"];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
     _tableTokens.tableFooterView = [UIView new];
    
   // [self APITokens];
    
    _viewToken.layer.borderWidth = 0.5f;
    _viewToken.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewTo.layer.borderWidth = 0.5f;
    _viewTo.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];;
    
    _viewFrom.layer.borderWidth = 0.5f;
    _viewFrom.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewCurrency.layer.borderWidth = 0.5f;
    _viewCurrency.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewEro.layer.borderWidth = 0.5f;
    _viewEro.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewNote.layer.borderWidth = 0.5f;
    _viewNote.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewPassword.layer.borderWidth = 0.5f;
    _viewPassword.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _viewEmail.layer.borderWidth = 0.5f;
    _viewEmail.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    _view2FA.layer.borderWidth = 0.5f;
    _view2FA.layer.borderColor = [[UIColor colorWithRed:97.0f/255.0f green:98.0f/255.0f blue:165.0f/255.0f alpha:1]CGColor];
    
    arrAccounts = [[NSMutableArray alloc]init];
    userAccounts = [NSUserDefaults standardUserDefaults];
    arrAccounts = [userAccounts objectForKey:@"userAccounts"];
    
    userArrColors = [NSUserDefaults standardUserDefaults];
    arrColors = [userArrColors objectForKey:@"colors"];
    
    [self APIAccountBalances];
    
    [self Maintenance];
}

- (IBAction)onCloseClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Maintenance) name:@"SendMaintain" object:nil];
    
}

-(void)Maintenance{
    
    NSDictionary *SettingMaintain = [[NSDictionary alloc]init];
    NSUserDefaults *userSendMaintain = [NSUserDefaults standardUserDefaults];
    SettingMaintain = [userSendMaintain objectForKey:@"userSendMaintain"];
    
    NSString *strMaintain = [NSString stringWithFormat:@"%@",[SettingMaintain valueForKey:@"status"]];
    
    if ([strMaintain isEqualToString:@"1"]) {
        _viewMaintenance.hidden = NO;
        _lblMaintenanceMessage.text = [SettingMaintain valueForKey:@"message"];
    }
    else{
        _viewMaintenance.hidden = YES;
    }
}

- (IBAction)onShowClicked:(id)sender {
   
}

#pragma mark - keyboard movements

-(void) textFieldDidChange:(id)sender{
    if ([_txtCurrency isFirstResponder]) {
        if (_txtCurrency.text.length == 0) {
            _txtERO.text = @"0";
        }
        else{
            double a,b;
            a=0;
            b=0;
            a = [_txtCurrency.text doubleValue];
            b = (a/amount);
            NSLog(@"%f",b);
            intMin = b;
            _txtERO.text = [NSString stringWithFormat:@"%.6f",b];
        }
    }
    else if ([_txtERO isFirstResponder]){
        if (_txtERO.text.length == 0) {
            _txtCurrency.text = @"0";
        }
        else{
            double c,d;
            c=0;
            d=0;
            c = [_txtERO.text doubleValue];
            intMin = c;
            d = (c*amount);
            NSLog(@"%f",d);
            _txtCurrency.text = [NSString stringWithFormat:@"%.6f",d];
            
        }
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
    [_txtNote resignFirstResponder];
    [_txtERO resignFirstResponder];
    [_txtCurrency resignFirstResponder];
    [_txtTo resignFirstResponder];
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


#pragma mark CollectioView - Data

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (btnSelected == 2) {
        return arrAccounts.count+1;
    }
    return [arrAccounts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (btnSelected == 2) {
        if (indexPath.row == 0) {
            static NSString *identifier = @"firstCell";
            
            AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            
            [cell.btnScanQR addTarget:self action:@selector(ScanQR:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
        else{
        static NSString *identifier = @"accountCell";
        
        AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSDictionary *dictTemp = [arrAccounts objectAtIndex:indexPath.row-1];
        
        [cell.viewBack setBackgroundColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row-1]]];
        cell.lblAccountName.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
        cell.lblEroPrice.text = [NSString stringWithFormat:@"%@ %@",[dictTemp valueForKey:@"balance"],[dictTemp valueForKey:@"symbol"]];
        return cell;
        }
    }
    else{
        static NSString *identifier = @"accountCell";
        
        AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        NSDictionary *dictTemp = [arrAccounts objectAtIndex:indexPath.row];
        
        [cell.viewBack setBackgroundColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        cell.lblAccountName.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
        cell.lblEroPrice.text = [NSString stringWithFormat:@"%@ %@",[dictTemp valueForKey:@"balance"],[dictTemp valueForKey:@"symbol"]];
        
        return cell;
    }
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (btnSelected == 2) {
        if (indexPath.row == 0) {
            DYQRCodeDecoderViewController *vc = [[DYQRCodeDecoderViewController alloc] initWithCompletion:^(BOOL succeeded, NSString *result) {
                if (succeeded) {
                    strTo = result;
                }
            }];
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:NULL];
        }
        else{
            NSDictionary *dictTemp = [arrAccounts objectAtIndex:indexPath.row-1];
            strTo = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"address"]];
            
            [_lblAccountFrom setTextColor:[UIColor blackColor]];
            _txtTo.text = strTo;
            _lblToAccountNAme.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
        }
        [UIView beginAnimations:@"AccountViewSlide" context:nil];
        [UIView setAnimationDuration:0.7];
        
        if (isOut)
        {
            _viewBottom.frame = CGRectMake(self.view.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
            isOut = NO;
        }
        else
        {
            _viewBottom.frame = CGRectMake(self.view.frame.size.width - _viewBottom.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
            
            isOut = YES;
        }
        [UIView commitAnimations];
    }
    else{
    NSDictionary *dictTemp = [arrAccounts objectAtIndex:indexPath.row];
    strFrom = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"address"]];
    _lblAccountName.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
    [_lblAccountFrom setTextColor:[UIColor blackColor]];
    _lblAccountFrom.text = strFrom;
        strAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
        [self APIAccountBalances];
    
    [UIView beginAnimations:@"EditViewSlide" context:nil];
    [UIView setAnimationDuration:0.7];
        
        [_lblTo setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblEro setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblFrom setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblNote setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblToken setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblCurrency setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblPassword setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lbl2FAVerify setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_lblEmailVerify setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
       // [_lblToAccountNAme setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_navBar setBarTintColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_viewHeader setBackgroundColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_btnSEND setBackgroundColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
        [_btnSendTransactions setBackgroundColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
    
    if (isOut)
    {
        _viewBottom.frame = CGRectMake(self.view.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
        isOut = NO;
    }
    else
    {
        _viewBottom.frame = CGRectMake(self.view.frame.size.width - _viewBottom.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
        
        isOut = YES;
    }
        [UIView commitAnimations];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((166), (100));
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searchEnabled) {
        return  arrSearchData.count;
    }
    else{
        return arrTokenData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TokenDataTableViewCell *cell = [self.tableTokens dequeueReusableCellWithIdentifier:@"TokenDataTableViewCell" forIndexPath:indexPath];

    NSDictionary *dictTemp = [[NSDictionary alloc]init];
    
    if (searchEnabled) {
        dictTemp = [arrSearchData objectAtIndex:indexPath.row];
    }
    else{
        dictTemp = [arrTokenData objectAtIndex:indexPath.row];
    }

    cell.lblTokenNAme.text = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"name"]];

    NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];

    NSString *strBTC = [NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"balance"]];
    cell.lblBTCBalance.text = strBTC;
    
    NSString *strUSD = [NSString stringWithFormat:@"$%@",[[dictTemp objectForKey:@"market"]valueForKey:@"usd"]];
    cell.lblUSDBalance.text = strUSD;
    
 /*   if ([strWalletCurrency isEqualToString:@"USD"]) {
        NSString *strUSD = [NSString stringWithFormat:@"$%@",[[dictTemp objectForKey:@"market"]valueForKey:@"usd"]];
        cell.lblUSDBalance.text = strUSD;
    }
    else{
        NSString *strUSD = [NSString stringWithFormat:@"฿%@",[[dictTemp objectForKey:@"market"]valueForKey:@"btc"]];
        cell.lblUSDBalance.text = strUSD;
    }*/
    
    [cell.imgToken sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [cell.imgToken updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.imgToken reveal];
    }];
    return cell;
    
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
        dictTemp = [arrTokenData objectAtIndex:indexPath.row];
    }
    
    strCoinID = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"_id"]];
    strCoin = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"symbol"]];
    _txtToken.text = strCoin;
    _lblEro.text = [NSString stringWithFormat:@" %@",strCoin];
    strERO = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"name"]];

    //  if ([strWalletCurrency isEqualToString:@"USD"]) {
    strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"]valueForKey:@"usd"]];

    if ([strUSD isEqualToString:@"0"]) {
        _txtCurrency.hidden = YES;
        _viewEroDistance.constant = 8;
    }
    else{
        _txtCurrency.hidden = NO;
        _viewEroDistance.constant = 76;
    }

    amount = [strUSD doubleValue];
    NSString* formattedNumber = [NSString stringWithFormat:@"%.6f", amount];
    amount = [formattedNumber doubleValue];
    //    }
    //    else{
    //        strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"]valueForKey:@"btc"]];
    //        amount = [strUSD doubleValue];
    //    }

    strMinSend = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"min_send"]];

    isMin = [strMinSend doubleValue];

    strMaxSend = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"max_send"]];

    isMax = [strMaxSend doubleValue];

    _viewTokens.hidden = YES;
    isOut = NO;
}

- (void)ScanQR:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collectionAccounts];
    NSIndexPath *indexPath = [_collectionAccounts indexPathForItemAtPoint:buttonPosition];
    NSLog(@"%ld Pressed",(long)indexPath.row);
    
    DYQRCodeDecoderViewController *vc = [[DYQRCodeDecoderViewController alloc] initWithCompletion:^(BOOL succeeded, NSString *result) {
        if (succeeded) {
            NSLog(@"%@",result);
            _txtTo.text = result;
            
            [UIView beginAnimations:@"AccountViewSlide" context:nil];
            [UIView setAnimationDuration:0.7];
            
            if (isOut)
            {
                _viewBottom.frame = CGRectMake(self.view.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
                isOut = NO;
            }
            else
            {
                _viewBottom.frame = CGRectMake(self.view.frame.size.width - _viewBottom.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
                
                isOut = YES;
            }
            [UIView commitAnimations];
        }
    }];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:NULL];
}


- (IBAction)onShowAccountsClicked:(id)sender {
    btnSelected = 1;
    
    [_collectionAccounts reloadData];
    
    [UIView beginAnimations:@"EditViewSlide" context:nil];
    [UIView setAnimationDuration:0.7];
    if (isOut)
    {
        
        _viewBottom.frame = CGRectMake(self.view.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
        
        isOut = NO;
    }
    else
    {
        _viewBottom.frame = CGRectMake(self.view.frame.size.width - _viewBottom.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
        
        isOut = YES;
    }
    [UIView commitAnimations];
}

- (IBAction)onShowAccountsToClicked:(id)sender {
    
    btnSelected = 2;
    [_collectionAccounts reloadData];
    
    [UIView beginAnimations:@"AccountViewSlide" context:nil];
    [UIView setAnimationDuration:0.7];
    if (isOut)
    {
        
        _viewBottom.frame = CGRectMake(self.view.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
        
        isOut = NO;
    }
    else
    {
        _viewBottom.frame = CGRectMake(self.view.frame.size.width - _viewBottom.frame.size.width, _viewBottom.frame.origin.y, _viewBottom.frame.size.width, _viewBottom.frame.size.height);
        
        isOut = YES;
    }
    [UIView commitAnimations];
}

- (IBAction)onSendClicked:(id)sender {
    if (_txtToken.text.length == 0 || _txtTo.text.length == 0 || _txtERO.text.length == 0 || _txtCurrency.text.length == 0) {
        if (_txtToken.text.length == 0 && _txtTo.text.length == 0 && _txtERO.text.length == 0 && _txtCurrency.text.length == 0) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Details" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtToken.text.length == 0){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Select TOKEN|COIN" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtTo.text.length == 0){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Select Receiving Address" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtERO.text.length == 0){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Amount" closeButtonTitle:nil duration:0.0f];
        }
        else if (_txtCurrency.text.length == 0){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:@"Please Enter Amount" closeButtonTitle:nil duration:0.0f];
        }
    }
    else if (intMin < isMin || intMin > isMax){
        NSString *strAlert = [NSString stringWithFormat:@"You can send %@ only between %f %f",strERO, isMin, isMax];
        if (intMin < isMin){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:strAlert closeButtonTitle:nil duration:0.0f];
        }
        else if (intMin > isMax){
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"Alert" subTitle:strAlert closeButtonTitle:nil duration:0.0f];
        }
    }
    else{
        [self APISend];
    }
}

- (IBAction)onShowTokenClicked:(id)sender {
    if (isOut)
    {
        _viewTokens.hidden = YES;
        isOut = NO;
    }
    else
    {
        _viewTokens.hidden = NO;
        isOut = YES;
    }
}

- (IBAction)onCloseTokenClicked:(id)sender{
    if (isOut)
    {
        [UIView transitionWithView:_viewTokens
                          duration:0.2
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            _viewTokens.hidden = YES;
                        }
                        completion:NULL];
        isOut = NO;
    }
    else
    {
       // [self APITokens];
    }
}

#pragma mark - APIWORK
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

-(void)APIAccountBalances{
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
                             strAccount,@"account",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_ACCOUNT_BALANCE];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_ACCOUNT_BALANCE];
        strCallType = @"accountBalances";
    }
}

-(void)APISend{
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
                             strAccount,@"from",
                             strTo,@"to",
                             _txtERO.text,@"amount",
                             @"1",@"type",
                             _txtNote.text,@"note",
                             strCoinID,@"coin",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_SEND_AMOUNT];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_SEND_AMOUNT];
        strCallType = @"send";
    }
}

-(void)APISendAmount{
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
                             strAccount,@"from",
                             strTo,@"to",
                             _txtERO.text,@"amount",
                             @"1",@"type",
                             _txtNote.text,@"note",
                             strCoinID,@"coin",
                             _txtPassword.text,@"password",
                             _txtEmailVerify.text,@"otp",
                             _txt2FAverifyCode.text,@"code",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_SEND_AMOUNT];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_SEND_AMOUNT];
        strCallType = @"sendAmount";
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
    if ([strCallType isEqualToString:@"tokens"]){
        if (callType == CALL_TYPE_TOKENS){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                arrTokenData = [[NSMutableArray alloc]init];
                arrTokenData = [[jsonRes valueForKey:@"data"] valueForKey:@"tokens"];
                [_tableTokens reloadData];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"accountBalances"]){
        if (callType == CALL_TYPE_ACCOUNT_BALANCE){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
            
            arrTokenData = [[NSMutableArray alloc]init];
            arrTokenData = [jsonRes valueForKey:@"data"];
            [self Names];
            [_tableTokens reloadData];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"sendAmount"]){
        if (callType == CALL_TYPE_SEND_AMOUNT){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.messageColor = [UIColor orangeColor];
                [self.view makeToast:@"Successful"
                            duration:3.0
                            position:CSToastPositionBottom
                               style:style];
                
                [CSToastManager setSharedStyle:style];
                [CSToastManager setTapToDismissEnabled:YES];
                [CSToastManager setQueueEnabled:YES];
                 _viewVerification.hidden = YES;
                
                NSUserDefaults *userTransactionDetails = [NSUserDefaults standardUserDefaults];
                NSDictionary *dictTransactionData = [[NSDictionary alloc]init];
                dictTransactionData = [jsonRes valueForKey:@"data"];
                [userTransactionDetails setObject:dictTransactionData forKey:@"userTransactionDetails"];
                [userTransactionDetails synchronize];

                [self performSegueWithIdentifier:@"transaction" sender:self];
            }
            
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"send"]){
        if (callType == CALL_TYPE_SEND_AMOUNT) {
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
            NSString *strStatus = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            
            if ([strStatus isEqualToString:@"1"]) {
                str2FA = [NSString stringWithFormat:@"%@",[[jsonRes valueForKey:@"data"]valueForKey:@"TFA"]];
                
                strEmailVerify = [NSString stringWithFormat:@"%@",[[jsonRes valueForKey:@"data"]valueForKey:@"OTP"]];
                
                strTransPass = [NSString stringWithFormat:@"%@",[[jsonRes valueForKey:@"data"]valueForKey:@"PASS"]];
                
                if ([strEmailVerify isEqualToString:@"1"] && [str2FA isEqualToString:@"1"] && [strTransPass isEqualToString:@"1"]) {
                    _viewVerification.hidden = NO;
                }
                else if ([strEmailVerify isEqualToString:@"0"] && [str2FA isEqualToString:@"1"] && [strTransPass isEqualToString:@"1"]) {
                    _viewEmail.hidden = YES;
                    _view2FAtoPasswordHeight.constant = 8;
                    _viewVerificationHeight.constant = 237;
                    _viewVerification.hidden = NO;
                }
                else if ([strEmailVerify isEqualToString:@"1"] && [str2FA isEqualToString:@"0"] && [strTransPass isEqualToString:@"1"]) {
                    _view2FA.hidden = YES;
                    _viewVerificationHeight.constant = 237;
                    _viewVerification.hidden = NO;
                }
                else if ([strEmailVerify isEqualToString:@"0"] && [str2FA isEqualToString:@"0"] && [strTransPass isEqualToString:@"1"]) {
                    _view2FA.hidden = YES;
                    _viewEmail.hidden = YES;
                    _viewVerificationHeight.constant = 174;
                    _viewVerification.hidden = NO;
                }
                
                else if ([strEmailVerify isEqualToString:@"1"] && [str2FA isEqualToString:@"1"] && [strTransPass isEqualToString:@"0"]) {
                    _viewPassword.hidden = YES;
                    _viewEmailDistance.constant = 8;
                    _viewVerificationHeight.constant = 237;
                    _viewVerification.hidden = NO;
                }
                else if ([strEmailVerify isEqualToString:@"0"] && [str2FA isEqualToString:@"1"] && [strTransPass isEqualToString:@"0"]) {
                    _viewPassword.hidden = YES;
                    _viewEmail.hidden = YES;
                    _view2FADistance.constant = 8;
                    _viewVerificationHeight.constant = 174;
                    _viewVerification.hidden = NO;
                }
                else if ([strEmailVerify isEqualToString:@"1"] && [str2FA isEqualToString:@"0"] && [strTransPass isEqualToString:@"0"]) {
                    _view2FA.hidden = YES;
                    _viewPassword.hidden = YES;
                    _viewVerificationHeight.constant = 174;
                    _viewEmailDistance.constant = 8;
                    _viewVerification.hidden = NO;
                }
                else if ([strEmailVerify isEqualToString:@"0"] && [str2FA isEqualToString:@"0"] && [strTransPass isEqualToString:@"0"]) {
                    _view2FA.hidden = YES;
                    _viewEmail.hidden = YES;
                    _viewVerificationHeight.constant = 174;
                    
                    SCLAlertView *alert = [[SCLAlertView alloc] init];
                    [alert addButton:@"Confirm" validationBlock:^BOOL{
                        [self APISendAmount];
                        return YES;
                    } actionBlock:^{
                    }];
                    
                    [alert showEdit:self title:@"Alert" subTitle:@"Do You Really Want To Make Transaction!?" closeButtonTitle:@"Cancel" duration:0];
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


- (IBAction)onBtnSend:(id)sender {
    [self keyboardWillHide];
    [self APISendAmount];
}


- (IBAction)onHideVerificationClicked:(id)sender {
    _viewVerification.hidden = YES;
}

-(void)Names{
    arrNames = [[NSMutableArray alloc]init];
    arrNames = [[arrTokenData valueForKey:@"token"] valueForKey:@"name"];
    
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    arrSearchData = [[NSMutableArray alloc]init];
    NSPredicate *resultPredicate = [NSCompoundPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    
    arrSearchResult = [arrNames filteredArrayUsingPredicate:resultPredicate];
    
    for (int i=0; i<[arrSearchResult count]; i++) {
        NSString *str = [arrSearchResult objectAtIndex:i];
        for ( NSDictionary *dic2 in arrTokenData)
        {
            if ([[[dic2 valueForKey:@"token"]valueForKey:@"name"] isEqual:str])
            {
                [arrSearchData addObject:dic2];
            }
        }
    }
    NSLog(@"%@",arrSearchData);
    [_tableTokens reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        searchEnabled = NO;
        [_tableTokens reloadData];
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
    [_tableTokens reloadData];
}




@end

/*
 {"status":1,"data":
           {
               "tid":"0xf73b19f193664738a4011816b7e35bf97ddca5eec38e9cb60b508732a1e210c1",
               "status":0,
               "note":"",
               "is_failed":false,
               "failed_reason":"",
               "using_our":true,
               "_id":"5b37473cd7ae650300ce01d8",
               "created_at":"2018-06-30T09:02:52.085Z",
               "updated_at":"2018-06-30T09:02:52.085Z",
               "user":"5b3706b282a1bc275a72eb3b",
               "from":"0xa3c2a9716a93f19b20834ed1cb9a63def5e689cc",
               "to":"0x9465a909bc101de7cca2c5baf4a2488d6c893d2b",
               "type":3,
               "amount":10,
               "base":"0xa3c2a9716a93f19b20834ed1cb9a63def5e689cc",
               "token":"5b18d73c0c2d5573e8ca5941",
               "order_number":7032907290,"__v":0,
               "name":"ShockWave",
               "symbol":"POLI"
           },
           "statusCode":200}
 */
/*
 {
     "__v" = 0;
     "_id" = 5b37653f14dd7b10554a51ee;
     amount = 10;
     base = 0xcd0e3fca28c8949a9832224bdb478a6eb5dabc77;
     "created_at" = "2018-06-30T11:10:55.364Z";
     "failed_reason" = "";
     from = 0xcd0e3fca28c8949a9832224bdb478a6eb5dabc77;
     "is_failed" = 0;
     name = "KD 1";
     note = "";
     "order_number" = 5645481026;
     status = 0;
     symbol = PRV;
     tid = 0xfcf2946e0cda428487215417c0009bf5235a28d834ae9c27890f6d84867e3e2f;
     to = 0x57c456f00ca27ee029dea4596e611a3c9aab7fac;
     token = 5b18d7600c2d5573e8ca5943;
     type = 3;
     "updated_at" = "2018-06-30T11:10:55.364Z";
     user = 5b23952db24b143a9e4426de;
     "using_our" = 1;
 }
 */
