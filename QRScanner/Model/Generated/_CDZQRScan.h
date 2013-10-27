// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDZQRScan.h instead.

#import <CoreData/CoreData.h>


extern const struct CDZQRScanAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *text;
} CDZQRScanAttributes;

extern const struct CDZQRScanRelationships {
} CDZQRScanRelationships;

extern const struct CDZQRScanFetchedProperties {
} CDZQRScanFetchedProperties;





@interface CDZQRScanID : NSManagedObjectID {}
@end

@interface _CDZQRScan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CDZQRScanID*)objectID;





@property (nonatomic, strong) NSDate* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* text;



//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;






@end

@interface _CDZQRScan (CoreDataGeneratedAccessors)

@end

@interface _CDZQRScan (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;




@end
