//
//  MainViewController.m
//  LGSideMenuControllerDemo
//

#import "MainViewController.h"
#import "leftViewController.h"
#import "ViewController.h"


@interface MainViewController ()

@property (assign, nonatomic) NSUInteger type;

@end

@implementation MainViewController

- (void)setupWithType:(NSUInteger)type {
    self.type = type;

    // -----

    if (self.storyboard) {
        // Left and Right view controllers is set in storyboard
        // Use custom segues with class "LGSideMenuSegue" and identifiers "left" and "right"

        // Sizes and styles is set in storybord
        // You can also find there all other properties

        // LGSideMenuController fully customizable from storyboard
    }
    else {
        self.leftViewController = [leftViewController new];
        self.leftViewWidth = 250.0;
        self.leftViewBackgroundImage = [UIImage imageNamed:@"imageLeft.png"];
        self.leftViewBackgroundColor = [UIColor whiteColor];
        self.rootViewCoverColorForLeftView = [UIColor whiteColor];
    }

    // -----

    UIBlurEffectStyle regularStyle;

    if (UIDevice.currentDevice.systemVersion.floatValue >= 10.0) {
        regularStyle = UIBlurEffectStyleRegular;
    }
    else {
        regularStyle = UIBlurEffectStyleLight;
    }

    // -----
    self.leftViewPresentationStyle = LGSideMenuPresentationStyleSlideBelow;

}

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];

    if (!self.isLeftViewStatusBarHidden) {
        self.leftView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
    }
}

- (void)rightViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super rightViewWillLayoutSubviewsWithSize:size];

    if (!self.isRightViewStatusBarHidden ||
        (self.rightViewAlwaysVisibleOptions & LGSideMenuAlwaysVisibleOnPadLandscape &&
         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad &&
         UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation))) {
        self.rightView.frame = CGRectMake(0.0, 20.0, size.width, size.height-20.0);
    }
}

- (BOOL)isLeftViewStatusBarHidden {
       return super.isLeftViewStatusBarHidden;
}

- (void)dealloc {
    NSLog(@"MainViewController deallocated");
}

@end
