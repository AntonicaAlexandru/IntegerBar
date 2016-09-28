//
//  Productt+Create.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 21/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "Productt.h"

@interface Productt (Create)
+(Productt *)productWithDictionary:(NSDictionary *)dictionary;
@end
