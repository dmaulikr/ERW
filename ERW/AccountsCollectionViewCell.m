//
//  AccountsCollectionViewCell.m
//  ERW
//
//  Created by nestcode on 3/30/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "AccountsCollectionViewCell.h"

@implementation AccountsCollectionViewCell{
    kFRDLivelyButtonStyle newStyle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _viewBack.layer.cornerRadius = 10.0f;
    _viewBack.layer.masksToBounds = YES;
    _viewBack.layer.shadowOffset = CGSizeMake(-1, 1);
    _viewBack.layer.shadowRadius = 2;
    _viewBack.layer.shadowOpacity = 0.5;
    
}

@end
