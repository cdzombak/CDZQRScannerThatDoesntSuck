//
//  CDZScanActionCopy.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionCopy.h"

@interface CDZScanActionCopy ()

@property (nonatomic, copy) NSString *match;

@end

@implementation CDZScanActionCopy

+ (CDZScanAction *)actionForString:(NSString *)string {
    CDZScanActionCopy *action = [[[self class] alloc] init];
    action.match = string;
    return action;
}

- (void)takeAction {
    [[UIPasteboard generalPasteboard] setString:self.match];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Copy", nil);
}

@end
