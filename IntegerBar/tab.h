//
//  tab.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 31/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentTabVC.h"
#import "Productt.h"
@interface tab : NSObject

@property (nonatomic,retain) NSMutableDictionary *products;
@property (weak, nonatomic) id<CurrentTabVCDelegate> delegate;
@property (nonatomic) NSInteger productsCount;

+(tab *)currentTab;
-(void)addProduct:(id)product;
-(void)removeProduct:(NSNumber *)productID;
-(void)removeAllProductsWithID:(NSNumber *)productID;
-(void)orderProducts;
-(void)payProducts;
@end
