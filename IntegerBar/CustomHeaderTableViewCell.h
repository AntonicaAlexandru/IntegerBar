//
//  CustomHeaderTableViewCell.h
//  IntegerBar
//
//  Created by Alexandru Antonica on 3/24/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoryIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *fakeIV;

@end
