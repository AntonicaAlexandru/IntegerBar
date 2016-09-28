//
//  CurrentTabVC.m
//  IntegerBar
//
//  Created by Mihai Honceriu on 29/03/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "CurrentTabVC.h"
#import "tab.h"
#import "tabCell.h"
#import "tabCell2.h"
#import "TabCell3.h"
#import "CurrentTabProduct.h"
#import "UIImageView+AFNetworking.h"
#import "OrderedDictionary.h"
#import "Picture.h"
#import "currentTabBottomSection.h"
#import "currentTabTopSection.h"
#import "CoreDataFetcher.h"
@interface CurrentTabVC ()
@property (nonatomic) NSInteger badgeCount;
@property (weak, nonatomic) IBOutlet UIView *noProductsView;
@property (nonatomic) double subtotalPrice;
@end

@implementation CurrentTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Tab";
    self.currentTabTable.dataSource = self;
    self.currentTabTable.delegate = self;
    self.currentTabTable.allowsMultipleSelectionDuringEditing = NO;
    [tab currentTab].delegate = self;
    _badgeCount = 0;
    _tableNumber = 0;
    _subtotalPrice = 0;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCurrentTabProducts) name:@"refreshCurrentTab" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([[[tab currentTab] products] count] == 0){
        self.noProductsView.hidden = NO;
        self.noProductsView.userInteractionEnabled = YES;
        return 0;
    }
    //Will return depending on the number of people at the same table that have placed their order;
    self.noProductsView.hidden = YES;
    self.noProductsView.userInteractionEnabled = NO;
    return 1;
}
- (IBAction)addProductToEmptyTabPressed:(id)sender {
    self.tabBarController.selectedIndex = 2;
}
-(void)refreshCurrentTabProducts{
    [UIView transitionWithView: self.currentTabTable
                      duration: 0.40f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         _subtotalPrice = 0;
         [self.currentTabTable reloadData];
     }
                    completion: nil];
    //[self.currentTabTable reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([[[tab currentTab] products] count] == 0)
        return 0;
    if( section == 0)
        return [[[tab currentTab] products] count] + 2;
    return [[[tab currentTab] products] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"tabCellID";
    tabCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    tabCell2 *addProductCell = [tableView dequeueReusableCellWithIdentifier:@"addProductCellID"];
    TabCell3 *subtotalCell = [tableView dequeueReusableCellWithIdentifier:@"subtotalCellID"];
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            addProductCell.delegate = self;
            return addProductCell;
        }
        else{
            if(indexPath.row == [[[tab currentTab] products] count]+1)
            {
                subtotalCell.subtotal.text = [NSString stringWithFormat:@"%.02f RON", self.subtotalPrice];
                return subtotalCell;
            }
            OrderedDictionary *products = [[OrderedDictionary alloc] initWithDictionary:[[tab currentTab] products]];
            CurrentTabProduct *myProduct;
            NSArray *keys = [products allKeys];
            myProduct = [products objectForKey:keys[indexPath.row -1]];
            myCell.countField.text = [NSString stringWithFormat:@"%i", [myProduct.count integerValue]];
            myCell.productPrice.text = [NSString stringWithFormat:@"%@ RON", @(myProduct.price.floatValue * myProduct.count.floatValue)];
            self.subtotalPrice = self.subtotalPrice + myProduct.price.floatValue * myProduct.count.floatValue;
            myCell.productName.text = myProduct.name;
            myCell.productID = myProduct.productID;
            myCell.status = myProduct.status;
            myCell.delegate = self;
            [myCell.productImage setImageWithURL:[NSURL URLWithString:[[myProduct.productPictures allObjects] objectAtIndex:0].pictureLink]];
            if([myProduct.status isEqualToString:@"ordered"]){
                myCell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.2 alpha:0.2];
                [self tableView:self.currentTabTable canEditRowAtIndexPath:indexPath];
                myCell.plusButton.enabled = false;
                myCell.minusButton.enabled = false;
                myCell.countField.enabled = false;
            }
            else{
                myCell.backgroundColor = [UIColor whiteColor];
                myCell.plusButton.enabled = true;
                myCell.minusButton.enabled = true;
                myCell.countField.enabled = true;
            }
        }
    }
    else{
        //take orders from other people at the same table;
    }
    return myCell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    tabCell *myCell = [tableView cellForRowAtIndexPath:indexPath];
    if(![myCell respondsToSelector:@selector(setStatus:)])
        return NO;
    if([myCell.status isEqualToString:@"ordered"])
        return NO;
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        tabCell *myCell = [tableView cellForRowAtIndexPath:indexPath];
        [[tab currentTab] removeAllProductsWithID:myCell.productID];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 )
        if(indexPath.row == 0)
            return 30;
    if(indexPath.row == [[[tab currentTab] products] count]+1)
        return 30;
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section>0)
        return CGFLOAT_MIN;
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section > 0){
        return nil;
    }
    currentTabBottomSection *footerView =[[NSBundle mainBundle] loadNibNamed:@"currentTabBottomSection" owner:self options:nil].firstObject;
    footerView.delegate = self;
    return footerView;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    currentTabTopSection *headerView = [[NSBundle mainBundle] loadNibNamed:@"currentTabTopSection" owner:self options:nil].firstObject;
    return headerView;
}

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
        self.tableNumber = result.integerValue;
        if(result.integerValue != 0)
        [[tab currentTab] orderProducts];
        //TODO: Remember the Table Number Globally
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
