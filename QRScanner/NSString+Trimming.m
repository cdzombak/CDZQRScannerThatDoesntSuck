//
//  NSString+Trimming.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "NSString+Trimming.h"

@implementation NSString (Trimming)

- (NSString *)cdz_stringWithTrimmedNewlines {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]
            componentsJoinedByString:@" "];
}

@end
