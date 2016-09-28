//
//  product.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 26/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Productt.h"
@interface CurrentTabProduct : NSObject
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
@property (nullable, nonatomic, strong) NSNumber *count;
@property (nullable, nonatomic, strong) NSString *status;
-(nonnull instancetype)initWithProduct:(nonnull Productt*)myProd;
@end
