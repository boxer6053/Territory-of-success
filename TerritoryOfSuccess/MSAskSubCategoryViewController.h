//
//  MSAskSubCategoryViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"
#import <QuartzCore/QuartzCore.h>

@interface MSAskSubCategoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WsCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *askSubCategTable;
@property (nonatomic) id parentID1;

@end
