//
//  CDZScanActionChrome.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionChrome.h"

@interface CDZScanActionChrome ()

// http:// has not been replaced by chrome's scheme in this URL
@property (nonatomic, strong) NSURL *url;

@end

@implementation CDZScanActionChrome

+ (CDZScanAction *)actionForString:(NSString *)string {
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]]) return nil;

    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;
    if (![self isURLHttp:result.URL]) return nil;

    CDZScanActionChrome *action = [[[self class] alloc] init];
    action.url = result.URL;
    return action;
}

+ (BOOL)isURLHttp:(NSURL *)url {
    NSString *schemeLowerCase = [url.scheme lowercaseString];
    return [[schemeLowerCase substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"http"];
}

- (void)takeAction {
    NSString *originalScheme = self.url.scheme;

    // Replace the URL Scheme with the Chrome equivalent.
    NSString *chromeScheme = nil;
    if ([originalScheme isEqualToString:@"http"]) {
        chromeScheme = @"googlechrome";
    } else if ([originalScheme isEqualToString:@"https"]) {
        chromeScheme = @"googlechromes";
    }

    // Proceed only if a valid Google Chrome URI Scheme is available.
    if (!chromeScheme) return;

    NSString *absoluteString = [self.url absoluteString];
    NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
    NSString *urlNoScheme = [absoluteString substringFromIndex:rangeForScheme.location];
    NSString *chromeURLString = [chromeScheme stringByAppendingString:urlNoScheme];
    NSURL *chromeURL = [NSURL URLWithString:chromeURLString];

    // Open the URL with Chrome.
    [[UIApplication sharedApplication] openURL:chromeURL];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Open in Chrome", nil);
}

@end
