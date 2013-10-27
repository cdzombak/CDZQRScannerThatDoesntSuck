//
//  CDZScanActionMap.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

@import MapKit;

#import "CDZScanActionMap.h"
#import "NSString+URLEncoding.h"

@interface CDZScanActionMap ()

@property (nonatomic, strong) NSDictionary *matchComponents;

@end

@implementation CDZScanActionMap

+ (CDZScanAction *)actionForString:(NSString *)string {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:nil];
    NSTextCheckingResult *result = [detector firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];

    if (!result) return nil;

    CDZScanActionMap *action = [[[self class] alloc] init];
    action.matchComponents = result.addressComponents;
    return action;
}

+ (NSArray *)keysForQuery {
    static NSArray *keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keys = @[
                 NSTextCheckingNameKey,
                 NSTextCheckingStreetKey,
                 NSTextCheckingCityKey,
                 NSTextCheckingStateKey,
                 NSTextCheckingZIPKey,
                 NSTextCheckingCountryKey,
                 ];
    });
    return keys;
}

- (NSString *)queryFromMatchComponents:(NSDictionary *)components {
    NSMutableString *query = [NSMutableString string];

    for (id key in [[self class] keysForQuery]) {
        NSString *component = components[key];
        if (component && ![component isEqualToString:@""]) {
            [query appendFormat:@"%@, ", component];
        }
    }

    return [query cdz_urlEncodedString];
}

- (void)takeAction {
    NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", [self queryFromMatchComponents:self.matchComponents]];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Map", nil);
}

@end
