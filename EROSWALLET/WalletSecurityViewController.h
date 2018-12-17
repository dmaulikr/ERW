//
//  WalletSecurityViewController.h
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
#import "UIImage+MDQRCode.h"

@interface WalletSecurityViewController : UIViewController<ApiCallManagerDelegate,HTTPRequestHandlerDelegate,UITextFieldDelegate>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollWalletSecurity;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UISwitch *switchTwoFactor;
@property (weak, nonatomic) IBOutlet UISwitch *switchEmailVerification;
@property (weak, nonatomic) IBOutlet UISwitch *switchActivityLog;

@property (weak, nonatomic) IBOutlet UILabel *lblTwoFactor;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailVerification;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityLog;

- (IBAction)onChangePasswordClicked:(id)sender;

- (IBAction)onSwitch2FAClicked:(id)sender;
- (IBAction)onSwitchEmailVerificationClicked:(id)sender;
- (IBAction)onSwitchActivityLogsClicked:(id)sender;

- (IBAction)onHidePassClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewPasswordUpdate;
@property (weak, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassWord;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPass;
@property (weak, nonatomic) IBOutlet UIView *viewOldPass;
@property (weak, nonatomic) IBOutlet UIView *viewNewPass;
@property (weak, nonatomic) IBOutlet UIView *viewConfirmPass;
- (IBAction)onUpdatePassClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *view2FAUpdate;

@property (weak, nonatomic) IBOutlet UIImageView *imgQR;

@property (weak, nonatomic) IBOutlet UITextField *txtEnterPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtAuthCode;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthKey;
- (IBAction)onCopyClicked:(id)sender;

- (IBAction)onUpdateAuthCicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewAuthKey;
@property (weak, nonatomic) IBOutlet UIView *viewEnterPass;
@property (weak, nonatomic) IBOutlet UIView *viewAuthCode;

@property (weak, nonatomic) IBOutlet UISwitch *switchTransPassword;
- (IBAction)onSwitchTransClicked:(id)sender;
- (IBAction)onEditTransPassClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTransPasswordStatus;

@property (weak, nonatomic) IBOutlet UIView *viewTransPass;
@property (weak, nonatomic) IBOutlet UIView *viewEnterTransPass;
@property (weak, nonatomic) IBOutlet UITextField *txtTransPass;
@property (weak, nonatomic) IBOutlet UIView *viewReEnterTransPass;
@property (weak, nonatomic) IBOutlet UITextField *txtReEnterTransPass;

- (IBAction)onChangeTransPassClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblBackUpSeeds;
@property (weak, nonatomic) IBOutlet UIButton *btnBackUpSeeds;
- (IBAction)onBackUpSeedsClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *viewMaintenance;
@property (weak, nonatomic) IBOutlet UILabel *lblMaintenanceMessage;

@end
