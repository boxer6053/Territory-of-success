//
//  MSDialogView.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 26.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MSDialogView : UIView

@property (strong, nonatomic) UIButton *closeButton;
@property (strong, nonatomic) UILabel *captionLabel;
@property (strong, nonatomic) UIImageView *productImageView;
@property (strong, nonatomic) UILabel *productLabel;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UIView *productDescriptionView;
@property (strong, nonatomic) UILabel *productDescripptionLabel;
@property (strong, nonatomic) UIView *categoryDescriptionView;
@property (strong, nonatomic) UILabel *categoryDescripptionLabel;
@property (strong, nonatomic) UIView *messageView;
@property (strong, nonatomic) UILabel *messageLabel;

@end
