//
//  DashboardViewController.h
//  ERW
//
//  Created by nestcode on 4/11/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXParallaxHeader.h"
#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"
#import "TransactionsTableViewCell.h"
#import "AccountsCollectionViewCell.h"
#import "Constants.h"
#import "UIView+MYPop.h"
#import "SendViewController.h"
#import "Reachability.h"
#import "ApiCallManager.h"
#import "HTTPRequestHandler.h"
#import "JSON.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "SCLAlertView.h"
#import "RecieveViewController.h"
#import "TokenDataTableViewCell.h"
#import "UIImage+MDQRCode.h"
#import <Toast/UIView+Toast.h>
#import "AccountBalancesTableViewCell.h"
#import "AppDelegate.h"
#import "YLProgressBar.h"

@interface DashboardViewController : UIViewController <MXParallaxHeaderDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource, ApiCallManagerDelegate, HTTPRequestHandlerDelegate, UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnTitle;

@property (nonatomic, assign) NSInteger number;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblMainBalance;
@property (weak, nonatomic) IBOutlet UILabel *lblBTCbalance;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAccounts;
@property (weak, nonatomic) IBOutlet UIView *viewSegments;

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;

@property (weak, nonatomic) IBOutlet UIView *viewReceiveQR;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSearch;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnTOKENS;

- (IBAction)onSearchClicked:(id)sender;
- (IBAction)onTokensClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewSearch;


@property (retain, nonatomic) IBOutlet UITableView *tableTransactions;

@property (weak, nonatomic) IBOutlet UIView *viewDetails;


@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTransactions;

- (IBAction)onSegmentClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewTokens;
@property (weak, nonatomic) IBOutlet UITableView *tableTokens;
@property (weak, nonatomic) IBOutlet UIView *viewForTable;

- (IBAction)onCloseClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageQRCode;

@property (nonatomic, assign) NSString *strAddress;

@property (weak, nonatomic) IBOutlet UIView *viewReceive;
- (IBAction)onCloseQRClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

- (IBAction)onCopyClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewReceiveQRCode;

@property (weak, nonatomic) IBOutlet UITableView *tableofTokens;

@property (weak, nonatomic) IBOutlet UIView *viewAccountBalances;

@property (weak, nonatomic) IBOutlet UIView *viewTransactionPage;

@property (weak, nonatomic) IBOutlet UIView *viewTransacrtionDetail;
@property (weak, nonatomic) IBOutlet UIView *viewTransactionHeader;

@property (weak, nonatomic) IBOutlet UILabel *lblTransaction;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionUSDAmount;
@property (weak, nonatomic) IBOutlet UIImageView *imgCoin;
@property (weak, nonatomic) IBOutlet UIImageView *imgTransaction;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblTo;
@property (weak, nonatomic) IBOutlet UILabel *lblTxnID;
@property (weak, nonatomic) IBOutlet UILabel *lblNote;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionTime;


- (IBAction)onTXNIDClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgBack;

@property (weak, nonatomic) IBOutlet UIView *viewAddAccountBack;
@property (weak, nonatomic) IBOutlet UIView *viewAddAccountHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnAddAccount;
- (IBAction)onAddAccountClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewAccountName;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtAccountName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (nonatomic, assign) float DoneSocket;
@property (nonatomic, assign) float Required;
@property (nonatomic, assign) NSString *strID;

@property (weak, nonatomic) IBOutlet UITextField *txtSearchField;

- (IBAction)onSearchButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblStaticAccountName;


@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;


@property (weak, nonatomic) IBOutlet UIView *viewMaintenance;
@property (weak, nonatomic) IBOutlet UILabel *lblMaintenanceMessage;






@end
