//
//  FeedCell.h
//  IntegerBar
//
//  Created by Mihai Honceriu on 22/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak,nonatomic) IBOutlet UILabel *dateLabel;

@end
