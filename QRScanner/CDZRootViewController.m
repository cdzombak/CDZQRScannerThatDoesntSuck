//
//  CDZRootViewController.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZRootViewController.h"

#import "CDZDataController.h"
#import "CDZScanAction.h"

#import "CDZQRScanningViewController.h"
#import "CDZScansListViewController.h"

#import "NSString+Trimming.h"
#import "UIWindow+Hairline.h"

@interface CDZRootViewController () <UIActionSheetDelegate>

@property (nonatomic, readonly) UIViewController *scannerVC;
@property (nonatomic, readonly) UIViewController *scansListVC;
@property (nonatomic, readonly) UIView *separatorView;

@property (nonatomic, weak) UIActionSheet *displayedActionSheet;
@property (nonatomic, strong) NSOrderedSet *availableActions;

@end

@implementation CDZRootViewController

@synthesize scannerVC = _scannerVC,
            scansListVC = _scansListVC,
            separatorView = _separatorView
            ;

- (instancetype)initWithDataController:(CDZDataController *)dataController {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"QR Scanner", nil);
        self.dataController = dataController;
    }
    return self;
}

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

    [self.view addSubview:self.separatorView];
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

    CGRect separatorFrame = (CGRect) {
        .origin = CGPointMake(0, CGRectGetMaxY(scannerFrame)),
        .size = CGSizeMake(CGRectGetWidth(self.view.bounds), [self.view.window cdz_hairlineWidth])
    };

    self.scannerVC.view.frame = scannerFrame;
    self.scansListVC.view.frame = listFrame;
    self.separatorView.frame = separatorFrame;
}

- (void)didScanQRCodeWithResult:(NSString *)result {
    [self.dataController addScanWithText:result];
    [self didSelectScanWithText:result];
}

#pragma mark - Actions

- (void)didSelectScanWithText:(NSString *)text {
    [CDZScanAction determineActionsForString:text result:^(NSOrderedSet *actions) {
        self.availableActions = actions;
        
        UIActionSheet *displayedActionSheet = self.displayedActionSheet;
        [displayedActionSheet dismissWithClickedButtonIndex:displayedActionSheet.cancelButtonIndex animated:NO];

        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[text cdz_stringWithTrimmedNewlines]
                                                                 delegate:self
                                                        cancelButtonTitle:nil
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:nil];

        for (CDZScanAction *action in self.availableActions) {
            [actionSheet addButtonWithTitle:action.localizedActionName];
        }

        NSInteger cancelButtonIdx = [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
        actionSheet.cancelButtonIndex = cancelButtonIdx;

        [actionSheet showInView:self.view];
        
        self.displayedActionSheet = actionSheet;
    }];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) return;

    [[self.availableActions objectAtIndex:(NSUInteger)buttonIndex] takeAction];
}

#pragma mark - Property Overrides

- (UIViewController *)scannerVC {
    if (!_scannerVC) {
        CDZQRScanningViewController *vc = [[CDZQRScanningViewController alloc] init];
        vc.errorBlock = ^(NSError *error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"QR Scanning Error", nil)
                                        message:[error description]
                                       delegate:nil
                              cancelButtonTitle:@"Okay."
                              otherButtonTitles:nil]
             show];
        };
        vc.resultBlock = ^(NSString *result) {
            [self didScanQRCodeWithResult:result];
        };
        _scannerVC = vc;
    }
    return _scannerVC;
}

- (UIViewController *)scansListVC {
    if (!_scansListVC) {
        CDZScansListViewController *vc = [[CDZScansListViewController alloc] initWithDataController:self.dataController];
        _scansListVC = vc;
    }
    return _scansListVC;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _separatorView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.9];
    }
    return _separatorView;
}

@end
