//
//  MSDetailViewController.h
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 17.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;
@property (strong, nonatomic) IBOutlet UIView *likeView;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIScrollView *detailPageScroll;
@property (strong, nonatomic) IBOutlet UITextView *productDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@end
