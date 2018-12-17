//
//  TransactionsTableViewCell.h
//  ERW
//
//  Created by nestcode on 3/31/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"

@interface TransactionsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imgTokens;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactions;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgSentRecieved;
@property (weak, nonatomic) IBOutlet UIButton *btnNote;
@property (weak, nonatomic) IBOutlet UIButton *btnShowHide;
@property (weak, nonatomic) IBOutlet UILabel *lblAmountTransact;
@property (weak, nonatomic) IBOutlet UILabel *lblAmountDollers;
@property (weak, nonatomic) IBOutlet UIImageView *imgNote;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;

@property (weak, nonatomic) IBOutlet YLProgressBar *transactionProgress;


@end
