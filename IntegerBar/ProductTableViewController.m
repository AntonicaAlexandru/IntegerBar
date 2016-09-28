//
//  ProductTableViewController.m
//  IntegerBar
//
//  Created by Alexandru Antonica on 4/18/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "ProductTableViewController.h"
#import "ProductTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "Productt.h"
#import "AFImageDownloader.h"
#import "CoreDataFetcher.h"
#import "Picture.h"
#import "ProductDetailsViewController.h"
#import "tab.h"
#import "KLCPopup.h"


@interface ProductTableViewController()<UISearchBarDelegate, UISearchControllerDelegate,UISearchResultsUpdating>{

    NSArray *products;
    UIRefreshControl *refreshControl;
    UISearchController *searchController;
}

@end

@implementation ProductTableViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationController.navigationBar.topItem.title = @"Order";
    self.title = self.navTitle;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [self.activInd startAnimating];
    [self.activInd hidesWhenStopped];
    [self.tableView setHidden:YES];
    
    
    //UISearchController
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    searchController.searchBar.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = NO;
    [searchController.searchBar sizeToFit];
    
    
    /*Get Data*/
    [self getProducts:nil];
    
    
    /*Add refresh control*/
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor grayColor];
    refreshControl.tintColor       = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(getProducts:)
                  forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    

    [self.tableView setContentOffset:CGPointMake(0, searchController.searchBar.frame.size.height) animated:YES];

    

}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

#pragma mark - Table View delegate & source methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductTableViewCell *cell = (ProductTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"prodCell"];
    
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailsCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    
    
    Productt *produs = products[indexPath.row];
    
    cell.logoIV.layer.cornerRadius          = cell.logoIV.frame.size.height /2.0;
    cell.logoIV.layer.masksToBounds         = YES;
    cell.logoIV.layer.borderWidth           = 0;
    cell.ratingV.value                      = [produs.rating floatValue];
    cell.titleProductLB.text                = produs.name;
    cell.categoryLB.text                    = produs.productDescription;
    cell.priceLB.text                       = [NSString stringWithFormat:@"%.2fRON",[produs.price floatValue]];
    [cell.addToCart addTarget:self action:@selector(addToCart:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addToCart setTag:indexPath.row];
    
    /*Retrieve image of product on separate thread*/
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:[produs.productPictures allObjects][0].pictureLink]];
    [[AFImageDownloader defaultInstance] downloadImageForURLRequest:req success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
    
        cell.logoIV.image = responseObject;
        [cell setNeedsDisplay];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
        NSLog(@"Could not download image data");
        
    }];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [products count] > 0 ? [products count]: 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Productt *pr = products[indexPath.row];
    ProductDetailsViewController *prVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProductDetailsViewController"];
    prVC.product = pr;
    [self showViewController:prVC sender:self];
    
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

#pragma mark - Fetching the data

-(void)getProducts:(id)sender{
    
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"subcategory LIKE[cd] %@", self.navTitle];
    products = [CoreDataFetcher getProductWithPrediate:prd];
    [self.tableView setHidden:NO];
    [self.activInd stopAnimating];
    [refreshControl endRefreshing];
    [self.tableView reloadData];
    
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

#pragma mark - Search Controll
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchController.active = NO;
    [self getProducts:nil];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchControllerr{
    NSString *searchString = searchControllerr.searchBar.text;
    NSLog(@"|%@|", searchString);
    NSPredicate *prd;
    
    if ([searchString isEqualToString:@""]) {
        prd = [NSPredicate predicateWithFormat:@"subcategory LIKE[cd] %@", self.navTitle];
    }else{
        prd = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ AND subcategory LIKE[cd] %@", [NSString stringWithFormat:@"%@",searchString], self.navTitle];
    }
    
    products = [CoreDataFetcher getProductWithPrediate:prd];
    [self.tableView reloadData];
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

#pragma mark - My Methods

-(void) addToCart:(UIButton*)sender{
    
    [[tab currentTab]  addProduct:products[sender.tag]];
    
    // Generate content view to present
    UIView* contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.backgroundColor = [UIColor lightGrayColor];
    contentView.layer.cornerRadius = 12.0;
    
    UIImageView *cartAnim = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    cartAnim.translatesAutoresizingMaskIntoConstraints = NO;
    [cartAnim setImage:[UIImage animatedImageNamed:@"cart-" duration:1.0f]];
    cartAnim.contentMode = UIViewContentModeScaleAspectFit;
    
    
    UILabel *savedLabel = [[UILabel alloc] init];
    savedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    savedLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    savedLabel.text = @"Saved to cart!";
    
    
    [contentView addSubview:cartAnim];
    [contentView addSubview:savedLabel];
    
    NSDictionary* views = NSDictionaryOfVariableBindings(contentView, cartAnim,savedLabel);
    
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(30)-[cartAnim]-(10)-[savedLabel]-(30)-|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[cartAnim]-(20)-|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[savedLabel]-(20)-|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    // Show in popup
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                               KLCPopupVerticalLayoutCenter);
    
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeShrinkIn                                         dismissType:KLCPopupDismissTypeGrowOut
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:YES];
    
    [popup showWithLayout:layout duration:0.4];
    
}

@end
