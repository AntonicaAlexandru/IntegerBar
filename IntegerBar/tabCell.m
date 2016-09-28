//
//  tabCell.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 31/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "tabCell.h"
#import "OrderedDictionary.h"
#import "CurrentTabProduct.h"
#import "tab.h"

@implementation tabCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)prepareForReuse{
    [super prepareForReuse];
    self.status = @"not-ordered";
}
- (IBAction)minusButtonPressed:(id)sender {
    NSInteger counter = [self.countField.text integerValue];
    if(counter == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:@"Do you want to remove this from your tab?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [[tab currentTab] removeProduct:self.productID];
                                                         }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                             }];
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self.delegate presentViewController:alert animated:YES completion:nil];
        //show pop-up asking the user if he wants to remove the product
    }
    else
        [[tab currentTab] removeProduct:self.productID];
    
}
- (IBAction)plusButtonPressed:(id)sender {
    [[tab currentTab] addProduct:[[tab currentTab].products objectForKey:self.productID]];
}
@end
