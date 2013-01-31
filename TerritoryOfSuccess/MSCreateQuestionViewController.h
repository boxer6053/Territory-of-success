//
//  MSCreateQuestionViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSCreateQuestionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)askQuestionButton:(id)sender;
@property (weak, nonatomic) NSString *productTitle;
@property (weak, nonatomic) NSURL *imageURL;

@end
