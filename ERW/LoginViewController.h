//
//  LoginViewController.h
//  ERW
//
//  Created by nestcode on 4/4/18.
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
#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"
#import "DYQRCodeDecoder.h"
#import <sys/utsname.h>
#import "SCLAlertView.h"

@interface LoginViewController : UIViewController <ApiCallManagerDelegate,HTTPRequestHandlerDelegate,UITextFieldDelegate>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

- (IBAction)onScanClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewWalletID;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtWalletID;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)onLoginClicked:(id)sender;

- (IBAction)onShowPasswordClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShowPass;

@end
