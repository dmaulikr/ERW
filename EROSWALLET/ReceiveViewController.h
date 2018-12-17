//
//  ReceiveViewController.h
//  ERW
//
//  Created by nestcode on 7/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+MDQRCode.h"
#import <Toast/UIView+Toast.h>
#import "AccountsCollectionViewCell.h"
#import "SWRevealViewController.h"
#import "SCLAlertView.h"

@interface ReceiveViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionAccounts;

@property (weak, nonatomic) IBOutlet UIImageView *imageQRCode;

- (IBAction)onCopyClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountID;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@property (weak, nonatomic) IBOutlet UIView *viewMaintenance;
@property (weak, nonatomic) IBOutlet UILabel *lblMaintenanceMessage;

@end
