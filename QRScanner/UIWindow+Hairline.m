//
//  UIWindow+Hairline.m
//  QRScanner
//
//  Created by Chris Dzombak on 12/4/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "UIWindow+Hairline.h"

@implementation UIWindow (Hairline)

- (CGFloat)cdz_hairlineWidth {
    return 1.0f / self.screen.scale;
}

@end
