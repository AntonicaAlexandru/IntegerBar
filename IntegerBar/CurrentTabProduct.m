//
//  currentTabProduct.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 14/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "CurrentTabProduct.h"

@implementation CurrentTabProduct

@synthesize count;
-(nonnull instancetype)initWithProduct:(nonnull Productt *)myProd{
    self.category = [NSString stringWithString:myProd.category];
    self.name = [NSString stringWithString:myProd.name];
    self.price = myProd.price;
    self.productDescription = [NSString stringWithString:myProd.productDescription];
    self.productID = myProd.productID;
    self.rating = myProd.rating;
    self.stockNumber = myProd.stockNumber;
    self.subcategory = [NSString stringWithString:myProd.subcategory];
    self.productPictures = [NSSet setWithSet:myProd.productPictures];
    self.ingredients = [NSString stringWithString:myProd.ingredients];
    self.count = [NSNumber numberWithInt:1];
    self.status = @"not-ordered";
    return self;
}

@end
