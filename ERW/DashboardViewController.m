//
//  DashboardViewController.m
//  ERW
//
//  Created by nestcode on 4/11/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController{
    NSMutableArray *arrTransactionData, *arrSentData, *arrReceivedData, *arrTransferredData, *arrNames;
    NSArray *arrMain, *rainbowColors;
    NSUserDefaults *userArrColors, *userSelectedIndex, *UserToken, *UserDictData, *UserUDID;
    NSInteger SelectedIndex;
    NSString *strToken, *strUDID, *strCallType, *strOffset, *strLimit, *strFilter, *strCoin, *strSearch, *strAccount, *strAccountID;
    NSMutableDictionary *dictUserData;
    NSMutableArray *arrAccountData, *arrTransactionDatas, *arrTokenData, *arrTokensInAccount;
    BOOL isExpanded;
    NSInteger selectedBTN, accSelected, updateIndex, indexedPath;
    kFRDLivelyButtonStyle newStyle;
    BOOL isOut;
    NSInteger TokenPressed;
    NSArray *arrSegment;
    NSString *strWalletCurrency, *strNote, *strTId, *strTo, *strFrom, *strSuccess, *strDate, *strTitle;
    NSUserDefaults *UserWalletCurrency;
    NSUserDefaults *isLogin, *userConfirm, *userReq, *userTID;
    int r, s, t, u;
    NSString *strSearchText;
    NSUserDefaults *userSelectedCurrIndex, *userSelectedCurr;
    NSInteger currIndex;
    NSString *strSelectedCurr;
    NSMutableArray *arrSearchData;
    NSArray *arrSearchResult;
    BOOL searchEnabled;
    NSMutableArray *arrRates;
    int isMaintain;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    accSelected = 0;
    updateIndex = 0;
    
    strOffset = @"0";
    strLimit = @"10";
    strFilter = @"";
    strCoin = @"";
    strSearch = @"";
    
    
    
    UserWalletCurrency = [NSUserDefaults standardUserDefaults];
    
    userSelectedCurrIndex = [NSUserDefaults standardUserDefaults];
    userSelectedCurr = [NSUserDefaults standardUserDefaults];
    
    currIndex = [userSelectedCurrIndex integerForKey:@"userSelectedCurrIndex"];
    strSelectedCurr = [[userSelectedCurr valueForKey:@"userSelectedCurr"] lowercaseString];
    
    strWalletCurrency = [UserWalletCurrency valueForKey:@"walletCurrency"];
    
    if (strSelectedCurr == nil) {
        strSelectedCurr = @"USD";
    }
    
    if (strWalletCurrency == nil) {
        strWalletCurrency = @"USD";
    }
    
    [UserWalletCurrency setValue:strWalletCurrency forKey:@"walletCurrency"];
    [UserWalletCurrency synchronize];
    
    userSelectedIndex = [NSUserDefaults standardUserDefaults];
    UserDictData = [NSUserDefaults standardUserDefaults];
    UserToken = [NSUserDefaults standardUserDefaults];
    dictUserData = [[NSMutableDictionary alloc]init];
    UserUDID = [NSUserDefaults standardUserDefaults];
    
    userReq = [NSUserDefaults standardUserDefaults];
    userTID = [NSUserDefaults standardUserDefaults];
    userConfirm = [NSUserDefaults standardUserDefaults];
    
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    dictUserData = [UserDictData objectForKey:@"userdata"];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
    NSUserDefaults *USerID = [NSUserDefaults standardUserDefaults];
    [USerID setValue:[[dictUserData objectForKey:@"data"]valueForKey:@"_id"] forKey:@"userID"];
    [USerID synchronize];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [appDelegate ConnectSocket];
    
    
    [userSelectedIndex setInteger:0 forKey:@"selected"];
    [userSelectedIndex synchronize];
    
    _viewTokens.hidden = YES;
    _viewSearch.hidden = YES;
    _viewReceive.hidden = YES;
    _viewTransactionPage.hidden = YES;
    _viewAddAccountBack.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewMaintenance.hidden = YES;
    
    _viewTransactionPage.hidden = YES;
    _viewAddAccountBack.hidden = YES;
     _viewTokens.hidden = YES;
    _viewSearch.hidden = YES;
    _viewReceive.hidden = YES;

    
    arrSearchResult = [[NSArray alloc]init];
    arrSearchData = [[NSMutableArray alloc]init];
    
    _txtAccountName.delegate = self;
    _txtPassword.delegate = self;
    _txtSearchField.delegate = self;
    
    _viewAccountName.layer.borderWidth = 0.5f;
    _viewAccountName.layer.borderColor =[UIColor grayColor].CGColor;
    
    _viewPassword.layer.borderWidth = 0.5f;
    _viewPassword.layer.borderColor =[UIColor grayColor].CGColor;
        
    _tableTransactions.tableFooterView = [UIView new];
    _tableTokens.tableFooterView = [UIView new];
    
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    arrTransactionData = [[NSMutableArray alloc]init];
    NSUserDefaults *userArrAccountData = [NSUserDefaults standardUserDefaults];
    arrTransactionData = [userArrAccountData objectForKey:@"AccountData"];
    
    self.tableTransactions.parallaxHeader.view = self.viewHeader; //You can set the parallax header view from the floating view.
    self.tableTransactions.parallaxHeader.height = 275;
    self.tableTransactions.parallaxHeader.mode = MXParallaxHeaderModeFill;
    self.tableTransactions.parallaxHeader.delegate = self;
    _number = 0;
    
    userArrColors = [NSUserDefaults standardUserDefaults];
    rainbowColors = @[spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr,spring_green, violet, bright_pink, blueClr, orangeClr, azure, chartreuse, greenClr, yellowClr, cyan, redClr, magenta, staticClr, waveClr];
    
    [userArrColors setObject:rainbowColors forKey:@"colors"];
    [userArrColors synchronize];
    
    
    [self Maintenance];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self ApiGetAccounts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"reload_data" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutUser) name:@"Logout_user" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Maintenance) name:@"DashMaintain" object:nil];
}

-(void)Maintenance{
    
    NSDictionary *SettingMaintain = [[NSDictionary alloc]init];
    NSUserDefaults *userDashMaintain = [NSUserDefaults standardUserDefaults];
    SettingMaintain = [userDashMaintain objectForKey:@"userDashMaintain"];
    
    NSString *strMaintain = [NSString stringWithFormat:@"%@",[SettingMaintain valueForKey:@"status"]];
    
    
    
    if ([strMaintain isEqualToString:@"1"]) {
        _viewMaintenance.hidden = NO;
        _lblMaintenanceMessage.text = [SettingMaintain valueForKey:@"message"];
        _btnSearch.enabled = NO;
        _btnTOKENS.enabled = NO;
    }
    else{
        _viewMaintenance.hidden = YES;
        _btnSearch.enabled = YES;
        _btnTOKENS.enabled = YES;
    }
}

-(void)handle_data {
    [_tableTransactions reloadData];
}

-(void)logoutUser{
    isLogin = [NSUserDefaults standardUserDefaults];
    [isLogin setInteger:0 forKey:@"isLogin"];
    [isLogin synchronize];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [self performSegueWithIdentifier:@"logout" sender:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tableTransactions.parallaxHeader.minimumHeight = 85;
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    if ([_searchField isFirstResponder]) {
        
    }
    else{
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -keyboardSize.height;
            [self.view setFrame:CGRectMake(0,-110,self.view.frame.size.width,self.view.frame.size.height)];
        }];
    }
}


-(void)dismissKeyboard {
    NSLog(@"dismiss");
    [self keyboardWillHide];
}

- (IBAction)dismissKeyboard:(id)sender;
{
    NSLog(@"dismiss");
    
    [_txtAccountName resignFirstResponder];
    [_txtPassword resignFirstResponder];
    
    if ([_txtAccountName isFirstResponder]||[_txtPassword isFirstResponder]) {
        [self keyboardWillHide];
    }
    [_txtSearchField resignFirstResponder];
}

-(void)keyboardWillHide{
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

//MARK: SegmentControls
-(void)pagerContentView:(UIView *)view didSelectTitle:(NSString *)title didSelectedIndex:(NSInteger)index {
    NSLog(@"selected title: %@",title);
    _number = index;
    //[self viewWillAppear:YES];
    [self.tableTransactions reloadData];
}

#pragma mark <MXParallaxHeaderDelegate>

- (void)parallaxHeaderDidScroll:(MXParallaxHeader *)parallaxHeader {
    NSLog(@"progress %f", parallaxHeader.progress);
    if (parallaxHeader.progress < 1.000000) {
     //   self.title = @"ABCD";
        NSLog(@"XYZ");
        [_btnTitle setTitle:strTitle];
    }
    else{
        [_btnTitle setTitle:@""];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.tableTransactions) {
    if (_number == 1) {
        return arrSentData.count;
    }
    else if (_number == 2) {
        return arrReceivedData.count;
    }
    else if (_number == 3) {
        return arrTransferredData.count;
    }
        return arrTransactionData.count;
    }
    else if (tableView == self.tableofTokens){
       return arrTokensInAccount.count;
    }
    else {
        if (searchEnabled) {
            return  arrSearchData.count+1;
        }
        else{
            return arrTokenData.count+1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableTransactions) {
      
        _DoneSocket = [userConfirm floatForKey:@"confirm"];
        _Required = [userConfirm floatForKey:@"req"];
        _strID = [userConfirm valueForKey:@"SocketID"];
        
        
    TransactionsTableViewCell *cell = [self.tableTransactions dequeueReusableCellWithIdentifier:@"TransactionsTableViewCell" forIndexPath:indexPath];

        
        /*
         MARK: ADDED
         
         {
             "__v" = 0;
             "_id" = 5adeb520b786e717f295eb50;
             amount = 10;
             base = 0xaa6fd5ce167447a5a0a7af559a4c958184ce5d44;
             "created_at" = "2018-04-24T04:40:00.265Z";
             "failed_reason" = "";
             from = 0xaa6fd5ce167447a5a0a7af559a4c958184ce5d44;
             "is_failed" = 0;
             market =         {
             BTC = 0;
             USD = 0;
             };
             name = md1;
             note = "";
             "order_number" = 214881874;
             status = 0;
             symbol = ERC21;
             tid = 0xce3c1dd61730e8478fca752ed38e82c4f1967df47406c4f8755421a31fdde4c6;
             to = 0x93067836c2334bdbf455f3b90f892d976b811025;
             token = 5abcd40af083797ff7b3716c;
             type = 3;
             "updated_at" = "2018-04-24T04:40:00.266Z";
             user = 5ac5b11c0283d53a38211b69;
             "using_our" = 1;
         }

         
         MARK: Confirmation
         (
             {
                 cnf = 2;
                 id = 5adeb520b786e717f295eb50;
                 required = 10;
             }
         )
         
         */
        
    
    if (_number == 0) {
        NSDictionary *dictTemp = [arrTransactionData objectAtIndex:indexPath.row];
        
        
        
         NSString *strType = [NSString stringWithFormat: @"%@",[dictTemp valueForKey:@"type"]];
        if ([strType isEqualToString:@"1"]) {
            cell.lblTransactions.text = @"Sent Fund";
            cell.imgSentRecieved.image = [UIImage imageNamed:@"arrow_sent"];
            NSString *strID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
            
            _strID = [userTID valueForKey:@"SocketID"];
            if ([strID isEqualToString:_strID]) {
                cell.transactionProgress.hidden = NO;
                CGFloat progress =  (_DoneSocket/_Required);
                [cell.transactionProgress setProgress:progress];
            }
            else if ( [strID isEqualToString:@""]){
                cell.transactionProgress.hidden = YES;
            }
            
        }
        else if ([strType isEqualToString:@"2"]) {
            cell.lblTransactions.text = @"Received Fund";
            cell.imgSentRecieved.image = [UIImage imageNamed:@"receive"];
            NSString *strID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
            
            _strID = [userTID valueForKey:@"SocketID"];
            if ([strID isEqualToString:_strID]) {
                cell.transactionProgress.hidden = NO;
                CGFloat progress =  (_DoneSocket/_Required);
                [cell.transactionProgress setProgress:progress];
            }
            else if ( [strID isEqualToString:@""]){
                cell.transactionProgress.hidden = YES;
            }
        }
        else if ([strType isEqualToString:@"3"]) {
            cell.lblTransactions.text = @"transferred Fund";
            cell.imgSentRecieved.image = [UIImage imageNamed:@"arrow_sent"];
            NSString *strID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
            
            _strID = [userTID valueForKey:@"SocketID"];
            if ([strID isEqualToString:_strID]) {
                cell.transactionProgress.hidden = NO;
                CGFloat progress =  (_DoneSocket/_Required);
                [cell.transactionProgress setProgress:progress];
            }
            else if ( [strID isEqualToString:@""]){
                cell.transactionProgress.hidden = YES;
            }
        }
        
        NSLog(@"%@",dictTemp);
        NSString *str = [[dictTemp valueForKey:@"token"] valueForKey:@"symbol"];
        NSDictionary *dictTempCurr = [arrRates valueForKey:str];
        NSLog(@"%@",dictTempCurr);
        
        cell.lblAmountTransact.text = [NSString stringWithFormat:@"%@ %@",[dictTemp valueForKey:@"amount"],str];
        
       // NSDictionary *dictMarketCurr = [dictTempCurr objectForKey:str];
        
        strNote = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"note"]];
        if ([strNote isEqualToString:@""]) {
            cell.imgNote.hidden = YES;
        }
        else{
            cell.imgNote.hidden = NO;
        }
        
        strSuccess = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"is_failed"]];
        
        if ([strSuccess isEqualToString:@"1"]) {
            cell.imgStatus.image = [UIImage imageNamed:@"failed"];
        }
        
        NSString *strTempDate = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"created_at"]];
        NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        NSDate * convrtedDate = [formatter dateFromString:strTempDate];
        [formatter setDateFormat:@"dd MMM yy hh:mm a"];
        strDate = [formatter stringFromDate:convrtedDate];
        
        cell.lblTime.text = strDate;
        
         //   NSString *strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"] valueForKey:strSelectedCurr]];
        NSString *strUSD = [NSString stringWithFormat:@"%@",[dictTempCurr valueForKey:strSelectedCurr]];
        NSString *strTransAmount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
        float transAmount = [strTransAmount floatValue];
        float USD = [strUSD floatValue];
        float finalAmount = transAmount * USD;
        
        if ([strSelectedCurr isEqualToString:@"usd"]) {
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"$%.8f",finalAmount];
        }
        else if ([strSelectedCurr isEqualToString:@"btc"]) {
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"฿%f",finalAmount];
        }
        else if ([strSelectedCurr isEqualToString:@"eth"]) {
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else if ([strSelectedCurr isEqualToString:@"xrp"]) {
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else if ([strSelectedCurr isEqualToString:@"ltc"]) {
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else if ([strSelectedCurr isEqualToString:@"dash"]) {
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else{
            cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }

        NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
        [cell.imgTokens sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            [cell.imgTokens updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell.imgTokens reveal];
        }];
    }
    else if (_number == 1) {
        NSDictionary *dictTemp = [arrSentData objectAtIndex:indexPath.row];
        
        NSString *strID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
        
        if ([strID isEqualToString:_strID]) {
            cell.transactionProgress.hidden = NO;
            CGFloat progress =  (_DoneSocket/_Required);
            [cell.transactionProgress setProgress:progress];
        }
        else if ([strID isEqualToString:@""]){
            cell.transactionProgress.hidden = YES;
        }
        
        NSString *strType = [NSString stringWithFormat: @"%@",[dictTemp valueForKey:@"type"]];
        
        if ([strType isEqualToString:@"1"]) {
            cell.lblTransactions.text = @"Sent Fund";
            cell.imgSentRecieved.image = [UIImage imageNamed:@"arrow_sent"];
            cell.lblAmountTransact.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
          
            strNote = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"note"]];
            if ([strNote isEqualToString:@""]) {
                cell.imgNote.hidden = YES;
            }
            else{
                cell.imgNote.hidden = NO;
            }
            
            strSuccess = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"is_failed"]];
            
            if ([strSuccess isEqualToString:@"1"]) {
                cell.imgStatus.image = [UIImage imageNamed:@"failed"];
            }
            
            NSString *strTempDate = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"created_at"]];
            NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSDate * convrtedDate = [formatter dateFromString:strTempDate];
            [formatter setDateFormat:@"dd MMM yy hh:mm a"];
            strDate = [formatter stringFromDate:convrtedDate];
            
            cell.lblTime.text = strDate;
            
            NSString *strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"] valueForKey:strSelectedCurr]];
            NSString *strTransAmount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
            float transAmount = [strTransAmount floatValue];
            float USD = [strUSD floatValue];
            float finalAmount = transAmount * USD;
            
            if ([strSelectedCurr isEqualToString:@"usd"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"$%.8f",finalAmount];
            }
            else if ([strSelectedCurr isEqualToString:@"btc"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"฿%f",finalAmount];
            }
            else if ([strSelectedCurr isEqualToString:@"eth"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"xrp"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"ltc"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"dash"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            
            NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
            [cell.imgTokens sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [cell.imgTokens updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cell.imgTokens reveal];
            }];
        }
    }
    else if (_number == 2) {
        
        NSDictionary *dictTemp = [arrReceivedData objectAtIndex:indexPath.row];
        
        NSString *strID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
        
        if ([strID isEqualToString:_strID]) {
            cell.transactionProgress.hidden = NO;
            CGFloat progress =  (_DoneSocket/_Required);
            [cell.transactionProgress setProgress:progress];
        }
        else if ([strID isEqualToString:@""]){
            cell.transactionProgress.hidden = YES;
        }
        
        NSString *strType = [NSString stringWithFormat: @"%@",[dictTemp valueForKey:@"type"]];
        
        if ([strType isEqualToString:@"2"]) {
            NSDictionary *dictTemp = [arrReceivedData objectAtIndex:indexPath.row];
            cell.lblTransactions.text = @"Received Fund";
            cell.imgSentRecieved.image = [UIImage imageNamed:@"receive"];
            cell.lblAmountTransact.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
            
            strNote = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"note"]];
            if ([strNote isEqualToString:@""]) {
                cell.imgNote.hidden = YES;
            }
            else{
                cell.imgNote.hidden = NO;
            }
            
            strSuccess = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"is_failed"]];
            
            if ([strSuccess isEqualToString:@"1"]) {
                cell.imgStatus.image = [UIImage imageNamed:@"failed"];
            }
            
            NSString *strTempDate = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"created_at"]];
            NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSDate * convrtedDate = [formatter dateFromString:strTempDate];
            [formatter setDateFormat:@"dd MMM yy hh:mm a"];
            strDate = [formatter stringFromDate:convrtedDate];
            
            cell.lblTime.text = strDate;
            
            NSString *strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"] valueForKey:strSelectedCurr]];
            NSString *strTransAmount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
            float transAmount = [strTransAmount floatValue];
            float USD = [strUSD floatValue];
            float finalAmount = transAmount * USD;
            
            if ([strSelectedCurr isEqualToString:@"usd"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"$%.8f",finalAmount];
            }
            else if ([strSelectedCurr isEqualToString:@"btc"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"฿%f",finalAmount];
            }
            else if ([strSelectedCurr isEqualToString:@"eth"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"xrp"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"ltc"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"dash"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
            [cell.imgTokens sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [cell.imgTokens updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cell.imgTokens reveal];
            }];
        }
    }
    else if (_number == 3) {
        
        NSDictionary *dictTemp = [arrTransferredData objectAtIndex:indexPath.row];
        
        NSString *strID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
        
        if ([strID isEqualToString:_strID]) {
            cell.transactionProgress.hidden = NO;
            CGFloat progress =  (_DoneSocket/_Required);
            [cell.transactionProgress setProgress:progress];
        }
        else if ([strID isEqualToString:@""]){
            cell.transactionProgress.hidden = YES;
        }
        
        NSString *strType = [NSString stringWithFormat: @"%@",[dictTemp valueForKey:@"type"]];
        
        if ([strType isEqualToString:@"3"]) {
            
            NSDictionary *dictTemp = [arrTransferredData objectAtIndex:indexPath.row];
            cell.lblTransactions.text = @"transferred Fund";
            cell.imgSentRecieved.image = [UIImage imageNamed:@"arrow_sent"];
            cell.lblAmountTransact.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
            
            strNote = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"note"]];
            if ([strNote isEqualToString:@""]) {
                cell.imgNote.hidden = YES;
            }
            else{
                cell.imgNote.hidden = NO;
            }
            
            strSuccess = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"is_failed"]];
            
            if ([strSuccess isEqualToString:@"1"]) {
                cell.imgStatus.image = [UIImage imageNamed:@"failed"];
            }
            
            NSString *strTempDate = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"created_at"]];
            NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSDate * convrtedDate = [formatter dateFromString:strTempDate];
            [formatter setDateFormat:@"dd MMM yy hh:mm a"];
            strDate = [formatter stringFromDate:convrtedDate];
            
            cell.lblTime.text = strDate;
            
            NSString *strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"] valueForKey:strSelectedCurr]];
            NSString *strTransAmount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
            float transAmount = [strTransAmount floatValue];
            float USD = [strUSD floatValue];
            float finalAmount = transAmount * USD;
            
            if ([strSelectedCurr isEqualToString:@"usd"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"$%.8f",finalAmount];
            }
            else if ([strSelectedCurr isEqualToString:@"btc"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"฿%f",finalAmount];
            }
            else if ([strSelectedCurr isEqualToString:@"eth"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"xrp"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"ltc"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"dash"]) {
                cell.lblAmountDollers.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
            }
            
            NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
            [cell.imgTokens sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [cell.imgTokens updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cell.imgTokens reveal];
            }];
        }
    }

    return cell;
    }
    else if (tableView == self.tableofTokens){
        AccountBalancesTableViewCell *cell = [self.tableofTokens dequeueReusableCellWithIdentifier:@"AccountBalancesTableViewCell" forIndexPath:indexPath];
        
        NSDictionary *dictTemp = [arrTokensInAccount objectAtIndex:indexPath.row];
        
        cell.lblTokenNAme.text = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"name"]];
        
        NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
        
        NSString *strBTC = [NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"balance"]];
        cell.lblBTCBalance.text = strBTC;
        
        if ([strWalletCurrency isEqualToString:@"USD"]) {
        
        NSString *strUSD = [NSString stringWithFormat:@"$%@",[[dictTemp objectForKey:@"market"]valueForKey:@"usd"]];
        cell.lblUSDBalance.text = strUSD;
        }
        else{
            NSString *strUSD = [NSString stringWithFormat:@"฿%@",[[dictTemp objectForKey:@"market"]valueForKey:@"btc"]];
            cell.lblUSDBalance.text = strUSD;
        }
        [cell.imgToken sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            [cell.imgToken updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell.imgToken reveal];
        }];
        return cell;
    }
    else{
        if (searchEnabled) {
            if (indexPath.row == 0) {
                TokenDataTableViewCell *cell = [self.tableTokens dequeueReusableCellWithIdentifier:@"FirstCell" forIndexPath:indexPath];
                return cell;
            }
            else{
                TokenDataTableViewCell *cell = [self.tableTokens dequeueReusableCellWithIdentifier:@"TokenDataTableViewCell" forIndexPath:indexPath];
                
                NSDictionary *dictTemp = [arrSearchData objectAtIndex:indexPath.row-1];
                
                cell.lblTokenNAme.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"token"]];
                
                NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[dictTemp valueForKey:@"icon"]];
                
                [cell.imgToken sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    [cell.imgToken updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [cell.imgToken reveal];
                }];
                return cell;
            }
        }
        else{
            if (indexPath.row == 0) {
                TokenDataTableViewCell *cell = [self.tableTokens dequeueReusableCellWithIdentifier:@"FirstCell" forIndexPath:indexPath];
                return cell;
            }
            else{
                TokenDataTableViewCell *cell = [self.tableTokens dequeueReusableCellWithIdentifier:@"TokenDataTableViewCell" forIndexPath:indexPath];
                
                NSDictionary *dictTemp = [arrTokenData objectAtIndex:indexPath.row-1];
                
                cell.lblTokenNAme.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"token"]];
                
                NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[dictTemp valueForKey:@"icon"]];
                
                [cell.imgToken sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    [cell.imgToken updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [cell.imgToken reveal];
                }];
                return cell;
            }
        }
        
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableTransactions) {
        return 100;
    }
    else{
        return 60;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableTransactions) {
        _viewTransactionPage.hidden = NO;
        NSDictionary *dictTemp = [[NSDictionary alloc]init];
        NSDictionary *dictTempCurr = [[NSDictionary alloc]init];
        NSString *str;
        NSString *strType;
        
        
        if (_number == 0 || _number == 1 || _number == 2 || _number == 3) {
            if (_number == 0) {
                dictTemp = [arrTransactionData objectAtIndex:indexPath.row];
            }
            else if (_number == 1) {
                dictTemp = [arrSentData objectAtIndex:indexPath.row];
            }
            else if (_number == 2) {
                dictTemp = [arrReceivedData objectAtIndex:indexPath.row];
            }
            else if (_number == 3) {
                dictTemp = [arrTransferredData objectAtIndex:indexPath.row];
            }
            
            str = [[dictTemp valueForKey:@"token"] valueForKey:@"symbol"];
            dictTempCurr = [arrRates valueForKey:str];
            strType = [NSString stringWithFormat: @"%@",[dictTemp valueForKey:@"type"]];
            
            if ([strType isEqualToString:@"1"]) {
                _lblTransaction.text = @"Sent Fund";
                _imgTransaction.image = [UIImage imageNamed:@"arrow_sentWhite"];
                _imgBack.image = [UIImage imageNamed:@"arrow_sent"];
                [_viewTransactionHeader setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:42.0f/255.0f blue:0 alpha:1.0f]];
            }
            else if ([strType isEqualToString:@"2"]) {
                _lblTransaction.text = @"Received Fund";
                _imgTransaction.image = [UIImage imageNamed:@"receiveWhite"];
                _imgBack.image = [UIImage imageNamed:@"receive"];
                [_viewTransactionHeader setBackgroundColor:[UIColor colorWithRed:58.0f/255.0f green:177.0f/255.0f blue:40.f/255.0f alpha:1.0f]];
            }
            else if ([strType isEqualToString:@"3"]) {
                _lblTransaction.text = @"transferred Fund";
                _imgTransaction.image = [UIImage imageNamed:@"arrow_sentWhite"];
                _imgBack.image = [UIImage imageNamed:@"arrow_sent"];
                [_viewTransactionHeader setBackgroundColor:[UIColor colorWithRed:237.0f/255.0f green:42.0f/255.0f blue:0 alpha:1.0f]];
            }
            _lblTransactionAmount.text = [NSString stringWithFormat:@"%@ %@",[dictTemp valueForKey:@"amount"],str];
            _lblNote.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"note"]];
            
            if ([_lblNote.text isEqualToString:@""]) {
                _lblNote.text = @"--";
            }
            
            
            strSuccess = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"is_failed"]];
            if ([strSuccess isEqualToString:@"1"]) {
                _lblTransactionStatus.text = @"Transaction Failed.";
                [_lblTransactionStatus setTextColor:[UIColor colorWithRed:237.0f/255.0f green:42.0f/255.0f blue:0 alpha:1.0f]];
            }
            else{
                _lblTransactionStatus.text = @"Transaction Successful.";
                [_lblTransactionStatus setTextColor:[UIColor colorWithRed:58.0f/255.0f green:177.0f/255.0f blue:40.f/255.0f alpha:1.0f]];
            }
            NSString *strTempDate = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"created_at"]];
            
            NSString *strTxnID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"tid"]];
            
            _lblTxnID.text = strTxnID;
            
            NSString *strFromAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"fromAccount"]];
            NSString *strToAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"toAccount"]];
            
            if ([strFromAccount isEqualToString:@"N/A"]) {
                 _lblFrom.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"from"]];
            }
            else{
                NSDictionary *dictTemperFrom = [dictTemp valueForKey:@"fromAccount"];
                _lblFrom.text = [NSString stringWithFormat:@"%@",[dictTemperFrom valueForKey:@"name"]];
            }
            
            if ([strToAccount isEqualToString:@"N/A"]) {
                _lblTo.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"to"]];
            }
            else{
                NSDictionary *dictTemperSent = [dictTemp valueForKey:@"toAccount"];
                _lblTo.text = [NSString stringWithFormat:@"%@",[dictTemperSent valueForKey:@"name"]];
            }

            
            NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSDate * convrtedDate = [formatter dateFromString:strTempDate];
            [formatter setDateFormat:@"dd MMM yy hh:mm a"];
            strDate = [formatter stringFromDate:convrtedDate];
            _lblDate.text = strDate;
            
            NSString *strUSDSendTime = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"market"] valueForKey:strSelectedCurr]];
            NSString *strUSD = [NSString stringWithFormat:@"%@",[dictTempCurr valueForKey:strSelectedCurr]];
            NSString *strTransAmount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"amount"]];
            float transAmount = [strTransAmount floatValue];
            float USD = [strUSD floatValue];
            float USDTransTime = [strUSDSendTime floatValue];
            float finalAmount = transAmount * USD;
            float finalAmountTransTime = transAmount * USDTransTime;
            
            if ([strSelectedCurr isEqualToString:@"usd"]) {
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"$%.8f",finalAmount];
                _lblTransactionTime.text = [NSString stringWithFormat:@"$%.8f (Value When Send)",finalAmountTransTime];
            }
            else if ([strSelectedCurr isEqualToString:@"btc"]) {
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"฿%f",finalAmount];
                _lblTransactionTime.text = [NSString stringWithFormat:@"฿%f (Value When Send)",finalAmountTransTime];
            }
            else if ([strSelectedCurr isEqualToString:@"eth"]) {
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
                _lblTransactionTime.text = [NSString stringWithFormat:@"%.8f %@ (Value When Send)",finalAmountTransTime,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"xrp"]) {
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
                _lblTransactionTime.text = [NSString stringWithFormat:@"%.8f %@ (Value When Send)",finalAmountTransTime,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"ltc"]) {
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
                _lblTransactionTime.text = [NSString stringWithFormat:@"%.8f %@ (Value When Send)",finalAmountTransTime,strSelectedCurr];
            }
            else if ([strSelectedCurr isEqualToString:@"dash"]) {
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
                _lblTransactionTime.text = [NSString stringWithFormat:@"%.8f %@ (Value When Send)",finalAmountTransTime,strSelectedCurr];
            }
            else{
                _lblTransactionUSDAmount.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
                _lblTransactionTime.text = [NSString stringWithFormat:@"%.8f %@ (Value When Send)",finalAmountTransTime,strSelectedCurr];
            }
            
            NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
            [_imgCoin sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                [_imgCoin updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [_imgCoin reveal];
            }];
        }
    }
    else{
        if (searchEnabled) {
            if (indexPath.row == 0) {
                strCoin = @"";
                [_btnTOKENS setTitle:@"All Tokens"];
            }
            else{
                NSDictionary *dictTemp = [arrSearchData objectAtIndex:indexPath.row-1];
                strCoin = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
                [_btnTOKENS setTitle:[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"token"]]];
            }
        }
        else{
            if (indexPath.row == 0) {
                strCoin = @"";
                [_btnTOKENS setTitle:@"All Tokens"];
            }
            else{
                NSDictionary *dictTemp = [arrTokenData objectAtIndex:indexPath.row-1];
                strCoin = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
                [_btnTOKENS setTitle:[NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"token"]]];
            }
        }
        if (isOut)
        {
            TokenPressed = 0;
            [UIView transitionWithView:_viewDetails
                              duration:0.8
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                _viewTokens.hidden = YES;
                            }
                            completion:NULL];
            isOut = NO;
            [self ApiGetTransactions];
        }
    }
}

#pragma mark CollectioView - Data

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrAccountData count]+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [arrAccountData count]) {
        static NSString *identifier = @"lastCell";
        
        AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        [cell.viewBack setBackgroundColor:[self colorWithHexString:[rainbowColors objectAtIndex:indexPath.row]]];
        return cell;
    }
    else{
        static NSString *identifier = @"accountCell";
        
        AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        [cell.btnScan addTarget:self action:@selector(Scan:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnQR addTarget:self action:@selector(QRCode:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnSend addTarget:self action:@selector(Send:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnView addTarget:self action:@selector(ViewShow:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.viewBack setBackgroundColor:[self colorWithHexString:[rainbowColors objectAtIndex:indexPath.row]]];
        
        [cell.lblSelected setTextColor:[self colorWithHexString:[rainbowColors objectAtIndex:indexPath.row]]];
        
        SelectedIndex = [userSelectedIndex integerForKey:@"selected"];
        
        NSInteger index = indexPath.row;
        
        if (SelectedIndex == index) {
            cell.lblSelected.hidden = NO;
        }
        else{
            cell.lblSelected.hidden = YES;
        }
        
        NSDictionary *dictTemp = [arrAccountData objectAtIndex:indexPath.row];
        
        cell.lblAccountName.text = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
        
        cell.lblEroPrice.text = [NSString stringWithFormat:@"%@ %@",[dictTemp valueForKey:@"balance"],[dictTemp valueForKey:@"symbol"]];
      //  if ([strWalletCurrency isEqualToString:@"USD"]) {
  //      cell.lblAccountBalance.text = [NSString stringWithFormat:@"$%@",[[dictTemp objectForKey:@"rates"]valueForKey:strSelectedCurr]];
      /*  }
        else{
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"฿%@",[[dictTemp objectForKey:@"rates"]valueForKey:@"btc"]];
        }*/
        NSString *strUSD = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"rates"] valueForKey:strSelectedCurr]];
        NSString *strTransAmount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"balance"]];
        float transAmount = [strTransAmount floatValue];
        float USD = [strUSD floatValue];
        float finalAmount = transAmount * USD;
        
        if ([strSelectedCurr isEqualToString:@"usd"]) {
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"$%.8f",finalAmount];
        }
        else if ([strSelectedCurr isEqualToString:@"btc"]) {
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"฿%f",finalAmount];
        }
        else if ([strSelectedCurr isEqualToString:@"eth"]) {
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else if ([strSelectedCurr isEqualToString:@"xrp"]) {
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else if ([strSelectedCurr isEqualToString:@"ltc"]) {
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        else if ([strSelectedCurr isEqualToString:@"dash"]) {
            cell.lblAccountBalance.text = [NSString stringWithFormat:@"%.8f %@",finalAmount,strSelectedCurr];
        }
        
        
        
        
        return cell;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (isExpanded && indexPath.row == selectedBTN) {
        return CGSizeMake(195, 115);
    }
    return CGSizeMake((160), (115));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [arrAccountData count]) {
        [_viewAddAccountHeader setBackgroundColor:[self colorWithHexString:[rainbowColors objectAtIndex:arrAccountData.count]]];
        
        [_lblStaticAccountName setTextColor:[self colorWithHexString:[rainbowColors objectAtIndex:arrAccountData.count]]];
        
        [_btnAddAccount setBackgroundColor:[self colorWithHexString:[rainbowColors objectAtIndex:arrAccountData.count]]];
        
        _viewAddAccountBack.hidden = NO;
    }
    else{
        static NSString *identifier = @"accountCell";
        
        AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        cell.lblSelected.hidden = NO;
        
        [userSelectedIndex setInteger:indexPath.row forKey:@"selected"];
        [userSelectedIndex synchronize];
        
        NSDictionary *dictTemp = [arrAccountData objectAtIndex:indexPath.row];
        strAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"address"]];
        strTitle = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
        
        strAccountID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
        
        [_collectionAccounts reloadData];
        accSelected = 1;
        
        indexedPath = (long)indexPath.row;
        
        [_segmentTransactions setTintColor:[self colorWithHexString:[rainbowColors objectAtIndex:indexPath.row]]];
        updateIndex = 1;
        [self ApiGetTransactions];
    }
}

//MARK: COLORCODES

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


- (void)Scan:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collectionAccounts];
    NSIndexPath *indexPath = [_collectionAccounts indexPathForItemAtPoint:buttonPosition];
    NSLog(@"%ld Pressed",(long)indexPath.row);
    
    selectedBTN = (long)indexPath.row;
    
    if (isExpanded) {
        isExpanded = FALSE;
        [_collectionAccounts reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:selectedBTN inSection:0]]];
    }
    else {
        isExpanded = TRUE;
        [_collectionAccounts reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:selectedBTN inSection:0]]];
    }
}

- (void)QRCode:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collectionAccounts];
    NSIndexPath *indexPath = [_collectionAccounts indexPathForItemAtPoint:buttonPosition];
    NSLog(@"%ld Pressed",(long)indexPath.row);
    
    selectedBTN = (long)indexPath.row;
    
    NSDictionary *dictTemp = [arrAccountData objectAtIndex:indexPath.row];
    
    strAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"address"]];
    
    UIImage *imgQR = [UIImage mdQRCodeForString:strAccount size:150.0f];
    _imageQRCode.image = imgQR;
    _lblAddress.text = strAccount;
    
    _viewReceiveQRCode.hidden = NO;
    _viewAccountBalances.hidden = YES;
    
    if (isOut)
    {
        _viewReceive.hidden = YES;
        isOut = NO;
    }
    else
    {
        _viewReceive.hidden = NO;
        isOut = YES;
    }
}

- (void)Send:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collectionAccounts];
    NSIndexPath *indexPath = [_collectionAccounts indexPathForItemAtPoint:buttonPosition];
    NSLog(@"%ld Pressed",(long)indexPath.row);
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SendViewController *SendVC = (SendViewController *)[storyboard instantiateViewControllerWithIdentifier:@"SendViewController"];
    SendVC.dictACData = [arrAccountData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:SendVC animated:YES ];
    //[self presentViewController:SendVC animated:YES completion:nil];
}

- (void)ViewShow:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collectionAccounts];
    NSIndexPath *indexPath = [_collectionAccounts indexPathForItemAtPoint:buttonPosition];
    selectedBTN = (long)indexPath.row;
    
    NSDictionary *dictTemp = [arrAccountData objectAtIndex:indexPath.row];
    
    strAccountID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
    
    _viewReceiveQRCode.hidden = YES;
    _viewAccountBalances.hidden = NO;
    [self APIAccountBalances];
}


- (IBAction)onSearchClicked:(id)sender {
    [UIView beginAnimations:@"EditViewSlide" context:nil];
    [UIView setAnimationDuration:0.7];
    if (isOut)
    {
        _viewSearch.hidden = YES;
     //   _viewSearch.frame = CGRectMake(0, 0, _viewSearch.frame.size.width, 40);
        [_txtSearchField resignFirstResponder];
        _txtSearchField.text = @"";
        isOut = NO;
        [self ApiGetTransactions];
    }
    else
    {
        _viewSearch.hidden = NO;
     //   _viewSearch.frame = CGRectMake(0, 48, _viewSearch.frame.size.width, 40);
       // _viewSearch.hidden = NO;
        isOut = YES;
    //    [_txtSearchField becomeFirstResponder];
    }
    [UIView commitAnimations];
}

- (IBAction)onTokensClicked:(id)sender {
    _viewAccountBalances.hidden = YES;
    _viewReceiveQRCode.hidden = NO;
    if (isOut)
    {
        TokenPressed = 0;
        [UIView transitionWithView:_viewDetails
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
        TokenPressed = 1;
        [self APITokens];
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

-(void)ApiGetAccounts{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        
        self.view.userInteractionEnabled = NO;
        _sidebarButton.enabled = NO;
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_GET_ACCOUNTS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_GET_ACCOUNTS];
        strCallType = @"getAccounts";
        
    }
}

-(void)ApiCreateAccounts{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        _sidebarButton.enabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             _txtAccountName.text,@"name",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_CREATE_ACCOUNTS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_CREATE_ACCOUNTS];
        strCallType = @"createAccounts";
        
    }
}

-(void)ApiGetTransactions{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        
        self.view.userInteractionEnabled = NO;
        _sidebarButton.enabled = NO;
        if (strAccount.length == 0) {
            strAccount = @"";
        }
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strOffset,@"offset",
                             strLimit,@"limit",
                             strAccount,@"account",
                             strFilter,@"filter",
                             strSearch,@"search",
                             strCoin,@"coin",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_GET_TRANSACTIONS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_GET_TRANSACTIONS];
        strCallType = @"getTransactions";
    }
}

-(void)ApiGetSearchTransactions{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        
        self.view.userInteractionEnabled = NO;
        _sidebarButton.enabled = NO;
        if (strAccount.length == 0) {
            strAccount = @"";
        }
        
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strOffset,@"offset",
                             strLimit,@"limit",
                             strAccount,@"account",
                             strFilter,@"filter",
                             strSearchText,@"search",
                             strCoin,@"coin",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_GET_TRANSACTIONS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_GET_TRANSACTIONS];
        strCallType = @"getTransactions";
    }
}

-(void)APITokens{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        _sidebarButton.enabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             nil];
        NSError* error;
        NSData* data = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
        
        NSString *strUrl = [NSString stringWithFormat:@"%@",URL_TOKENS];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_TOKENS];
        strCallType = @"tokens";
    }
}


-(void)ApiGetUserSettings{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        [self CheckConnection];
    }
    else
    {
        // [SVProgressHUD show];
        self.view.userInteractionEnabled = NO;
        _sidebarButton.enabled = NO;
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
        // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:data];
        requestHandler = [[HTTPRequestHandler alloc] initWithRequest:request delegate:self andCallBack:CALL_TYPE_SETTINGS];
        strCallType = @"userSettings";
    }
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
        _sidebarButton.enabled = NO;
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
                             strToken,@"token",
                             strUDID,@"device",
                             strAccountID,@"account",
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

#pragma mark - ApiCallManagerDelegate

- (void)parserDidFailWithError:(NSError *)error andCallType:(CallTypeEnum)callType{
    self.view.userInteractionEnabled = YES;
    _sidebarButton.enabled = YES;
    NSLog(@"%s : Error : %@",__FUNCTION__, [error localizedDescription]);
}

- (void)requestHandler:(HTTPRequestHandler *)requestHandler didFailedWithError:(NSError *)error andCallBack:(CallTypeEnum)callType
{
    [SVProgressHUD dismiss];
    
    self.view.userInteractionEnabled = YES;
    _sidebarButton.enabled = YES;
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
    _sidebarButton.enabled = YES;
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

    if ([strCallType isEqualToString:@"getAccounts"]) {
        if (callType == CALL_TYPE_GET_ACCOUNTS){
            NSLog(@"Accounts: %@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            NSLog(@"%@",status);
            if ([status isEqualToString:@"1"]) {
                arrAccountData = [[NSMutableArray alloc]init];
                arrAccountData = [jsonRes valueForKey:@"data"];
                NSUserDefaults *userAccounts = [NSUserDefaults standardUserDefaults];
                [userAccounts setObject:arrAccountData forKey:@"userAccounts"];
                [userAccounts synchronize];
                [_collectionAccounts reloadData];
                for (int i=0; i <[arrAccountData count]; i++) {
                    NSDictionary *dictTemp = [arrAccountData objectAtIndex:0];
                    strAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"address"]];
                }
                
                if (arrAccountData.count == 0) {
                }
                else{
                    [self ApiGetTransactions];
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
    else if ([strCallType isEqualToString:@"createAccounts"]) {
        if (callType == CALL_TYPE_CREATE_ACCOUNTS){
            NSLog(@"%@",jsonRes);
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            NSLog(@"%@",status);
            if ([status isEqualToString:@"1"]) {
                
                _viewAddAccountBack.hidden = YES;
                
                CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
                style.messageColor = [UIColor orangeColor];
                [self.view makeToast:[jsonRes valueForKey:@"message"]
                            duration:3.0
                            position:CSToastPositionBottom
                               style:style];
                
                [CSToastManager setSharedStyle:style];
                [CSToastManager setTapToDismissEnabled:YES];
                [CSToastManager setQueueEnabled:YES];
                
                arrAccountData = [[NSMutableArray alloc]init];
                arrAccountData = [jsonRes valueForKey:@"data"];
                NSUserDefaults *userAccounts = [NSUserDefaults standardUserDefaults];
                [userAccounts setObject:arrAccountData forKey:@"userAccounts"];
                [userAccounts synchronize];
                [_collectionAccounts reloadData];

               // [self ApiGetTransactions];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    else if ([strCallType isEqualToString:@"getTransactions"]){
        if (callType == CALL_TYPE_GET_TRANSACTIONS){
            
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
             NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            
            if ([status isEqualToString:@"1"]) {
            arrTransactionData = [[NSMutableArray alloc]init];
            arrSentData = [[NSMutableArray alloc]init];
            arrReceivedData = [[NSMutableArray alloc]init];
            arrTransferredData = [[NSMutableArray alloc]init];
            
            arrTransactionData = [[jsonRes valueForKey:@"data"] valueForKey:@"transaction"];
            
            arrRates = [[jsonRes valueForKey:@"data"] valueForKey:@"rates"];
                
            for (int i = 0; i<[arrTransactionData count]; i++) {
                NSMutableDictionary *dictTemp = [[NSMutableDictionary alloc]init];
                dictTemp = [arrTransactionData objectAtIndex:i];
                NSArray *arrTemp = [dictTemp allKeys];
                for (int j = 0; j < [arrTemp count]; j++) {
                    if ([[dictTemp valueForKey:[arrTemp objectAtIndex:j]] isKindOfClass:[NSNull class]]) {
                        [dictTemp setObject:@"N/A" forKey:[arrTemp objectAtIndex:j]];
                        [arrTransactionData setObject:dictTemp atIndexedSubscript:i];
                    }
                }
            }
  
            NSUserDefaults *userArrAccountData = [NSUserDefaults standardUserDefaults];
            [userArrAccountData setObject:arrTransactionData forKey:@"AccountData"];
            [userArrAccountData synchronize];

            NSDictionary *dictTemp = [[NSDictionary alloc]init];
            
            for (int i = 0; i < [arrTransactionData count]; i ++) {
                dictTemp = [arrTransactionData objectAtIndex:i];
                 NSString *strType = [NSString stringWithFormat: @"%@",[dictTemp valueForKey:@"type"]];
                if ([strType isEqualToString:@"1"]) {
                    [arrSentData addObject:dictTemp];
                }
                else if ([strType isEqualToString:@"2"]) {
                    [arrReceivedData addObject:dictTemp];
                }
                else if ([strType isEqualToString:@"3"]) {
                    [arrTransferredData addObject:dictTemp];
                }
            }
                [self APITokens];
            [_tableTransactions reloadData];
            }
            else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"OK" actionBlock:^(void) {
                }];
                [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
            }
        }
    }
    
    else if ([strCallType isEqualToString:@"tokens"]){
        if (callType == CALL_TYPE_TOKENS){
            NSLog(@"All Tokens: %@",[jsonRes valueForKey:@"data"]);
            
            arrTokenData = [[NSMutableArray alloc]init];
            arrTokenData = [[jsonRes valueForKey:@"data"] valueForKey:@"tokens"];
            
            _lblMainBalance.text = [NSString stringWithFormat:@"%@ %@",[[[jsonRes valueForKey:@"data"] valueForKey:@"balance"]valueForKey:@"symbol"],[[[jsonRes valueForKey:@"data"] valueForKey:@"balance"]valueForKey:@"balance"]];
            
            if ([strWalletCurrency isEqualToString:@"USD"]) {
                _lblBTCbalance.text = [NSString stringWithFormat:@"%@",[[[jsonRes valueForKey:@"data"] valueForKey:@"balance"]valueForKey:@"USD"]];
            }
            else{
                _lblBTCbalance.text = [NSString stringWithFormat:@"%@",[[[jsonRes valueForKey:@"data"] valueForKey:@"balance"]valueForKey:@"BTC"]];
            }
            [self Names];
            
           [_tableTokens reloadData];
            [self ApiGetUserSettings];
            if (TokenPressed == 1) {
                if (isOut)
                {
                    [UIView transitionWithView:_viewDetails
                                      duration:0.8
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                                        _viewTokens.hidden = YES;
                                    }
                                    completion:NULL];
                    isOut = NO;
                }
                else
                {
                    [[[UIApplication sharedApplication] keyWindow] addSubview:_viewDetails];
                    [UIView transitionWithView:_viewDetails
                                      duration:0.8
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                                        _viewTokens.hidden = NO;
                                       // _viewDetails.center = self.view.center;
                                    }
                                    completion:NULL];
                    isOut = YES;
                }
            }
        }
        else{
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            [alert addButton:@"OK" actionBlock:^(void) {
            }];
            [alert showWarning:self.parentViewController title:@"ERW" subTitle:[jsonRes valueForKey:@"message"] closeButtonTitle:nil duration:0.0f];
        }
    }
    else if ([strCallType isEqualToString:@"accountBalances"]){
        if (callType == CALL_TYPE_ACCOUNT_BALANCE){
            NSLog(@"%@",[jsonRes valueForKey:@"data"]);
            
            NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
            if ([status isEqualToString:@"1"]) {
                
                arrTokensInAccount = [[NSMutableArray alloc]init];
                arrTokensInAccount = [jsonRes valueForKey:@"data"];
                [_tableofTokens reloadData];
                
                if (isOut)
                {
                    _viewReceive.hidden = YES;
                    isOut = NO;
                }
                else
                {
                    _viewReceive.hidden = NO;
                    isOut = YES;
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
        else if ([strCallType isEqualToString:@"userSettings"]){
            if (callType == CALL_TYPE_SETTINGS){
                NSLog(@"%@",[jsonRes valueForKey:@"data"]);
                NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
                if ([status isEqualToString:@"1"]) {
                    NSDictionary *dictUserSettings = [jsonRes valueForKey:@"data"];
                    NSUserDefaults *UserSettings = [NSUserDefaults standardUserDefaults];
                    [UserSettings setObject:dictUserSettings forKey:@"usersettings"];
                    [UserSettings synchronize];
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

-(void)Names{
    arrNames = [[NSMutableArray alloc]init];
  /*  for (int i = 0; i<[arrTokenData count]; i++) {
        arrNames = [[arrTokenData objectAtIndex:i] valueForKey:@"name"];
    }*/
    arrNames = [arrTokenData valueForKey:@"token"];
    
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
            if ([[dic2 valueForKey:@"token"] isEqual:str])
            {
                [arrSearchData addObject:dic2];
                // NSLog(@"Result: %@",arrSearchData);
            }
        }
    }
    NSLog(@"%@",arrTokenData);
    [_tableTokens reloadData];
    //[_collectionCoinData reloadData];
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
    //[_collectionCoinData reloadData];
}


- (IBAction)onSegmentClicked:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            _number = 0;
            break;
        case 1:
            _number = 1;
            break;
        case 2:
            _number = 2;
            break;
        case 3:
            _number = 3;
            break;
        default:
            _number = 0;
            break;
    }
    [_tableTransactions reloadData];
}

- (IBAction)onCloseClicked:(id)sender {
    if (isOut)
    {
        TokenPressed = 0;
        [UIView transitionWithView:_viewDetails
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
       // TokenPressed = 1;
       // [self APITokens];
    }
}

- (IBAction)onCloseQRClicked:(id)sender {
    _viewReceive.hidden = YES;
    _viewTransactionPage.hidden = YES;
    _viewAddAccountBack.hidden = YES;
    isOut = NO;
}

- (IBAction)onCopyClicked:(id)sender {
    UIPasteboard *pasteboard1 = [UIPasteboard generalPasteboard];
    pasteboard1.string = [NSString stringWithFormat:@"%@",_strAddress];
    
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

- (IBAction)onTXNIDClicked:(id)sender{
    //https://rinkeby.etherscan.io/tx/
    
    NSString *TxnUrl = [NSString stringWithFormat:@"https://rinkeby.etherscan.io/tx/%@",_lblTxnID.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: TxnUrl]];
}

- (IBAction)onAddAccountClicked:(id)sender {
    [self keyboardWillHide];
    [self ApiCreateAccounts];
}

- (IBAction)onSearchButtonClicked:(id)sender {
    strSearchText = _txtSearchField.text;
    [self ApiGetSearchTransactions];
}
@end
