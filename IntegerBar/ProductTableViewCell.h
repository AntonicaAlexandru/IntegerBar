//
//  ProductTableViewCell.h
//  IntegerBar
//
//  Created by Alexandru Antonica on 4/18/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoIV;
@property (weak, nonatomic) IBOutlet UILabel *titleProductLB;
@property (weak, nonatomic) IBOutlet UILabel *categoryLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *ratingV;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;


@end
