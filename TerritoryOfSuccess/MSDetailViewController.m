//
//  MSDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 17.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSDetailViewController.h"

@interface MSDetailViewController ()

@end

@implementation MSDetailViewController

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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"logoDetailBackground.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
