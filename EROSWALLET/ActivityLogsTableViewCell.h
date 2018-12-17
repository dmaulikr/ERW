//
//  ActivityLogsTableViewCell.h
//  ERW
//
//  Created by nestcode on 4/18/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityLogsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgActivityType;
@property (weak, nonatomic) IBOutlet UILabel *lblActivityType;
@property (weak, nonatomic) IBOutlet UILabel *lblIPAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@property (weak, nonatomic) IBOutlet UIImageView *imgOS;
@property (weak, nonatomic) IBOutlet UIImageView *imgBrowser;
@property (weak, nonatomic) IBOutlet UILabel *lblActivity;

@property (weak, nonatomic) IBOutlet UIView *viewActivity;


@end
