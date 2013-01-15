//
//  MSQuestionDetailViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/10/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSQuestionDetailViewController : UIViewController
{
    NSDictionary *data;
    NSString *questionTitle;
    NSString *questionDescription;
}
@property (weak, nonatomic) IBOutlet UILabel *questionDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableOfAnswers;
@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSString *questionTitle;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSString *questionDescription;


@end
