//
//  CDZDataController.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZDataController.h"

#import "CDZQRScan.h"

#import "NSManagedObject+CDZAdditions.h"

@interface CDZDataController ()

@property (nonatomic, readwrite, strong) NSManagedObjectContext *coreDataContext;

@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;

@property (nonatomic, readonly) NSURL *storeURL;

@end

@implementation CDZDataController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.model = [NSManagedObjectModel mergedModelFromBundles:nil];
        self.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        NSError *error;
        if (![self.coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                            configuration:nil
                                                      URL:self.storeURL
                                                  options:nil
                                                    error:&error]) {
            NSLog(@"Core Data initialization error: %@", error);
            [[NSFileManager defaultManager] removeItemAtURL:self.storeURL error:nil];
            return nil;
        }

        self.coreDataContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [self.coreDataContext setPersistentStoreCoordinator:self.coordinator];
    }
    return self;
}

- (NSURL *)storeURL {
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [applicationDocumentsDirectory URLByAppendingPathComponent:@"QRScanner.sqlite"];
}

- (NSManagedObjectContext *)temporaryBackgroundContext {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setParentContext:self.coreDataContext];
    return context;
}

- (void)persistChangesInContext:(NSManagedObjectContext *)context completionHandler:(void (^)(NSError *error))block {
    [context performBlock:^{
        NSError *error;
        bool didSave = [context save:&error];
        NSManagedObjectContext *parentContext = [context parentContext];
        if (didSave && parentContext) {
            [self persistChangesInContext:parentContext completionHandler:block];
        } else if (block) {
            block(didSave ? nil : error);
        }
    }];
}

#pragma mark - Public API

- (void)addScanWithText:(NSString *)scanText {
    NSManagedObjectContext *context = [self temporaryBackgroundContext];
    CDZQRScan *scan = [CDZQRScan cdz_insertInContext:context];
    scan.text = scanText;
    scan.date = [NSDate date];
    [self persistChangesInContext:context completionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Core Data error while saving scan: %@", error);
        }
    }];
}

@end
