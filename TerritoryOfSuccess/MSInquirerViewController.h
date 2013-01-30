//
//  MSInquirerViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSInquirerViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableOfInquirers;
@property (strong, nonatomic) NSArray *testInquirers;
@property (weak, nonatomic) NSString *selectedValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inquirerTypeSegment;
- (IBAction)inquirerTypeSwitch:(id)sender;
@property BOOL allInquirerMode;
@property BOOL  myInquirerMode;


@end
