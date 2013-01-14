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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_image.png"]]];
    _tableView.layer.cornerRadius = 10;
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
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* myIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    cell.textLabel.text = @"Название категории";
    cell.textLabel.alpha = 1.0;
    cell.detailTextLabel.text = @"Описание";
    return cell;
}
@end
