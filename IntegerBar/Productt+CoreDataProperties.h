//
//  Productt+CoreDataProperties.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 10/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Productt.h"

NS_ASSUME_NONNULL_BEGIN

@interface Productt (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *ingredients;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSString *productDescription;
@property (nullable, nonatomic, retain) NSNumber *productID;
@property (nullable, nonatomic, retain) NSNumber *rating;
@property (nullable, nonatomic, retain) NSNumber *stockNumber;
@property (nullable, nonatomic, retain) NSString *subcategory;
@property (nullable, nonatomic, retain) NSSet<Picture *> *productPictures;

@end

@interface Productt (CoreDataGeneratedAccessors)

- (void)addProductPicturesObject:(Picture *)value;
- (void)removeProductPicturesObject:(Picture *)value;
- (void)addProductPictures:(NSSet<Picture *> *)values;
- (void)removeProductPictures:(NSSet<Picture *> *)values;

@end

NS_ASSUME_NONNULL_END
