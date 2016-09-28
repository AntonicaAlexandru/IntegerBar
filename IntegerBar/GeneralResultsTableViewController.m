//
//  GeneralResultsTableViewController.m
//  IntegerBar
//
//  Created by Alexandru Antonica on 5/25/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "GeneralResultsTableViewController.h"
#import "Productt.h"
#import "ProductTableViewCell.h"
#import "CoreDataFetcher.h"
#import "AFHTTPSessionManager.h"
#import "AFImageDownloader.h"
#import "Picture.h"
#import "ProductDetailsViewController.h"


@interface GeneralResultsTableViewController ()<UISearchBarDelegate, UISearchControllerDelegate,UISearchResultsUpdating>{

    NSArray *products;
    NSInteger total;
}

@end

@implementation GeneralResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    products = [CoreDataFetcher getProductWithPrediate:nil];
    total = [products count];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (products == nil) ? 0 : [products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductTableViewCell *cell = (ProductTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"prodCell"];
    
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailsCell" owner:self options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    
    
    Productt *produs = products[indexPath.row];
    
    cell.logoIV.layer.cornerRadius          = cell.logoIV.frame.size.height /2.0;
    cell.logoIV.layer.masksToBounds         = YES;
    cell.logoIV.layer.borderWidth           = 0;
    cell.ratingV.value                      = [produs.rating intValue];
    cell.titleProductLB.text                = produs.name;
    cell.categoryLB.text                    = produs.productDescription;
    cell.priceLB.text                       = [NSString stringWithFormat:@"%.2fRON",[produs.price floatValue]];
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Productt *pr = products[indexPath.row];
    ProductDetailsViewController *prVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProductDetailsViewController class])];
    prVC.product = pr;
    [self showViewController:prVC sender:self];
    
}

#pragma mark - Search Controll

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    if ([products count] != total) {
        products = [CoreDataFetcher getProductWithPrediate:nil];
        [self.tableView reloadData];
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchControllerr{
    NSString *searchString = searchControllerr.searchBar.text;

    NSPredicate *prd;
    
    if (![searchString isEqualToString:@""]){
        NSString *rez = [NSString stringWithFormat:@"%@",searchString];
        prd = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ OR ingredientds CONTAINS [cd] %@", rez, rez];
    }
    
    products = [CoreDataFetcher getProductWithPrediate:prd];
    [self.tableView reloadData];
}
@end
