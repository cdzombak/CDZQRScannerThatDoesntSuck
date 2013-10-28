//
//  CDZScanActionFantasticalView.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionFantasticalView.h"

@interface CDZScanActionFantasticalView ()

@property (nonatomic, strong) NSTextCheckingResult *result;

@end

@implementation CDZScanActionFantasticalView

+ (CDZScanAction *)actionForString:(NSString *)string {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fantastical://"]]) return nil;

    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;

    CDZScanActionFantasticalView *action = [[[self class] alloc] init];
    action.result = result;
    return action;
}

- (void)takeAction {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *urlString = [NSString stringWithFormat:@"fantastical://show?date=%@", [formatter stringFromDate:self.result.date]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"View in Fantastical", nil);
}

@end
