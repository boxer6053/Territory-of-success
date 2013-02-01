//
//  MSProfileViewController.h
//  TerritoryOfSuccess
//
//  Created by Alex on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSProfileViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;

@end
