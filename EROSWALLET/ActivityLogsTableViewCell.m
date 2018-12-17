//
//  ActivityLogsTableViewCell.m
//  ERW
//
//  Created by nestcode on 4/18/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "ActivityLogsTableViewCell.h"

@implementation ActivityLogsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _viewActivity.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _viewActivity.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

