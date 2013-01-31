//
//  MSAskViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSAskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, WsCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableOfCategories;
@property (nonatomic) id translatingValue;
@property (weak, nonatomic) NSURL *translatingUrl;
@property (weak, nonatomic) NSString *sendingTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *upButton;
- (IBAction)upAction:(id)sender;

@property  BOOL upButtonShows;
@end
