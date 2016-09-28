//
//  Picture+CoreDataProperties.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 10/05/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Picture.h"

NS_ASSUME_NONNULL_BEGIN

@interface Picture (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *pictureLink;
@property (nullable, nonatomic, retain) Productt *toProduct;

@end

NS_ASSUME_NONNULL_END
