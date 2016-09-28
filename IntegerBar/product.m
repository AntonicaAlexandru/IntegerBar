//
//  product.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 26/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "product.h"

@implementation product
-(id)initProductWithName:(NSString *)name id:(NSInteger)productID ingredients:(NSDictionary *)ingredients price:(NSNumber *)price description:(NSString *)description stockNumber:(NSInteger)stockNumber pictureLinks:(NSArray *)pictureLinks rating:(NSNumber *)rating{
    
    self.name = name;
    self.productID = productID;
    self.ingredients = (NSMutableDictionary *)[ingredients mutableCopy];
    self.price = price;
    self.productDescription = description;
    self.stockNumber = stockNumber;
    self.pictureLinks = [[NSArray alloc]initWithArray:pictureLinks];
    self.rating = rating;
    
    return self;
}
-(id)initProductWithDictionary:(NSDictionary *)jsonDict{
   
    self.name = [jsonDict objectForKey:@"name"];
    self.productID = (NSInteger)[jsonDict objectForKey:@"productID"];
    self.ingredients = [jsonDict objectForKey:@"ingredients"];
    self.price = (NSNumber*)[jsonDict objectForKey:@"price"];
    self.productDescription = [jsonDict objectForKey:@"description"];
    self.stockNumber = (NSInteger)[jsonDict objectForKey:@"stockNumber"];
    self.pictureLinks = [jsonDict objectForKey:@"pictureLinks"];
    self.category = [jsonDict objectForKey:@"category"];
    self.rating = [jsonDict objectForKey:@"rating"];
    
    return self;
}

@end
