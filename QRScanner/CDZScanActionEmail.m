//
//  CDZScanActionEmail.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/30/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionEmail.h"
#import "NSString+URLEncoding.h"

// via http://stackoverflow.com/a/3638271/734716
static NSString * const CDZEmailRegexString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";

@interface CDZScanActionEmail ()

@property (nonatomic, copy) NSString *email;

@end

@implementation CDZScanActionEmail

+ (CDZScanAction *)actionForString:(NSString *)string {
    NSRegularExpression *emailRegex = [NSRegularExpression regularExpressionWithPattern:CDZEmailRegexString options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *result = [emailRegex firstMatchInString:string options:(NSMatchingOptions)0 range:NSMakeRange(0, string.length)];

    if (!result || result.range.location == NSNotFound) return nil;

    CDZScanActionEmail *action = [[[self class] alloc] init];
    action.email = [string substringWithRange:result.range];
    return action;
}

- (void)takeAction {
    NSString *urlString = [NSString stringWithFormat:@"mailto:%@", [self.email cdz_urlEncodedString]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Email", nil);
}

@end
