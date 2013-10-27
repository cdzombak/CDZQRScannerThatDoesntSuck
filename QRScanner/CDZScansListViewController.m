//
//  CDZScansListViewController.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScansListViewController.h"

#import <SSDataSources/SSDataSources.h>
#import "CDZDataController.h"
#import "CDZQRScan.h"

#import "NSManagedObject+CDZAdditions.h"

@interface CDZScansListViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) SSCoreDataSource *dataSource;
@property (nonatomic, readonly) NSFetchRequest *fetchRequest;

@end

@implementation CDZScansListViewController

@synthesize fetchRequest = _fetchRequest;

- (instancetype)initWithDataController:(CDZDataController *)dataController
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.dataController = dataController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.allowsSelection = YES;

    self.dataSource = [[SSCoreDataSource alloc] initWithFetchRequest:self.fetchRequest inContext:self.dataController.coreDataContext sectionNameKeyPath:nil];
    self.dataSource.cellConfigureBlock = ^(SSBaseTableCell *cell,
                                           CDZQRScan *scan,
                                           UITableView *tableView,
                                           NSIndexPath *indexPath) {
        cell.textLabel.text = scan.text;
    };
    self.dataSource.tableView = self.tableView;
    self.dataSource.fallbackTableDataSource = self;
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CDZQRScan *scan = [self.dataSource itemAtIndexPath:indexPath];
        [self.dataController deleteScan:scan];
        
    }
}

- (bool)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Property Overrides

- (NSFetchRequest *)fetchRequest {
    if (!_fetchRequest) {
        _fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[CDZQRScan cdz_entityName]];
        _fetchRequest.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO] ];
    }
    return _fetchRequest;
}

@end
