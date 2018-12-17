//
//  BackupSeedsViewController.h
//  ERW
//
//  Created by nestcode on 7/6/18.
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
#import "SeedsCollectionViewCell.h"
#import "MICollectionViewBubbleLayout.h"

@interface BackupSeedsViewController : UIViewController<ApiCallManagerDelegate,HTTPRequestHandlerDelegate,UITextFieldDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MICollectionViewBubbleLayoutDelegate>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgCheckMark;

- (IBAction)onCheckMarkClicked:(id)sender;
- (IBAction)onGenerateSeedsClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewNoScreenShot;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

- (IBAction)onCloseNoSSClicked:(id)sender;
- (IBAction)onUnderstandClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *viewWriteSeeds;
- (IBAction)onIWrittenClicedk:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnWriteSeedsClose;
@property (weak, nonatomic) IBOutlet UIView *viewEnterPassword;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblSeeds;

- (IBAction)onExitClicked:(id)sender;
- (IBAction)onVerifyClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionSeeds;

@property (weak, nonatomic) IBOutlet UILabel *lblWrittenSeeds;

@property (weak, nonatomic) IBOutlet UIView *viewWriteSeedsScreen;


@property (weak, nonatomic) IBOutlet UIView *viewNoteSeeds;

-(void)Seeds:(int)flag;


- (IBAction)onSubmitBackUpClicked:(id)sender;

- (IBAction)btnSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end
