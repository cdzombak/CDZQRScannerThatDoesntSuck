//
//  CDZScansListViewController.h
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

@class CDZDataController;

@interface CDZScansListViewController : UITableViewController

@property (nonatomic, strong) CDZDataController *dataController;

/// Designated initializer
- (instancetype)initWithDataController:(CDZDataController *)dataController;

@end
