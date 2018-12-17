//
//  TransactionDoneViewController.h
//  ERW
//
//  Created by nestcode on 6/30/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionDoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTransactionID;
@property (weak, nonatomic) IBOutlet UILabel *lblFromAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblToAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTransactionStatus;


- (IBAction)onDoneClicked:(id)sender;



@end
