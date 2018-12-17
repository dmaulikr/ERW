//
//  TokenDataTableViewCell.h
//  ERW
//
//  Created by nestcode on 4/10/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TokenDataTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTokenNAme;

@property (weak, nonatomic) IBOutlet UIImageView *imgToken;

@property (weak, nonatomic) IBOutlet UILabel *lblBTCBalance;
@property (weak, nonatomic) IBOutlet UILabel *lblUSDBalance;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstant;

@end
