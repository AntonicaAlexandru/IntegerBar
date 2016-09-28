//
//  CoreDataFetcher.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 10/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "CoreDataFetcher.h"
#import "Productt.h"

@implementation CoreDataFetcher

+(NSArray *)getProductWithPrediate:(NSPredicate *)predicate{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Productt"];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    return matches;
}


+(NSSet *)getSubCategories:(NSString*)category{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Productt"];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSMutableSet *setCategories = [[NSMutableSet alloc] init];
    for (Productt *pr in matches) {
        if([pr.category isEqualToString:category])
            [setCategories addObject:pr.subcategory];
    }
    
    return setCategories;
    
}

@end
