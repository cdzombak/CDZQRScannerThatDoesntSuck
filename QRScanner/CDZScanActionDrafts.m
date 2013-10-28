//
//  CDZScanActionDrafts.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "CDZScanActionDrafts.h"
#import "NSString+URLEncoding.h"

@interface CDZScanActionDrafts ()

@property (nonatomic, copy) NSString *text;

@end

@implementation CDZScanActionDrafts

+ (CDZScanAction *)actionForString:(NSString *)string {
    CDZScanActionDrafts *action = [[[self class] alloc] init];
    action.text = string;
    return action;
}

- (void)takeAction {
    NSString *escapedQuery = [self.text cdz_urlEncodedString];
    NSString *urlString = [NSString stringWithFormat:@"drafts:///x-callback-url/create?text=%@", escapedQuery];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

- (NSString *)localizedActionName {
    return NSLocalizedString(@"Drafts…", nil);
}

@end
