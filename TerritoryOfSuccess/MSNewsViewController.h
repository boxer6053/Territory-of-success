//
//  MSNewsViewController.h
//  TerritoryOfSuccess
//
//  Created by Alex on 1/14/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSNewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *articleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *articleTextView;
@property (strong, nonatomic) IBOutlet UIButton *beckButton;
- (IBAction)beckButtonClick:(id)sender;

@end
