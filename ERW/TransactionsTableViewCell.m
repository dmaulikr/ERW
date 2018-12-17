//
//  TransactionsTableViewCell.m
//  ERW
//
//  Created by nestcode on 3/31/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "TransactionsTableViewCell.h"

@implementation TransactionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self initRoundedSlimProgressBar];
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [_transactionProgress setProgress:progress animated:animated];
}
- (void)initRoundedSlimProgressBar
{
    _transactionProgress.progressTintColor        = [UIColor colorWithRed:239/255.0f green:225/255.0f blue:13/255.0f alpha:1.0f];
    _transactionProgress.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayModeTrack;
    _transactionProgress.stripesColor             = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.36f];
}

@end
