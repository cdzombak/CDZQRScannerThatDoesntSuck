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
    NSString *match;

    NSString *firstFour;
    if (string.length > 4) firstFour = [[string substringWithRange:NSMakeRange(0, 4)] lowercaseString];
    if ([firstFour isEqualToString:@"tel:"] || [firstFour isEqualToString:@"sms:"]) {
        match = [string substringFromIndex:4];
    } else if (string.length > 6 && [[[string substringWithRange:NSMakeRange(0, 6)] lowercaseString] isEqualToString:@"smsto:"]) {
        match = [string substringFromIndex:6];
    } else {
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:nil];
        NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

        if (!result) return nil;

        match = result.phoneNumber;
    }

    CDZScanActionCall *action = [[[self class] alloc] init];
    action.match = match;
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
