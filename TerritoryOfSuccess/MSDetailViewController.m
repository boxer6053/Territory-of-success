//
//  MSDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 17.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

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
    [self.detailImage.layer setCornerRadius:10.0];
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
