//
//  MSQuestionsForProductViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/5/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCreateQuestionViewController.h"

@interface MSQuestionsForProductViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AddingQuestionDelegate>

@property (strong, nonatomic) NSURL *gettedUrlImage;
@property (strong, nonatomic) NSString *gettedProductTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableOfQuestions;
@property (strong, nonatomic) NSMutableArray *questionsArray;

@end
