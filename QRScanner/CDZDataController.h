//
//  CDZDataController.h
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

@class CDZQRScan;

@interface CDZDataController : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *coreDataContext;

/// Designated initializer
- (instancetype)init;

- (void)addScanWithText:(NSString *)scanText;
- (void)deleteScan:(CDZQRScan *)scan;

@end
