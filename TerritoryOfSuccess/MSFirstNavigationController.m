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
    [self.mainTabBarItem setTitle:NSLocalizedString(@"MainTabBarItemKey", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setMainTabBarItem:nil];
    [super viewDidUnload];
}
@end
