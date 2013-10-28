//
//  CDZScanActionFantasticalParse.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionFantasticalParse.h"

#import "NSString+URLEncoding.h"

@interface CDZScanActionFantasticalParse ()

@property (nonatomic, strong) NSString *text;

@end

@implementation CDZScanActionFantasticalParse

+ (CDZScanAction *)actionForString:(NSString *)string {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fantastical://"]]) return nil;

    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;
    if (!result.duration) return nil;

    CDZScanActionFantasticalParse *action = [[[self class] alloc] init];
    action.text = string;
    return action;
}

- (void)takeAction {
    NSString *encodedString = [self.text cdz_urlEncodedString];
    NSString *urlString = [NSString stringWithFormat:@"fantastical://parse?sentence=%@", encodedString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Parse in Fantastical", nil);
}

@end
