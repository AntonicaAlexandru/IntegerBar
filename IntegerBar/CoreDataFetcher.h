//
//  CoreDataFetcher.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 10/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Productt.h"
#import "AppDelegate.h"
@interface CoreDataFetcher : NSObject

+(NSArray *)getProductWithPrediate:(NSPredicate *)predicate;
+(NSSet *)getSubCategories:(NSString *)category;
@end
