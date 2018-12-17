//
//  ReceiveViewController.m
//  ERW
//
//  Created by nestcode on 7/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "ReceiveViewController.h"

@interface ReceiveViewController ()

@end

@implementation ReceiveViewController{
    NSMutableArray *arrAccountData, *arrColors;
    NSUserDefaults *userAccounts, *userSelectedIndex, *userArrColors, *UserToken, *UserUDID, *userSelectedCurr, *isLogin;
    NSString *strAccount, *strTitle, *strAccountID;
    NSInteger SelectedIndex;
    NSString *strUDID, *strCallType, *strToken;
    NSString *strSelectedCurr;
    int isMaintain;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    _viewMaintenance.hidden = YES;
    
    if (arrAccountData.count == 0) {
    /*    SCLAlertView *alert = [[SCLAlertView alloc] init];
        [alert addButton:@"OK" actionBlock:^(void) {
        }];
        [alert showWarning:self.parentViewController title:@"ERW" subTitle:@"You Haven't Created Any Account Yet!! Create Account First Then Only You Can Use Receive Function!!" closeButtonTitle:nil duration:0.0f];*/
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"You Haven't Created Any Account Yet!! Create Account First Then Only You Can Use Receive Function!!"
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
    }
    UIImage *imgQR = [UIImage mdQRCodeForString:strAccount size:150.0f];
    _imageQRCode.image = imgQR;
    _lblAccountID.text = strAccount;
    
    userSelectedCurr = [NSUserDefaults standardUserDefaults];
    strSelectedCurr = [[userSelectedCurr valueForKey:@"userSelectedCurr"] lowercaseString];
    
    if (strSelectedCurr == nil) {
        strSelectedCurr = @"USD";
    }
    
    [self Maintenance];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Maintenance) name:@"ReceiveMaintain" object:nil];
    
}

-(void)Maintenance{
    
    NSDictionary *SettingMaintain = [[NSDictionary alloc]init];
    NSUserDefaults *userReceiveMaintain = [NSUserDefaults standardUserDefaults];
    SettingMaintain = [userReceiveMaintain objectForKey:@"userReceiveMaintain"];
    
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

- (IBAction)onCopyClicked:(id)sender {
    UIPasteboard *pasteboard1 = [UIPasteboard generalPasteboard];
    pasteboard1.string = [NSString stringWithFormat:@"%@",strAccount];
    
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

#pragma mark CollectioView - Data

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
    
    UIImage *imgQR = [UIImage mdQRCodeForString:strAccount size:150.0f];
    _imageQRCode.image = imgQR;
    _lblAccountID.text = strAccount;
    
    strAccountID = [NSString stringWithFormat:@"%@",[dictTemp valueForKey:@"_id"]];
    [_collectionAccounts reloadData];
}















@end
