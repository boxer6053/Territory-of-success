//
//  MSQuestionDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/6/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionDetailViewController.h"

@interface MSQuestionDetailViewController ()

@end

@implementation MSQuestionDetailViewController
@synthesize gettedName = _gettedName;
@synthesize gettedDescription = _gettedDescription;
@synthesize askerNameLabel = _askerNameLabel;
@synthesize questionDescriptionView = _questionDescriptionView;


- (void)viewDidLoad
{
    _askerNameLabel.text = _gettedName;
    _questionDescriptionView.text = _gettedDescription;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
