//
//  tabCell2.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 05/04/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "tabCell2.h"

@implementation tabCell2

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)plusButtonPressed:(id)sender {
    [self.delegate.tabBarController setSelectedIndex:2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
