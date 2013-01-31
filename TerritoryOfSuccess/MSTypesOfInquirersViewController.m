//
//  MSInquirerViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "MSTypesOfInquirersViewController.h"
#import "MSInquirerDetailViewController.h"

@interface MSTypesOfInquirersViewController ()

@end


@implementation MSTypesOfInquirersViewController
@synthesize tableOfInquirers = _tableOfInquirers;
@synthesize testInquirers = _testInquirers;
@synthesize selectedValue = _selectedValue;
@synthesize allInquirerMode;
@synthesize myInquirerMode;
@synthesize inquirerTypeSegment = _inquirerTypeSegment;



- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    NSLog(@"VIEW DID LOAD");
    [self setSegmentControlColor];
    _tableOfInquirers.delegate = self;
    _tableOfInquirers.dataSource = self;
    _testInquirers = [[NSArray alloc] initWithObjects:@"1",@"2", nil];
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
-(void)setSegmentControlColor
{
    if (_inquirerTypeSegment.selectedSegmentIndex == 0) {
        [[_inquirerTypeSegment.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[_inquirerTypeSegment.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }else{
        [[_inquirerTypeSegment.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[_inquirerTypeSegment.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setSegmentControlColor];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _testInquirers.count;
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
    cell.textLabel.text = [_testInquirers objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"Детали опроса";
    cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedValue = cell.textLabel.text;
    NSLog (@"%@", _selectedValue);
    [self performSegueWithIdentifier:@"toInquirerDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toInquirerDetail"]){
        MSInquirerDetailViewController *controller = (MSInquirerDetailViewController *)segue.destinationViewController;
        controller.inquirerType = [_selectedValue integerValue];
        NSLog(@"ss %@", _selectedValue);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inquirerTypeSwitch:(id)sender {
    
    [self setSegmentControlColor];
    [_tableOfInquirers reloadData];
}
@end
