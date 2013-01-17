//
//  MSFirstNavigationController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 08.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSFirstNavigationController.h"

@interface MSFirstNavigationController ()

@end

@implementation MSFirstNavigationController

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
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"logoDetailBackground.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor blackColor], UITextAttributeTextColor,
                                                 [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:20.0], UITextAttributeFont,
                                                 nil]];
    [self.mainNavigationBar setBackgroundImage:[UIImage imageNamed:@"mainLogoBackground.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
