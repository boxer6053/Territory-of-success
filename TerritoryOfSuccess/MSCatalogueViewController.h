//
//  MSCatalogueViewController.h
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 11.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCatalogueViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *productAndBonusesControl;
- (IBAction)segmentPressed:(id)sender;

@end
