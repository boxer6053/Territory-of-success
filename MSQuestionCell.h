//
//  MSQuestionCell.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/14/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSQuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
- (IBAction)increaseGrade:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gradeButton;

@end
