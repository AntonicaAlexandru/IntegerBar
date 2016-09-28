//
//  product.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 26/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface product : NSObject
@property (nonatomic, weak) NSString *name;
@property (nonatomic) NSInteger productID;
@property (nonatomic, weak) NSMutableDictionary *ingredients;
@property (nonatomic, weak) NSNumber *price;
@property (nonatomic, weak) NSString *category;
@property (nonatomic, strong) NSArray *pictureLinks;
@property (nonatomic, weak) NSString *productDescription;
@property (nonatomic) NSInteger stockNumber;
@property (nonatomic) NSNumber *rating;

-(id)initProductWithDictionary:(NSDictionary *)jsonDict;
-(id)initProductWithName:(NSString *)name id:(NSInteger)productID ingredients:(NSDictionary *)ingredients price:(NSNumber*)price description:(NSString*)description stockNumber:(NSInteger)stockNumber pictureLinks:(NSArray *)pictureLinks rating:(NSNumber*)rating;
@end
