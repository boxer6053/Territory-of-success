//
//  MSDialogView.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 26.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSDialogView.h"

@implementation MSDialogView

@synthesize closeButton = _closeButton;
@synthesize captionLabel = _captionLabel;
@synthesize productImageView = _productImageView;
@synthesize productLabel = _productLabel;
@synthesize categoryLabel = _categoryLabel;
@synthesize productDescriptionView = _productDescriptionView;
@synthesize productDescripptionLabel = _productDescripptionLabel;
@synthesize categoryDescriptionView = _categoryDescriptionView;
@synthesize categoryDescripptionLabel = _categoryDescripptionLabel;
@synthesize messageView = _messageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //фонова View
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self.layer setCornerRadius:10.0];
        [self setClipsToBounds:YES];
        
        //кнопка Close
        self.closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [self.closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.closeButton.titleLabel.font
        = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [self.closeButton setFrame:CGRectMake(240, 9, 55, 26)];
        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"button55*30.png"] forState:UIControlStateNormal];
        
        [self addSubview:self.closeButton];
        
        //мітка стану коду
        self.captionLabel = [[UILabel alloc] init];
        [self.captionLabel setFrame:CGRectMake(100, 50, 120, 21)];
        self.captionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
        [self.captionLabel setTextColor:[UIColor colorWithRed:255.0 green:102/255.0 blue:0 alpha:1.0]];
        [self.captionLabel setBackgroundColor:[UIColor clearColor]];
        [self.captionLabel setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:self.captionLabel];
        
        //product imageView
        self.productImageView = [[UIImageView alloc] init];
        [self.productImageView setFrame:CGRectMake(10, 80, 100, 100)];
        [self.productImageView setClipsToBounds:YES];
        [self.productImageView.layer setCornerRadius:5.0];
        
        [self addSubview:self.productImageView];
        
        //мітка заголовку продукта
        self.productLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 80, 40, 11)];
        self.productLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.productLabel setTextColor:[UIColor colorWithRed:255.0 green:102/255.0 blue:0 alpha:1.0]];
        [self.productLabel setBackgroundColor:[UIColor clearColor]];
        [self.productLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.productLabel];
        
        //View опису продукта
        self.productDescriptionView = [[UIView alloc] initWithFrame:CGRectMake(120, 91, 110, 28)];
        [self.productDescriptionView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
        [self.productDescriptionView setClipsToBounds:YES];
        [self.productDescriptionView.layer setCornerRadius:5.0];
        
        [self addSubview:self.productDescriptionView];
        
        //мітка опису продукта
        self.productDescripptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, self.productDescriptionView.frame.size.width - 4, 21)];
        [self.productDescripptionLabel setNumberOfLines:0];
        [self.productDescripptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.productDescripptionLabel setBackgroundColor:[UIColor clearColor]];
        self.productDescripptionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.productDescripptionLabel setTextColor:[UIColor whiteColor]];
        
        [self.productDescriptionView addSubview:self.productDescripptionLabel];
        
        //мітка заголовку категорії
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 125, 65, 11)];
        self.categoryLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.categoryLabel setTextColor:[UIColor colorWithRed:255.0 green:102/255.0 blue:0 alpha:1.0]];
        [self.categoryLabel setBackgroundColor:[UIColor clearColor]];
        [self.categoryLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.categoryLabel];
        
        //View опису продукта
        self.categoryDescriptionView = [[UIView alloc] initWithFrame:CGRectMake(120, 136, 110, 28)];
        [self.categoryDescriptionView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
        [self.categoryDescriptionView setClipsToBounds:YES];
        [self.categoryDescriptionView.layer setCornerRadius:5.0];
        
        [self addSubview:self.categoryDescriptionView];
        
        //мітка опису категорії
        self.categoryDescripptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, self.categoryDescriptionView.frame.size.width - 4, 21)];
        [self.categoryDescripptionLabel setNumberOfLines:0];
        [self.categoryDescripptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.categoryDescripptionLabel setBackgroundColor:[UIColor clearColor]];
        self.categoryDescripptionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.categoryDescripptionLabel setTextColor:[UIColor whiteColor]];
        
        [self.categoryDescriptionView addSubview:self.categoryDescripptionLabel];
        
        //View message
        self.messageView = [[UIView alloc] initWithFrame:CGRectMake(10, 200, 290, 50)];
        [self.messageView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
        [self.messageView setClipsToBounds:YES];
        [self.messageView.layer setCornerRadius:5.0];
        
        [self addSubview:self.messageView];
        
        //label message 
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, self.messageView.frame.size.width - 4, self.messageView.frame.size.height)];
        [self.messageLabel setNumberOfLines:0];
        [self.messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.messageLabel setBackgroundColor:[UIColor clearColor]];
        self.messageLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.messageLabel setTextColor:[UIColor whiteColor]];
        
        [self.messageView addSubview:self.messageLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
