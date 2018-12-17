//
//  ActivityLogViewController.h
//  ERW
//
//  Created by nestcode on 4/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "ApiCallManager.h"
#import "Constants.h"
#import "HTTPRequestHandler.h"
#import "JSON.h"
#import "SWRevealViewController.h"
#import "SVProgressHUD.h"
#import "ActivityLogsTableViewCell.h"

@interface ActivityLogViewController : UIViewController<ApiCallManagerDelegate,HTTPRequestHandlerDelegate,UITableViewDelegate,UITableViewDataSource>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableActivities;


@end
