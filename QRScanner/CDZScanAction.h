//
//  CDZScanAction.h
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

@interface CDZScanAction : NSObject

+ (void)determineActionsForString:(NSString *)string result:(void(^)(NSOrderedSet *actions))resultBlock;

@property (nonatomic, readonly) NSString *localizedActionName;

+ (CDZScanAction *)actionForString:(NSString *)string;

- (void)takeAction;

@end
