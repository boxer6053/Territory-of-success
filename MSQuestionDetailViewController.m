//
//  MSQuestionDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/10/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionDetailViewController.h"

@interface MSQuestionDetailViewController ()

@end

@implementation MSQuestionDetailViewController
@synthesize data;
@synthesize questionDescription;
@synthesize questionTitle;
@synthesize questionDescriptionLabel;
@synthesize questionTitleLabel;
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
    [super viewDidLoad];
    self.questionDescriptionLabel.text = questionDescription;
    self.questionTitleLabel.text = questionTitle;
    for (id key in [data allKeys])
        NSLog(@"Key : %@ => value : %@", key, [data objectForKey:key]);
    NSLog(@"Number %u", data.count);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
