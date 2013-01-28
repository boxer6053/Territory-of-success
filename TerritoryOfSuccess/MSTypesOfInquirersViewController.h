//
//  MSTypesOfInquirersViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTypesOfInquirersViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *inquirerPic;
@property (weak, nonatomic) IBOutlet UIButton *whitchIsBetterButton;
@property (weak, nonatomic) IBOutlet UIButton *gradeButton;
- (IBAction)toWhitchIsBetter:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *toGrade;

@end
