//
//  RecieveViewController.m
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "RecieveViewController.h"

@interface RecieveViewController ()

@end

@implementation RecieveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *imgQR = [UIImage mdQRCodeForString:_strAddress size:150.0f];
    _imageQRCode.image = imgQR;
    _lblAddress.text = _strAddress;
    
}

- (IBAction)onCloseClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onCopyClicked:(id)sender {
    
    UIPasteboard *pasteboard1 = [UIPasteboard generalPasteboard];
    pasteboard1.string = [NSString stringWithFormat:@"%@",_strAddress];
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor orangeColor];
    [self.view makeToast:@"Address Copied Successful."
                duration:3.0
                position:CSToastPositionBottom
                   style:style];
    
    [CSToastManager setSharedStyle:style];
    [CSToastManager setTapToDismissEnabled:YES];
    [CSToastManager setQueueEnabled:YES];
    
}
@end
