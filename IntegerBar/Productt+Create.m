//
//  Productt+Create.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 21/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "Productt+Create.h"
#import "AppDelegate.h"
#import "Picture+Create.h"

@implementation Productt (Create)
+(Productt *)productWithDictionary:(NSDictionary *)dictionary{
    Productt *product = nil;
    if(dictionary){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Productt"];
        request.predicate = [NSPredicate predicateWithFormat:@"productID = %@", [NSString stringWithFormat:@"%@",dictionary[@"productID"]]];
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if(!matches || matches.count > 1){
            //error
        }else{
            if(matches.count == 0){
                product = [NSEntityDescription insertNewObjectForEntityForName:@"Productt" inManagedObjectContext:context];
            }else{
                product = matches.lastObject;
            }
            product.productDescription = dictionary[@"description"];
            product.price = dictionary[@"price"];
            product.productID = dictionary[@"productID"];
            product.rating = dictionary[@"rating"];
            product.subcategory = dictionary[@"subcategory"];
            product.name = dictionary[@"name"];
            product.category = dictionary[@"category"];
            product.stockNumber = dictionary[@"stockNumber"];
            product.ingredients = dictionary[@"ingredients"];
            NSMutableSet *pictureSet = [product.productPictures mutableCopy];
            NSArray *picturesArray = dictionary[@"pictureLinks"];
            for(NSString *pictureLink in picturesArray){
                [pictureSet addObject:[Picture pictureWithLink:pictureLink]];
            }
            product.productPictures = pictureSet ;
        }
        [appDelegate saveContext];
    }
    return product;
}
@end
