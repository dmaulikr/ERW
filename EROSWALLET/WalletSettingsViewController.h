//
//  WalletSettingsViewController.h
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ApiCallManager.h"
#import "Constants.h"
#import "HTTPRequestHandler.h"
#import "JSON.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import <Toast/UIView+Toast.h>
#import "SCLAlertView.h"
#import "ActionSheetPicker.h"
#import "WalletCurrencyTableViewCell.h"

@interface WalletSettingsViewController : UIViewController<ApiCallManagerDelegate,HTTPRequestHandlerDelegate,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollWalletSettings;


@property (weak, nonatomic) IBOutlet UIView *viewWalletID;
@property (weak, nonatomic) IBOutlet UIView *viewEmailAdd;
@property (weak, nonatomic) IBOutlet UIView *viewMobileNum;
@property (weak, nonatomic) IBOutlet UIView *viewWalletLanguage;
@property (weak, nonatomic) IBOutlet UIView *viewWalletCurrency;
@property (weak, nonatomic) IBOutlet UIView *viewNotifications;

- (IBAction)onEmailChangeClicked:(id)sender;
- (IBAction)onMobileNumChangedClicked:(id)sender;
- (IBAction)onWalletCurrencyClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchEmail;
@property (weak, nonatomic) IBOutlet UISwitch *switchPushNotification;

- (IBAction)onEmailNotificationSwichClicked:(id)sender;
- (IBAction)onPushNotificationSwitchClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblWalletID;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailID;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblLanguage;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrency;

@property (weak, nonatomic) IBOutlet UIView *viewUpdates;

@property (weak, nonatomic) IBOutlet UIView *viewChangeEmail;
@property (weak, nonatomic) IBOutlet UIView *viewForEmailChange;
- (IBAction)onEmailChangeDoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEmaiID;

@property (weak, nonatomic) IBOutlet UIView *viewChangeMobile;
@property (weak, nonatomic) IBOutlet UIView *viewForMobileChange;
- (IBAction)onMobileChangeDoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;

- (IBAction)onCloseUpdateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblisEMAILVerified;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentWalletCurrency;
- (IBAction)onSegmentWalletCurrencyClicked:(id)sender;

- (IBAction)onEditTransPassClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblWalletCurrencies;
- (IBAction)onWalletCurrClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewCurrencies;
- (IBAction)onCloseCurrenciesClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UISearchBar *searchField;
@property (weak, nonatomic) IBOutlet UITableView *tableCurrencies;


@property (weak, nonatomic) IBOutlet UIView *viewMaintenance;
@property (weak, nonatomic) IBOutlet UILabel *lblMaintenanceMessage;

@end
