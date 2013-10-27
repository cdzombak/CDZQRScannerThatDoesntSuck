// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDZQRScan.m instead.

#import "_CDZQRScan.h"

const struct CDZQRScanAttributes CDZQRScanAttributes = {
	.date = @"date",
	.text = @"text",
};

const struct CDZQRScanRelationships CDZQRScanRelationships = {
};

const struct CDZQRScanFetchedProperties CDZQRScanFetchedProperties = {
};

@implementation CDZQRScanID
@end

@implementation _CDZQRScan

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"QRScan" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"QRScan";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"QRScan" inManagedObjectContext:moc_];
}

- (CDZQRScanID*)objectID {
	return (CDZQRScanID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic date;






@dynamic text;











@end
