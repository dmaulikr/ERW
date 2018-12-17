//
//  RegisterViewController.h
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

@interface RegisterViewController : UIViewController<ApiCallManagerDelegate,HTTPRequestHandlerDelegate,UITextFieldDelegate,CAAnimationDelegate>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)onBackClicked:(id)sender;
- (IBAction)onNextClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewSeeds;

- (IBAction)onCloseClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;



@property (weak, nonatomic) IBOutlet UIView *viewCode1;
@property (weak, nonatomic) IBOutlet UIView *viewCode2;
@property (weak, nonatomic) IBOutlet UIView *viewCode3;
@property (weak, nonatomic) IBOutlet UIView *viewCode4;

@property (weak, nonatomic) IBOutlet UILabel *lblCode1;
@property (weak, nonatomic) IBOutlet UILabel *lblCode2;
@property (weak, nonatomic) IBOutlet UILabel *lblCode3;
@property (weak, nonatomic) IBOutlet UILabel *lblCode4;


@property (weak, nonatomic) IBOutlet UIView *viewCode5;
@property (weak, nonatomic) IBOutlet UIView *viewCode6;
@property (weak, nonatomic) IBOutlet UIView *viewCode7;
@property (weak, nonatomic) IBOutlet UIView *viewCode8;

@property (weak, nonatomic) IBOutlet UILabel *lblCode5;
@property (weak, nonatomic) IBOutlet UILabel *lblCode6;
@property (weak, nonatomic) IBOutlet UILabel *lblCode7;
@property (weak, nonatomic) IBOutlet UILabel *lblCode8;


@property (weak, nonatomic) IBOutlet UIView *viewCode9;
@property (weak, nonatomic) IBOutlet UIView *viewCode10;
@property (weak, nonatomic) IBOutlet UIView *viewCode11;
@property (weak, nonatomic) IBOutlet UIView *viewCode12;

@property (weak, nonatomic) IBOutlet UILabel *lblCode9;
@property (weak, nonatomic) IBOutlet UILabel *lblCode10;
@property (weak, nonatomic) IBOutlet UILabel *lblCode11;
@property (weak, nonatomic) IBOutlet UILabel *lblCode12;

@property (weak, nonatomic) IBOutlet UIView *viewEnterSeeds;

@property (weak, nonatomic) IBOutlet UIView *viewSeeds1;
@property (weak, nonatomic) IBOutlet UIView *viewSeeds2;
@property (weak, nonatomic) IBOutlet UIView *viewSeeds3;
@property (weak, nonatomic) IBOutlet UIView *viewSeeds4;

@property (weak, nonatomic) IBOutlet UILabel *lblSeeds1;
@property (weak, nonatomic) IBOutlet UILabel *lblSeeds2;
@property (weak, nonatomic) IBOutlet UILabel *lblSeeds3;
@property (weak, nonatomic) IBOutlet UILabel *lblSeeds4;

@property (weak, nonatomic) IBOutlet UITextField *txtCode1;
@property (weak, nonatomic) IBOutlet UITextField *txtCode2;
@property (weak, nonatomic) IBOutlet UITextField *txtCode3;
@property (weak, nonatomic) IBOutlet UITextField *txtCode4;



- (IBAction)onSubmitAndRegisterClicked:(id)sender;

- (IBAction)onLoginClicked:(id)sender;

- (IBAction)onRegisterClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UIView *viewEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)onShowPasswordClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShowPass;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgDistance;


@end
