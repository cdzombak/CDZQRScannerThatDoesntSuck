//
//  NSManagedObject+CDZAdditions.m
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

#import "NSManagedObject+CDZAdditions.h"

@implementation NSManagedObject (CDZAdditions)

+ (NSString *)cdz_entityName {
    NSString *entityName = NSStringFromClass(self);
    if ([entityName hasPrefix:@"CDZ"]) {
        entityName = [entityName substringFromIndex:3];
    }
    return entityName;
}

+ (NSEntityDescription *)cdz_entityDescriptionInContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription entityForName:[self cdz_entityName] inManagedObjectContext:context];
}

+ (instancetype)cdz_insertInContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [self cdz_entityDescriptionInContext:context];
    return [[self alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

@end
