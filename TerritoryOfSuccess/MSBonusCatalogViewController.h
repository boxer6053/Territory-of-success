//
//  MSBonusCatalogViewController.h
//  TerritoryOfSuccess
//
//  Created by Alex on 2/27/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSBonusCatalogViewController : UITableViewController <WsCompleteDelegate>

@property (strong, nonatomic) IBOutlet UITableView *bonusCatalog;

- (void)setCategoriesList:(NSArray *)categoriesList;

@end
