//
//  AccountBalanceViewController.h
//  ERW
//
//  Created by nestcode on 7/2/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <Toast/UIView+Toast.h>
#import "AccountBalancesTableViewCell.h"
#import "AccountsCollectionViewCell.h"
#import "Constants.h"
#import "UIView+MYPop.h"
#import "SendViewController.h"
#import "Reachability.h"
#import "ApiCallManager.h"
#import "HTTPRequestHandler.h"
#import "JSON.h"
#import "SVProgressHUD.h"
#import "SCLAlertView.h"

@interface AccountBalanceViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,ApiCallManagerDelegate, HTTPRequestHandlerDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>{
    HTTPRequestHandler *requestHandler;
    id<ApiCallManagerDelegate>_delegate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableTokens;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAccounts;

@property (weak, nonatomic) IBOutlet UISearchBar *searchField;

@end
