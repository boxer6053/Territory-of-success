//
//  MSInquirerViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSInquirerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSInquirerViewController ()

@end


@implementation MSInquirerViewController
@synthesize tableOfInquirers = _tableOfInquirers;


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
   
    _tableOfInquirers.delegate = self;
    _tableOfInquirers.dataSource = self;
    [_tableOfInquirers setShowsVerticalScrollIndicator:NO];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    _tableOfInquirers.layer.cornerRadius = 10;
    [_tableOfInquirers.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_tableOfInquirers.layer setBorderWidth:1.0f];
    [_tableOfInquirers.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
       
	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
        static NSString* cellIdentifier = @"inquirerCellID";
        cell = [_tableOfInquirers dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        }
    cell.textLabel.text = @"Название опроса";
    cell.detailTextLabel.text = @"Детали опроса";
    cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
