//
//  tab.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 31/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "tab.h"
#import "CurrentTabProduct.h"
#import "AppDelegate.h"
#import "TabBarController.h"
@implementation tab

@synthesize products;

static tab *myCurrentTab = nil;

+(tab*)currentTab{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myCurrentTab = [[self alloc] init];
        myCurrentTab.productsCount=0;
    });
    return myCurrentTab;
}
-(void)addProduct:(id)product{
    _productsCount++;
    if([product isKindOfClass:[CurrentTabProduct class]]){
        CurrentTabProduct *productReference = (CurrentTabProduct *)product;
        productReference.count = @(productReference.count.integerValue +1);
        [self.products setObject:productReference forKey:productReference.productID];
    }
    else{
        if([self.products objectForKey:((Productt*)product).productID]){
            CurrentTabProduct *productReference = [self.products objectForKey:((Productt *)product).productID];
            productReference.count = @(productReference.count.integerValue +1);
            [self.products setObject:productReference forKey:productReference.productID];
        }
        else{
            CurrentTabProduct *productReference = [[CurrentTabProduct alloc] initWithProduct:(Productt *)product];
            [self.products setObject:productReference forKey:productReference.productID];
        }
    }
    TabBarController *tabBarController = (TabBarController *)[[(AppDelegate*)[[UIApplication sharedApplication] delegate] window] rootViewController];
    tabBarController.tabBar.items[3].badgeValue = [NSString stringWithFormat:@"%li",(long)self.productsCount];
    [_delegate refreshCurrentTabProducts];
}
-(void)removeProduct:(NSNumber *)productID{
    _productsCount--;
    TabBarController *tabBarController = (TabBarController *)[[(AppDelegate*)[[UIApplication sharedApplication] delegate] window] rootViewController];
    if(_productsCount)
        tabBarController.tabBar.items[3].badgeValue = [NSString stringWithFormat:@"%li",(long)self.productsCount];
    else
        tabBarController.tabBar.items[3].badgeValue = nil;
    if([products objectForKey:productID]){
        CurrentTabProduct *ctProd ;
        ctProd = [self.products objectForKey:productID];
        if(ctProd.count.integerValue > 1){
            ctProd.count = @(ctProd.count.integerValue - 1);
            [self.products setObject:ctProd forKey:ctProd.productID];
        }
        else{
            [self.products removeObjectForKey:productID];
        }
    }
    [_delegate refreshCurrentTabProducts];
}
-(void)removeAllProductsWithID:(NSNumber *)productID{
    
    if([products objectForKey:productID]){
        CurrentTabProduct *ctProd ;
        ctProd = [self.products objectForKey:productID];
        _productsCount=_productsCount - ctProd.count.integerValue;
        TabBarController *tabBarController = (TabBarController *)[[(AppDelegate*)[[UIApplication sharedApplication] delegate] window] rootViewController];
        if(_productsCount)
            tabBarController.tabBar.items[3].badgeValue = [NSString stringWithFormat:@"%li",(long)self.productsCount];
        else
            tabBarController.tabBar.items[3].badgeValue = nil;
        [self.products removeObjectForKey:productID];
    }
    [_delegate refreshCurrentTabProducts];
}
-(void)orderProducts{
    [self.products enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        CurrentTabProduct* product = obj;
        if([product.status isEqualToString:@"not-ordered"]){
            //Send request to server(waiter) for an order with the "unordered" products.
            product.status = @"ordered";
        }
        if(stop)
            [_delegate refreshCurrentTabProducts];
    }];
    //[_delegate refreshCurrentTabProducts];
}
-(void)payProducts{
    [self.products enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        CurrentTabProduct* product= obj;
        if([product.status isEqualToString:@"ordered"]){
            //Send request to server(waiter) that a tab request has been made.
            _productsCount=_productsCount - product.count.integerValue;
            TabBarController *tabBarController = (TabBarController *)[[(AppDelegate*)[[UIApplication sharedApplication] delegate] window] rootViewController];
            if(_productsCount)
                tabBarController.tabBar.items[3].badgeValue = [NSString stringWithFormat:@"%li",(long)self.productsCount];
            else
                tabBarController.tabBar.items[3].badgeValue = nil;
            [self.products removeObjectForKey:key];
        }
    }];
    
    [_delegate refreshCurrentTabProducts];
}
-(id)init{
    if ( self = [super init]){
        products = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
