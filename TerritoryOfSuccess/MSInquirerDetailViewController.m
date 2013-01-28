//
//  MSInquirerDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSInquirerDetailViewController.h"

@interface MSInquirerDetailViewController ()

@end

@implementation MSInquirerDetailViewController
@synthesize inquirerType = _inquirerType;


- (void)viewDidLoad
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
    _inquirerType = @"Grade the item";
    if(_inquirerType == @"Grade the item")
    {
        UIImageView *imageForInquirer1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 78, 200, 200)];
        [imageForInquirer1 setImage:[UIImage imageNamed:@"appllee.png"]];
        [self.view addSubview:imageForInquirer1];
    }
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
