//
//  MSQuiestionProductDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuiestionProductDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import "MSCreateQuestionViewController.h"

@interface MSQuiestionProductDetailViewController ()

@end

@implementation MSQuiestionProductDetailViewController
@synthesize gettedUrlImage = _gettedUrlImage;
@synthesize gettedProductTitle = _gettedProductTitle;
@synthesize productImage = _productImage;
@synthesize productTitleLabel = _productTitleLabel;
@synthesize tableOfAnswers = _tableOfAnswers;
@synthesize sendingTitle = _sendingTitle;
@synthesize sendingURL = _sendingURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    [_tableOfAnswers setShowsVerticalScrollIndicator:NO];
      [_tableOfAnswers.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_tableOfAnswers.layer setBorderWidth:1.0f];
    [_tableOfAnswers.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    NSLog(@"Hello %@",_gettedProductTitle);
    NSLog(@"Hi %@", _gettedUrlImage);
    _sendingTitle = _gettedProductTitle;
    _sendingURL = _gettedUrlImage;
    NSLog(@"111 %@", _sendingTitle);
    NSLog(@"222 %@", _sendingURL);

    _productTitleLabel.text = _gettedProductTitle;
    [_productImage setImageWithURL:_gettedUrlImage placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toCreateQuestion"])
    {
        MSCreateQuestionViewController *controller = (MSCreateQuestionViewController *)segue.destinationViewController;
        controller.productTitle = _sendingTitle;
        controller.imageURL = _sendingURL;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
