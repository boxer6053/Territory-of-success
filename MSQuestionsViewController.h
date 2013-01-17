//
//  MSQuestionsViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/9/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MSQuestionDetailViewController.h"
@interface MSQuestionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *allArray;
    NSArray *myArray;
    NSMutableArray *myQuestionsArray;
}



@property BOOL myQuestionsMode;
@property BOOL allQuestionsMode;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)questionDoubleButton:(id)sender;
@property (strong, nonatomic) NSMutableDictionary *testDictionary;
@property (strong, nonatomic) NSDictionary *questionsDictionary;
@property (weak, nonatomic) NSArray *questionTitles;
@property (weak, nonatomic) NSString *questionTitle;
@property (weak, nonatomic) NSString *questionDescription;

@property (weak, nonatomic) IBOutlet UILabel *questionDetailTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *questionDetailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableOfAnswers;
- (IBAction)backToQuestionTable:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end
