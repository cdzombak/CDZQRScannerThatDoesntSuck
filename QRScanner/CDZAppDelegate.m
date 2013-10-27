//
//  CDZAppDelegate.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZAppDelegate.h"

#import "CDZDataController.h"
#import "CDZRootViewController.h"

@interface CDZAppDelegate ()

@property (nonatomic, readonly) CDZDataController *dataController;

@end

@implementation CDZAppDelegate

@synthesize dataController = _dataController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];

    CDZRootViewController *rootVC = [[CDZRootViewController alloc] initWithDataController:self.dataController];
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:rootVC];

    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - Property overrides

- (CDZDataController *)dataController {
    if (!_dataController) {
        _dataController = [[CDZDataController alloc] init];
    }
    return _dataController;
}

@end
