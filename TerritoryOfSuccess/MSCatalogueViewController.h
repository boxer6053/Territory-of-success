//
//  MSCatalogueViewController.h
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 11.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCatalogueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *productAndBonusesControl;
- (IBAction)segmentPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;
@property (strong, nonatomic) IBOutlet UILabel *mainLabel;

@end
