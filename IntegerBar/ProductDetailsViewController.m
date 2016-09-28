//
//  ProductDetailsViewController.m
//  IntegerBar
//
//  Created by Alexandru Antonica on 5/22/16.
//  Copyright © 2016 Mihai Honceriu. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/UIImage+AFNetworking.h>
#import "Picture.h"
#import "KLCPopup.h"
#import "tab.h"


@interface ProductDetailsViewController (){
    UIPageControl *pageControl;
    UIActivityIndicatorView *activityIndicator;
    NSInteger numberProd;
}

-(void)downloadImages;
-(void)didChangeValueRating;
@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //Initialise number of prods
    numberProd = 1;
    
    //Setare Titlu
    [self setTitle:self.product.name];
    
    // KASlideshow
    self.sliderShow.delegate = self;
    [self.sliderShow setDelay:1];                                               // Delay between transitions
    [self.sliderShow setTransitionDuration:.5];                                 // Transition duration
    [self.sliderShow setTransitionType:KASlideShowTransitionSlide];              // Choose a transition type (fade or slide)
    [self.sliderShow setImagesContentMode:UIViewContentModeScaleAspectFill];    // Choose a content mode for images to display
    [self.sliderShow addGesture:KASlideShowGestureSwipe];                       // Gesture to go previous/next directly on the image
    [self.sliderShow addImagesFromResources:@[@"placeholder"]];
    //[self performSelectorInBackground:@selector(downloadImages) withObject:nil];
    
    
    //Page Control
    pageControl                                 = [[UIPageControl alloc] init];
    pageControl.frame                           = CGRectMake(20, 100, 30, 10);
    pageControl.currentPage                     = 0;
    pageControl.tintColor                       = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor   = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor          = [UIColor grayColor];
    pageControl.numberOfPages                   = [[self.product.productPictures allObjects] count];
    [self.sliderShow addSubview:pageControl];
    
    
    //ActivityIndicator
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator hidesWhenStopped];
    [self.sliderShow addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    [self addConstraints];
    [self downloadImages];

    [self.sliderShow bringSubviewToFront:activityIndicator];
    [self.sliderShow bringSubviewToFront:pageControl];

    
    [self.ratingV addTarget:self action:@selector(didChangeValueRating) forControlEvents:UIControlEventValueChanged];
    [self.priceLabel setText:[NSString stringWithFormat:@"%d RON", (int)[self.product.price integerValue]]];
    [self.ingredientsTV setText:self.product.ingredients];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


#pragma mark - KASlideShow delegate
- (void) kaSlideShowWillShowNext:(KASlideShow *)slideShow{
    if(slideShow.currentIndex == pageControl.numberOfPages-1)
        [pageControl setCurrentPage:0];
    else
        [pageControl setCurrentPage:slideShow.currentIndex+1];
}

- (void) kaSlideShowWillShowPrevious:(KASlideShow *)slideShow{
    
    if(slideShow.currentIndex == 0)
        [pageControl setCurrentPage:pageControl.numberOfPages-1];
    else
        [pageControl setCurrentPage:slideShow.currentIndex-1];
}


#pragma mark - MyMethods


- (void)addConstraints{
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    pageControl.translatesAutoresizingMaskIntoConstraints       = NO;
    
    NSLayoutConstraint *xPozConstrActiv = [NSLayoutConstraint
                                           constraintWithItem:activityIndicator
                                           attribute:NSLayoutAttributeCenterX
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.sliderShow
                                           attribute:NSLayoutAttributeCenterX
                                           multiplier:1.0f
                                           constant:0.f];
    
    NSLayoutConstraint *yPozConstrActiv = [NSLayoutConstraint
                                           constraintWithItem:activityIndicator
                                           attribute:NSLayoutAttributeCenterY
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.sliderShow
                                           attribute:NSLayoutAttributeCenterY
                                           multiplier:1.0f
                                           constant:0.f];
    
    NSLayoutConstraint *xPozConstPage = [NSLayoutConstraint
                                         constraintWithItem:pageControl
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.sliderShow
                                         attribute:NSLayoutAttributeCenterX
                                         multiplier:1.0f
                                         constant:0.f];
    
    NSLayoutConstraint *yPozConstrPage = [NSLayoutConstraint
                                          constraintWithItem:pageControl
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.sliderShow
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:10.0f];
    
    
    [self.sliderShow addConstraint:xPozConstrActiv];
    [self.sliderShow addConstraint:yPozConstrActiv];
    [self.sliderShow addConstraint:yPozConstrPage];
    [self.sliderShow addConstraint:xPozConstPage];
}

- (void)downloadImages{
    
    [self.sliderShow emptyAndAddImagesFromResources:nil];
    
    for (Picture* picture in [self.product.productPictures allObjects]) {
        NSString *urlPath = picture.pictureLink;
        if (urlPath != nil) {
            NSURL *url = [NSURL URLWithString:urlPath];
           
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData *data = [NSData dataWithContentsOfURL:url];
                
                UIImage *image = [UIImage imageWithData:data];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.sliderShow addImage:image];

                });
            });
        }
    }
    
    [activityIndicator stopAnimating];

}


- (void)didChangeValueRating{
    
    //TODO: transmite la server rezultatul
    
    //disable rating
    [self.ratingV setEnabled:NO];
}

- (IBAction)addToCart:(id)sender {
    
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
    
    
    [[tab currentTab]  addProduct:self.product];
    
    
}


@end
