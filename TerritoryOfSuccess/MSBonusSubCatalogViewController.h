//
//  MSBonusSubCatalogViewController.h
//  TerritoryOfSuccess
//
//  Created by Alex on 2/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSBonusSubCatalogViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *subCatalogTableView;

- (void)setSubCategoriesList:(NSArray *)subCategoriesList;

@end
