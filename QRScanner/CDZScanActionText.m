//
//  CDZScanActionText.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionText.h"

@interface CDZScanActionText ()

@property (nonatomic, copy) NSString *match;

@end

@implementation CDZScanActionText

+ (CDZScanAction *)actionForString:(NSString *)string {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;

    CDZScanActionText *action = [[[self class] alloc] init];
    action.match = result.phoneNumber;
    return action;
}

- (void)takeAction {
    NSString *phoneNumber = [@"sms://" stringByAppendingString:self.match];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Text", nil);
}

@end
