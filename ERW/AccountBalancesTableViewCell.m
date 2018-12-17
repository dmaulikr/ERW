//
//  AccountBalancesTableViewCell.m
//  ERW
//
//  Created by nestcode on 4/16/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "AccountBalancesTableViewCell.h"

@implementation AccountBalancesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _viewBack.layer.borderWidth = 0.5f;
    _viewBack.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
