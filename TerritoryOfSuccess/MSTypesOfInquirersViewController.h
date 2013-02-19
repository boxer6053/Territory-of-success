//
//  MSInquirerViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSTypesOfInquirersViewController : UIViewController <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, WsCompleteDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableOfInquirers;
@property (strong, nonatomic) NSArray *testInquirers;
@property (strong, nonatomic) NSArray *myQuestionsArray;
@property (strong, nonatomic) NSArray *allQuestionsArray;
@property (weak, nonatomic) NSString *selectedValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inquirerTypeSegment;
- (IBAction)inquirerTypeSwitch:(id)sender;
@property BOOL allInquirerMode;
@property BOOL  myInquirerMode;
@property (nonatomic) BOOL isAuthorized;
@property (nonatomic) NSString * sendingID;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addQuestionButton;


@end
