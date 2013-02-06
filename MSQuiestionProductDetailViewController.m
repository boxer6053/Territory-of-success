//
//  MSQuiestionProductDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuiestionProductDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "MSCreateQuestionViewController.h"
#import "MSQuestionsForProductViewController.h"

@interface MSQuiestionProductDetailViewController ()

@end

@implementation MSQuiestionProductDetailViewController
@synthesize gettedUrlImage = _gettedUrlImage;
@synthesize gettedProductTitle = _gettedProductTitle;
@synthesize productImage = _productImage;
@synthesize productTitleLabel = _productTitleLabel;

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
    if([segue.identifier isEqualToString:@"toQuestionList"])
    {
       MSQuestionsForProductViewController *controller = (MSQuestionsForProductViewController *)segue.destinationViewController;
        controller.gettedProductTitle = _sendingTitle;
        controller.gettedUrlImage = _sendingURL;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
