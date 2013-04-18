//
//  MSTipsViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 4/17/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTipsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *tipsScrollView;
- (IBAction)closeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
