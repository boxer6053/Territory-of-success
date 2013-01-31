//
//  MSCreateQuestionViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSCreateQuestionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MSCreateQuestionViewController ()

@end

@implementation MSCreateQuestionViewController
@synthesize titleLabel = _titleLabel;
@synthesize productImage = _productImage;
@synthesize textField = _textField;
@synthesize productTitle = _productTitle;
@synthesize imageURL = _imageURL;



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"HEEEE %@", _productTitle);
    NSLog(@"HOOOO %@", _imageURL);
    [_productImage setImageWithURL:_imageURL placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    _titleLabel.text = _productTitle;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)askQuestionButton:(id)sender {
    
    NSLog(@"send question");
}
@end
