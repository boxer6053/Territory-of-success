//
//  MSTabBarController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 08.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSAPI.h"

@interface MSTabBarController ()

@property (strong, nonatomic) MSAPI *api;

@end

@implementation MSTabBarController

@synthesize myTabBarController = _myTabBarController;
@synthesize receivedData = _receivedData;
@synthesize api = _api;

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
            
    self.api = [[MSAPI alloc] init];
    
    [self.api setDelegate:self];
    
//  [self.api getNewsWithId:@"3"];
//    [self.api getAllNews];
//    [self.api getNewsWithId:@"3"];
    [self.api checkCode:@"2EA4-29E9-CCE0-90EB"];
    
}

- (void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
