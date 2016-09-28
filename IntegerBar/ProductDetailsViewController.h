//
//  ProductDetailsViewController.h
//  IntegerBar
//
//  Created by Alexandru Antonica on 5/22/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Productt.h"
#import "KASlideShow.h"
#import "HCSStarRatingView.h"

@interface ProductDetailsViewController : UIViewController<KASlideShowDelegate>

@property(weak, nonatomic) Productt *product;
@property (weak, nonatomic) IBOutlet KASlideShow *sliderShow;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingV;
@property (weak, nonatomic) IBOutlet UITextView *ingredientsTV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTVContrs;

@end
