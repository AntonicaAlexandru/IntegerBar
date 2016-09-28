//
//  Picture+Create.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 21/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "Picture+Create.h"
#import "AppDelegate.h"

@implementation Picture (Create)
+(Picture *)pictureWithLink:(NSString *)link{
    Picture *picture = nil;
    if(link){
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Picture"];
        request.predicate = [NSPredicate predicateWithFormat:@"pictureLink = %@", [NSString stringWithFormat:@"%@",link]];
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if(!matches || matches.count > 1){
            //error
        }else{
            if(matches.count == 0){
                picture = [NSEntityDescription insertNewObjectForEntityForName:@"Picture" inManagedObjectContext:context];
            }else{
                picture = matches.lastObject;
            }
            picture.pictureLink = link;
        }
    }
    return picture;
}
@end
