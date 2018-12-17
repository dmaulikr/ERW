//
//  LaunchScreenViewController.h
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "BAPulseButton.h"
#import "PulsingHaloLayer.h"

@interface LaunchScreenViewController : UIViewController

@property (strong, nonatomic) IBOutlet BAPulseButton *topButton;
@property (nonatomic, weak) PulsingHaloLayer *halo;
@property (weak, nonatomic) IBOutlet UIImageView *imgERO;
@property (weak, nonatomic) IBOutlet UIImageView *imgPulse;

@end
