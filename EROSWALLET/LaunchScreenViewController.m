//
//  LaunchScreenViewController.m
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import "LaunchScreenViewController.h"

#define kMaxRadius 400
#define kMaxDuration 10

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController{
    NSUserDefaults *isLogin;
    NSInteger isLoginNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    isLogin = [NSUserDefaults standardUserDefaults];
    [self.topButton buttonPressAnimation];
    
    
    
    [UIView animateWithDuration:1.0f animations:^{
        
        self.imgERO.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished){
        
    }];
    // for zoom out
    [UIView animateWithDuration:1.0f animations:^{
        
        self.imgERO.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finished){
        
    }];
    
    PulsingHaloLayer *layer = [PulsingHaloLayer layer];
    self.halo = layer;
    [self.imgPulse.superview.layer insertSublayer:self.halo below:self.imgPulse.layer];
    [self setupInitialValues];
    [self.halo start];
    
    [self performSelector:@selector(toNewViewController) withObject:nil afterDelay:5.0];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.halo.position = self.imgPulse.center;
}

- (void)setupInitialValues {
    
    self.halo.haloLayerNumber = 3;
  
    self.halo.radius =  kMaxRadius;

    self.halo.animationDuration = 0.4 * kMaxDuration;
   
    [self.halo setBackgroundColor:[self colorWithHexString:waveClr].CGColor];
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated]; 
}

-(void)toNewViewController{
    isLoginNum = [isLogin integerForKey:@"isLogin"];
    
    if (isLoginNum == 1) {
        [self performSegueWithIdentifier:@"toHome" sender:self];
    }else{
        [self performSegueWithIdentifier:@"toLogin" sender:self];
    }
}

-(void)toLoginViewController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *SendVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:SendVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
