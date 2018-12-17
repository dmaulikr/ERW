//
//  SidebarTableViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+RJLoader.h"
#import "UIImageView+WebCache.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <sys/utsname.h>
#import "Reachability.h"
#import "ApiCallManager.h"
#import "Constants.h"
#import "HTTPRequestHandler.h"
#import "JSON.h"
#import <Toast/UIView+Toast.h>
#import "SCLAlertView.h"
#import "SVProgressHUD.h"

@interface SidebarTableViewController : UITableViewController<MFMailComposeViewControllerDelegate, ApiCallManagerDelegate,HTTPRequestHandlerDelegate>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@end
