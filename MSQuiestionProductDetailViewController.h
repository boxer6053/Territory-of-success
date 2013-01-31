//
//  MSQuiestionProductDetailViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSQuiestionProductDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableOfAnswers;
@property (strong, nonatomic) NSURL *gettedUrlImage;
@property (strong, nonatomic) NSString *gettedProductTitle;



@end
