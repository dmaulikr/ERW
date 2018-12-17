//
//  RecieveViewController.h
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+MDQRCode.h"
#import <Toast/UIView+Toast.h>

@interface RecieveViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageQRCode;

@property (nonatomic, assign) NSString *strAddress;

- (IBAction)onCloseClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

- (IBAction)onCopyClicked:(id)sender;


@end
