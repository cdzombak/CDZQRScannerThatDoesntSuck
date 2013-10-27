//
//  CDZRootViewController.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZRootViewController.h"

#import "CDZQRScanningViewController.h"
#import "CDZScansListViewController.h"

@interface CDZRootViewController ()

@property (nonatomic, readonly) UIViewController *scannerVC;
@property (nonatomic, readonly) UIViewController *scansListVC;

@end

@implementation CDZRootViewController

@synthesize scannerVC = _scannerVC,
            scansListVC = _scansListVC
            ;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViews];
}

- (void)addChildViews
{
    [self addChildViewController:self.scannerVC];
    [self.view addSubview:self.scannerVC.view];
    [self.scannerVC didMoveToParentViewController:self];

    [self addChildViewController:self.scansListVC];
    [self.view addSubview:self.scansListVC.view];
    [self.scansListVC didMoveToParentViewController:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self layoutMyView];
}

- (void)layoutMyView
{
    CGRect scannerFrame = (CGRect) {
        .origin = CGPointZero,
        .size = CGSizeMake(CGRectGetWidth(self.view.bounds), 0.55f*CGRectGetHeight(self.view.bounds))
    };

    CGRect listFrame = (CGRect) {
        .origin = CGPointMake(0, CGRectGetMaxY(scannerFrame)),
        .size = CGSizeMake(CGRectGetWidth(self.view.bounds), 0.45f*CGRectGetHeight(self.view.bounds))
    };

    self.scannerVC.view.frame = scannerFrame;
    self.scansListVC.view.frame = listFrame;
}

#pragma mark - Property Overrides

- (UIViewController *)scannerVC {
    if (!_scannerVC) {
        CDZQRScanningViewController *vc = [CDZQRScanningViewController new];
        vc.errorBlock = ^(NSError *error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"QR Scanning Error", nil)
                                        message:[error description]
                                       delegate:nil
                              cancelButtonTitle:@"Okay."
                              otherButtonTitles:nil]
             show];
        };
        vc.resultBlock = ^(NSString *result) {
            NSLog(@"scanned %@", result);
        };
        _scannerVC = vc;
    }
    return _scannerVC;
}

- (UIViewController *)scansListVC {
    if (!_scansListVC) {
        CDZScansListViewController *vc = [[CDZScansListViewController alloc] init];
        _scansListVC = vc;
    }
    return _scansListVC;
}

@end
