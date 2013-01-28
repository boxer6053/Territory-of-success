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


- (void)viewDidLoad
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
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
