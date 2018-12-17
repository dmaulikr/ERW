 //
//  AccountBalanceViewController.m
//  ERW
//
//  Created by nestcode on 7/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "AccountBalanceViewController.h"

@interface AccountBalanceViewController ()

@end

@implementation AccountBalanceViewController{
    NSMutableArray *arrAccountData, *arrColors, *arrAcountBalances, *arrNames;
    NSUserDefaults *userAccounts, *userSelectedIndex, *userArrColors, *UserToken, *UserUDID, *userSelectedCurr, *isLogin;
    NSString *strAccount, *strTitle, *strAccountID;
    NSInteger SelectedIndex;
    NSString *strUDID, *strCallType, *strToken;
    NSString *strSelectedCurr;
    NSMutableArray *arrSearchData;
    NSArray *arrSearchResult;
    BOOL searchEnabled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserToken = [NSUserDefaults standardUserDefaults];
    UserUDID = [NSUserDefaults standardUserDefaults];
    
    strToken = [NSString stringWithFormat:@"%@",[UserToken valueForKey:@"userToken"]];
    strUDID = [NSString stringWithFormat:@"%@",[UserUDID valueForKey:@"userUDID"]];
    
    userSelectedCurr = [NSUserDefaults standardUserDefaults];
    strSelectedCurr = [[userSelectedCurr valueForKey:@"userSelectedCurr"] lowercaseString];
    
    if (strSelectedCurr == nil) {
        strSelectedCurr = @"USD";
    }
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    userAccounts = [NSUserDefaults standardUserDefaults];
    arrAccountData = [[NSMutableArray alloc]init];
    arrAccountData = [userAccounts objectForKey:@"userAccounts"];
    
    userArrColors = [NSUserDefaults standardUserDefaults];
    arrColors = [[NSMutableArray alloc]init];
    arrColors = [userArrColors objectForKey:@"colors"];
    
    userSelectedIndex = [NSUserDefaults standardUserDefaults];
    [userSelectedIndex setInteger:0 forKey:@"selected"];
    [userSelectedIndex synchronize];
    
    if (arrAccountData.count == 0) {
     /*   SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"You Haven't Created Any Account Yet!! Create Account First To See Balances!!" closeButtonTitle:nil duration:0.0f];*/
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"You Haven't Created Any Account Yet!! Create Account First To See Available Balances!!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        self.view.userInteractionEnabled = NO;
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
        strAccount = [NSString stringWithFormat:@"%@",[[arrAccountData objectAtIndex:0]valueForKey:@"address"]];
        strAccountID = [NSString stringWithFormat:@"%@",[[arrAccountData objectAtIndex:0]valueForKey:@"_id"]];
        [self APIAccountBalances];
    }
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

#pragma mark - CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [arrAccountData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"accountCell";
    AccountsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell.viewBack setBackgroundColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
    
    [cell.lblSelected setTextColor:[self colorWithHexString:[arrColors objectAtIndex:indexPath.row]]];
    
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((150), (100));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [userSelectedIndex setInteger:indexPath.row forKey:@"selected"];
    [userSelectedIndex synchronize];
    
    
    NSDictionary *dictTemp = [arrAccountData objectAtIndex:indexPath.row];
    strAccount = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"address"]];
    strTitle = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"name"]];
    
    strAccountID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
    [_collectionAccounts reloadData];
    [self APIAccountBalances];
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
        return arrAcountBalances.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountBalancesTableViewCell *cell = [self.tableTokens dequeueReusableCellWithIdentifier:@"AccountBalancesTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictTemp = [[NSDictionary alloc]init];
    
    if (searchEnabled) {
        dictTemp = [arrSearchData objectAtIndex:indexPath.row];
    }
    else{
         dictTemp = [arrAcountBalances objectAtIndex:indexPath.row];
    }
    
   
    
    
    cell.lblTokenNAme.text = [NSString stringWithFormat:@"%@",[[dictTemp objectForKey:@"token"]valueForKey:@"name"]];
    
    NSString *strImgUrl = [NSString stringWithFormat:@"%@%@",URL_IMAGE,[[dictTemp objectForKey:@"token"]valueForKey:@"icon"]];
    
    NSString *strBTC = [NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"balance"]];
    cell.lblBTCBalance.text = strBTC;
    
//    if ([strSelectedCurr isEqualToString:@"USD"]) {
        
        NSString *strUSD = [NSString stringWithFormat:@"$%@",[[dictTemp objectForKey:@"market"]valueForKey:@"usd"]];
        cell.lblUSDBalance.text = strUSD;
//    }
//    else{
//        NSString *strUSD = [NSString stringWithFormat:@"฿%@",[[dictTemp objectForKey:@"market"]valueForKey:@"btc"]];
//        cell.lblUSDBalance.text = strUSD;
//    }
    [cell.imgToken sd_setImageWithURL:[NSURL URLWithString:strImgUrl] placeholderImage:[UIImage imageNamed:@"Thumnail.png"] options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [cell.imgToken updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [cell.imgToken reveal];
    }];
    return cell;;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
        if ([strCallType isEqualToString:@"accountBalances"]){
            if (callType == CALL_TYPE_ACCOUNT_BALANCE){
                NSLog(@"%@",[jsonRes valueForKey:@"data"]);
                
                NSString *status = [NSString stringWithFormat:@"%@",[jsonRes valueForKey:@"status"]];
                if ([status isEqualToString:@"1"]) {
                    
                    arrAcountBalances = [[NSMutableArray alloc]init];
                    arrAcountBalances = [jsonRes valueForKey:@"data"];
                    [_tableTokens reloadData];
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
    }
}


-(void)Names{
    arrNames = [[NSMutableArray alloc]init];
    arrNames = [[arrAcountBalances valueForKey:@"token"] valueForKey:@"name"];
    
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    arrSearchData = [[NSMutableArray alloc]init];
    NSPredicate *resultPredicate = [NSCompoundPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    
    arrSearchResult = [arrNames filteredArrayUsingPredicate:resultPredicate];
    
    for (int i=0; i<[arrSearchResult count]; i++) {
        NSString *str = [arrSearchResult objectAtIndex:i];
        for ( NSDictionary *dic2 in arrAcountBalances)
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
