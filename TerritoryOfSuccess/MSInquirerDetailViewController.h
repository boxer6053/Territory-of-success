//
//  MSInquirerDetailViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSInquirerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *inquirerTitle;
@property (nonatomic) NSInteger inquirerType;
@property   (strong, nonatomic) NSString *test;

@end
