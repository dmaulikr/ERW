//
//  TransactionDoneViewController.m
//  ERW
//
//  Created by nestcode on 6/30/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "TransactionDoneViewController.h"

@interface TransactionDoneViewController ()

@end

@implementation TransactionDoneViewController{
    NSUserDefaults *userTransactionDetails;
    NSDictionary *dictTransactionData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dictTransactionData = [[NSDictionary alloc]init];
    userTransactionDetails = [NSUserDefaults standardUserDefaults];
    dictTransactionData = [userTransactionDetails objectForKey:@"userTransactionDetails"];
    
    [self Data];
}

- (void)Data{
    
    _lblTransactionID.text = [NSString stringWithFormat:@"%@",[dictTransactionData valueForKey:@"tid"]];
    _lblFromAccount.text = [NSString stringWithFormat:@"%@",[dictTransactionData valueForKey:@"from"]];
    _lblToAccount.text = [NSString stringWithFormat:@"%@",[dictTransactionData valueForKey:@"to"]];
    
    NSString *strAmount = [NSString stringWithFormat:@"%@",[dictTransactionData valueForKey:@"amount"]];
    _lblTransactionAmount.text = strAmount;
    
    
    _lblTransactionStatus.text = @"PENDING CONFIRMATION";
    
}

- (IBAction)onDoneClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
