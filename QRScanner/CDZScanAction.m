//
//  CDZScanAction.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanAction.h"

#import "CDZScanActionCall.h"
#import "CDZScanActionCopy.h"
#import "CDZScanActionText.h"
#import "CDZScanActionMap.h"
#import "CDZScanActionGoogleMap.h"

@implementation CDZScanAction

+ (void)determineActionsForString:(NSString *)string result:(void(^)(NSOrderedSet *actions))resultBlock {
    if (!resultBlock) resultBlock = ^(NSOrderedSet *a){};

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableOrderedSet *actions = [NSMutableOrderedSet orderedSet];

        for (Class actionClass in [self scanActionClassesOrderedByPreference]) {
            CDZScanAction *action = [actionClass actionForString:string];
            if (action != nil) [actions addObject:action];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            resultBlock(actions);
        });
    });
}

+ (NSArray *)scanActionClassesOrderedByPreference {
    static NSArray *classes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classes = @[
                    [CDZScanActionCopy class],
                    [CDZScanActionCall class],
                    [CDZScanActionText class],
                    [CDZScanActionMap class],
                    [CDZScanActionGoogleMap class],
                    ];
    });
    return classes;
}

#pragma mark - Abstract methods

+ (CDZScanAction *)actionForString:(NSString *)string {
    NSAssert(NO, @"%s is an abstract method and must be overriden\n%@",
             __PRETTY_FUNCTION__,
             [NSThread callStackSymbols]);
    return nil;
}

- (void)takeAction {
    NSAssert(NO, @"%s is an abstract method and must be overriden\n%@",
             __PRETTY_FUNCTION__,
             [NSThread callStackSymbols]);
}

- (NSString *)localizedActionName {
    NSAssert(NO, @"%s is an abstract method and must be overriden\n%@",
             __PRETTY_FUNCTION__,
             [NSThread callStackSymbols]);
    return nil;
}

@end
