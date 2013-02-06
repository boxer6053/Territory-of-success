//
//  MSQuestionDetailViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/6/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSQuestionDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *questionDescriptionView;
@property (weak, nonatomic) IBOutlet UILabel *askerNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerField;
@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (strong, nonatomic) NSString *gettedName;
@property (strong, nonatomic) NSString *gettedDescription;

@end
