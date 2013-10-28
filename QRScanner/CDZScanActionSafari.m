//
//  CDZScanActionSafari.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionSafari.h"

@interface CDZScanActionSafari ()

@property (nonatomic, strong) NSURL *url;

@end

@implementation CDZScanActionSafari

+ (CDZScanAction *)actionForString:(NSString *)string {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;
    if (![self isURLHttp:result.URL]) return nil;

    CDZScanActionSafari *action = [[[self class] alloc] init];
    action.url = result.URL;
    return action;
}

+ (BOOL)isURLHttp:(NSURL *)url {
    NSString *schemeLowerCase = [url.scheme lowercaseString];
    if (schemeLowerCase.length < 4) return NO;
    return [[schemeLowerCase substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"http"];
}

- (void)takeAction {
    [[UIApplication sharedApplication] openURL:self.url];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Open in Safari", nil);
}

@end
