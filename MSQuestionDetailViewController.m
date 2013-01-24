//
//  MSQuestionDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/10/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSQuestionDetailViewController ()

@end

@implementation MSQuestionDetailViewController
@synthesize data;
@synthesize questionDescription;
@synthesize questionTitle;
@synthesize questionDescriptionLabel;
@synthesize questionTitleLabel;
@synthesize tableOfAnswers;
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
    self.tableOfAnswers.layer.cornerRadius = 10;
    [self.tableOfAnswers.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.tableOfAnswers.layer setBorderWidth:1.0f];
    [self.tableOfAnswers.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
    }
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