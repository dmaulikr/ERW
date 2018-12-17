//
//  SeedsCollectionViewCell.m
//  ERW
//
//  Created by nestcode on 7/7/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "SeedsCollectionViewCell.h"

@implementation SeedsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer setBorderColor:[self colorWithHexString:ThemeColor].CGColor];
    [self.layer setBorderWidth:1.0f];
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor whiteColor];
        _lblSeedName.textColor = [self colorWithHexString:ThemeColor];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
    } else {
        [self setBackgroundColor:[self colorWithHexString:ThemeColor]];
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        _lblSeedName.textColor = [UIColor whiteColor];
        BackupSeedsViewController *backUp = [[BackupSeedsViewController alloc]init];
      //  [backUp Seeds:0];
    }
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
