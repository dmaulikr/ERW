//
//  AccountsCollectionViewCell.h
//  ERW
//
//  Created by nestcode on 3/30/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRDLivelyButton.h"


@interface AccountsCollectionViewCell : UICollectionViewCell



@property (weak, nonatomic) IBOutlet UIView *viewBack;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountName;
@property (weak, nonatomic) IBOutlet UILabel *lblEroPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblAccountBalance;
@property (weak, nonatomic) IBOutlet UIButton *btnScan;

@property (weak, nonatomic) IBOutlet UILabel *lblSelected;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UIButton *btnQR;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
@property (weak, nonatomic) IBOutlet UIButton *btnView;

@property (weak, nonatomic) IBOutlet UIButton *btnScanQR;

@property (weak, nonatomic) IBOutlet UIButton *btnScan1;

@end
