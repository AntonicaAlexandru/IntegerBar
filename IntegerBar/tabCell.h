//
//  tabCell.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 31/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tabCell : UITableViewCell 
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *countField;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) NSNumber *productID;
@property (weak, nonatomic) NSString *status;
@property (weak, nonatomic) UIViewController* delegate;
@end
