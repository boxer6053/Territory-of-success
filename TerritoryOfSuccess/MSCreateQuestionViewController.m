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
@synthesize delegate = _delegate;
@synthesize tap = _tap;
@synthesize sentArray = _sentArray;



- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"HEEEE %@", _productTitle);
    NSLog(@"HOOOO %@", _imageURL);
    [_productImage setImageWithURL:_imageURL placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    _titleLabel.text = _productTitle;
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed:)];
    [self.view addGestureRecognizer:_tap];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)askQuestionButton:(id)sender {
    
    _sentArray = [[NSMutableArray alloc] init];
    NSString *name = @"Me";
    NSString *question = _textField.text;
    [_sentArray addObject:name];
    [_sentArray addObject:question];
    [self.delegate addNewQuestion:[self sentArray]];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"send question");
}
-(void)tapPressed:(UITapGestureRecognizer *)recognizer{
    [_textField resignFirstResponder];
}

- (IBAction)cancelAction:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
