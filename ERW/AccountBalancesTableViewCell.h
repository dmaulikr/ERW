//
//  AccountBalancesTableViewCell.h
//  ERW
//
//  Created by nestcode on 4/16/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountBalancesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTokenNAme;

@property (weak, nonatomic) IBOutlet UIImageView *imgToken;

@property (weak, nonatomic) IBOutlet UILabel *lblBTCBalance;
@property (weak, nonatomic) IBOutlet UILabel *lblUSDBalance;


@property (weak, nonatomic) IBOutlet UIView *viewBack;

@end
