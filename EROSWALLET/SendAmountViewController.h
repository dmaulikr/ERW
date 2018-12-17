//
//  SendAmountViewController.h
//  ERW
//
//  Created by nestcode on 7/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ApiCallManager.h"
#import "Constants.h"
#import "HTTPRequestHandler.h"
#import "JSON.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "SCLAlertView.h"
#import "AccountsCollectionViewCell.h"
#import "DYQRCodeDecoder.h"
#import <sys/utsname.h>
#import "TokenDataTableViewCell.h"
#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"
#import <Toast/UIView+Toast.h>

@interface SendAmountViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource, ApiCallManagerDelegate, HTTPRequestHandlerDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@property (nonatomic)NSString *strTitle;
@property (nonatomic, assign) NSDictionary *dictACData;

- (IBAction)onCloseClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewToken;
@property (weak, nonatomic) IBOutlet UITextField *txtToken;
@property (weak, nonatomic) IBOutlet UILabel *lblToken;
- (IBAction)onShowTokenClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *viewFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblFrom;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountName;


@property (weak, nonatomic) IBOutlet UIView *viewTo;
@property (weak, nonatomic) IBOutlet UITextField *txtTo;
@property (weak, nonatomic) IBOutlet UILabel *lblTo;
@property (weak, nonatomic) IBOutlet UILabel *lblToAccountNAme;


@property (weak, nonatomic) IBOutlet UIView *viewCurrency;
@property (weak, nonatomic) IBOutlet UITextField *txtCurrency;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrency;


@property (weak, nonatomic) IBOutlet UIView *viewEro;
@property (weak, nonatomic) IBOutlet UITextField *txtERO;
@property (weak, nonatomic) IBOutlet UILabel *lblEro;


@property (weak, nonatomic) IBOutlet UIView *viewNote;
@property (weak, nonatomic) IBOutlet UITextField *txtNote;
@property (weak, nonatomic) IBOutlet UILabel *lblNote;


- (IBAction)onShowClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionAccounts;
- (IBAction)onShowAccountsClicked:(id)sender;
- (IBAction)onShowAccountsToClicked:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewWidth;

@property (weak, nonatomic) IBOutlet UIButton *btnSEND;
- (IBAction)onSendClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewTokens;
@property (weak, nonatomic) IBOutlet UITableView *tableTokens;
@property (weak, nonatomic) IBOutlet UIView *viewForTable;

- (IBAction)onCloseTokenClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *viewVerification;

@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UIView *viewEmail;
@property (weak, nonatomic) IBOutlet UIView *view2FA;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailVerify;
@property (weak, nonatomic) IBOutlet UITextField *txt2FAverifyCode;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;

- (IBAction)onBtnSend:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSendTransactions;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailVerify;
@property (weak, nonatomic) IBOutlet UILabel *lbl2FAVerify;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewVerificationHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2FAtoEmailDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2FAtoPasswordHeight;

- (IBAction)onHideVerificationClicked:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewEmailDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view2FADistance;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewEroDistance;

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;

@property (weak, nonatomic) IBOutlet UIView *viewMaintenance;
@property (weak, nonatomic) IBOutlet UILabel *lblMaintenanceMessage;

@end
