//
//  CDZScanActionCall.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionCall.h"

@interface CDZScanActionCall ()

@property (nonatomic, copy) NSString *match;

@end

@implementation CDZScanActionCall

+ (CDZScanAction *)actionForString:(NSString *)string {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;

    CDZScanActionCall *action = [[[self class] alloc] init];
    action.match = result.phoneNumber;
    return action;
}

- (void)takeAction {
    NSString *phoneNumber = [@"tel://" stringByAppendingString:self.match];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Call", nil);
}

@end
