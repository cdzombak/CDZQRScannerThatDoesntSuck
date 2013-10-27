//
//  NSManagedObject+CDZAdditions.h
//  QRScanner
//
//  Created by Chris Dzombak on 10/27/13.
//  Copyright (c) 2013 Chris Dzombak. All rights reserved.
//

@interface NSManagedObject (CDZAdditions)

+ (NSString *)cdz_entityName;
+ (NSEntityDescription *)cdz_entityDescriptionInContext:(NSManagedObjectContext *)context;
+ (instancetype)cdz_insertInContext:(NSManagedObjectContext *)context;

@end
