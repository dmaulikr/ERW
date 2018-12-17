//
//  AppDelegate.h
//  ERW
//
//  Created by nestcode on 3/27/18.
//  Copyright © 2018 nestcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardViewController.h"

@import SocketIO;
@import Firebase;
@import FirebaseInstanceID;
@import FirebaseMessaging;

@interface AppDelegate : UIResponder <UIApplicationDelegate,FIRMessagingDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SocketManager* manager;

-(void)ConnectSocket;

@end

