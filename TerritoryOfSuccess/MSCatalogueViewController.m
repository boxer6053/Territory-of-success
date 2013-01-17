//
//  MSCatalogueViewController.m
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 11.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSCatalogueViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSCatalogueViewController ()

@end

@implementation MSCatalogueViewController
@synthesize tableView = _tableView;
@synthesize detailTableView = _detailTableView;
@synthesize detailLabel = _detailLabel;

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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
        NSLog(@"568");
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
        NSLog(@"480");
    }
    _tableView.layer.cornerRadius = 10;
    [_tableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_tableView.layer setBorderWidth:1.0f];
    [_tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    _detailTableView.layer.cornerRadius = 10;
    [_detailTableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_detailTableView.layer setBorderWidth:1.0f];
    [_detailTableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    _detailLabel.text = @"Описание";
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[self.productAndBonusesControl.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0 alpha:1]];
    [[self.productAndBonusesControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)segmentPressed:(id)sender {
    for (int i=0; i<[self.productAndBonusesControl.subviews count]; i++){
        
        if ([[self.productAndBonusesControl.subviews objectAtIndex:i]isSelected] ){
            
            UIColor *tintcolor=[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0.0/255.0 alpha:1.0];
            [[self.productAndBonusesControl.subviews objectAtIndex:i] setTintColor:tintcolor];
                    } else {
                        UIColor *tintcolor=[UIColor blackColor]; // default color
                        [[self.productAndBonusesControl.subviews objectAtIndex:i] setTintColor:tintcolor];
                        }
           }
    
    if (self.productAndBonusesControl.selectedSegmentIndex == 0){
        self.mainLabel.text = @"Категории продуктов:";
    } else {
        self.mainLabel.text = @"Категории бонусов:";
    }
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (tableView == _tableView) {
        static NSString* myIdentifier = @"cellIdentifier";
        cell = [_tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
        }
        cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
        cell.textLabel.text = @"Название категории";
        cell.detailTextLabel.text = @"Описание";
    }
    if (tableView == _detailTableView) {
        static NSString* myIdentifier = @"detailCellIdentifier";
        cell = [_tableView dequeueReusableCellWithIdentifier:myIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
        }
        cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
        cell.textLabel.text = @"Название продукта";
        cell.detailTextLabel.text = @"Описание";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mainLabel.frame = CGRectMake(-300, self.mainLabel.frame.origin.y, self.mainLabel.frame.size.width, self.mainLabel.frame.size.height);
            _tableView.frame = CGRectMake(-310, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
        
            self.backButton.frame = CGRectMake(0, self.backButton.frame.origin.y, self.backButton.frame.size.width, self.backButton.frame.size.height);
            _detailLabel.frame = CGRectMake(30, -64, _detailLabel.frame.size.width, _detailLabel.frame.size.width);
        
        
            _detailTableView.frame = CGRectMake(30, _detailTableView.frame.origin.y, _detailTableView.frame.size.width, _detailTableView.frame.size.height);
            _detailTableView.delegate = self;
            _detailTableView.dataSource = self;
            [_detailTableView reloadData];
 
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                    self.backButton.alpha = 1.0;
            }];
        }];
    }
    
    if (tableView == _detailTableView) {
        [self performSegueWithIdentifier:@"toDetailView" sender:_detailTableView];
    }
    
}
- (IBAction)backButtonAction:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.backButton.alpha = 0.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.mainLabel.frame = CGRectMake(30, self.mainLabel.frame.origin.y, self.mainLabel.frame.size.width, self.mainLabel.frame.size.height);
            _tableView.frame = CGRectMake(20, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height);
            
            self.backButton.frame = CGRectMake(320, self.backButton.frame.origin.y, self.backButton.frame.size.width, self.backButton.frame.size.height);
            _detailLabel.frame = CGRectMake(330, _detailLabel.frame.origin.y, _detailLabel.frame.size.width, _detailLabel.frame.size.width);
            
            _detailTableView.frame = CGRectMake(330, _detailTableView.frame.origin.y, _detailTableView.frame.size.width, _detailTableView.frame.size.height);
            _detailTableView.delegate = self;
            _detailTableView.dataSource = self;
            [_detailTableView reloadData];
        }];
    }];

}
@end
