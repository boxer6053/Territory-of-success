//
//  MSAnswerViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/6/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSAnswerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *answerField;

- (IBAction)answerButton:(id)sender;

@end
