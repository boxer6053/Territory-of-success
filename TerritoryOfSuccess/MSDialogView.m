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
//@synthesize mainFishkaImageView = _mainFishkaImageView;
@synthesize okButton = _okButton;
@synthesize complaint = _complaint;
@synthesize bonusLabel = _bonusLabel;
@synthesize bonusValueLabel = _bonusValueLabel;
@synthesize bonusNameLabel = _bonusNameLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //фонова View
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dialogViewGradient.png"]]];
        [self.layer setCornerRadius:10.0];
        [self setClipsToBounds:YES];
        
        //кнопка Close
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setFrame:CGRectMake(287, 8, 15, 15)];
        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"closeIcon.png"] forState:UIControlStateNormal];
        
        [self addSubview:self.closeButton];
        
        //мітка стану коду
        self.captionLabel = [[UILabel alloc] init];
        [self.captionLabel setFrame:CGRectMake(93, 50, 124, 21)];
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
        self.productDescriptionView = [[UIView alloc] initWithFrame:CGRectMake(120, 91, self.frame.size.width - 10 - 120, 14)];
        [self.productDescriptionView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [self.productDescriptionView setClipsToBounds:YES];
        [self.productDescriptionView.layer setCornerRadius:5.0];
        
        [self addSubview:self.productDescriptionView];
        
        //мітка опису продукта
        self.productDescripptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, self.productDescriptionView.frame.size.width - 6, self.productDescriptionView.frame.size.height)];
        [self.productDescripptionLabel setNumberOfLines:0];
        [self.productDescripptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.productDescripptionLabel setBackgroundColor:[UIColor clearColor]];
        self.productDescripptionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.productDescripptionLabel setTextColor:[UIColor whiteColor]];
        
        [self.productDescriptionView addSubview:self.productDescripptionLabel];
        
        //мітка заголовку категорії
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, self.productDescriptionView.frame.origin.y + self.productDescriptionView.frame.size.height + 6, 65, 11)];
        self.categoryLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.categoryLabel setTextColor:[UIColor colorWithRed:255.0 green:102/255.0 blue:0 alpha:1.0]];
        [self.categoryLabel setBackgroundColor:[UIColor clearColor]];
        [self.categoryLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.categoryLabel];
        
        //View опису категорії
        self.categoryDescriptionView = [[UIView alloc] initWithFrame:CGRectMake(120, self.categoryLabel.frame.origin.y + self.categoryLabel.frame.size.height, self.frame.size.width - 10 - 120, 14)];
        [self.categoryDescriptionView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [self.categoryDescriptionView setClipsToBounds:YES];
        [self.categoryDescriptionView.layer setCornerRadius:5.0];
        
        [self addSubview:self.categoryDescriptionView];
        
        //мітка опису категорії
        self.categoryDescripptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, self.categoryDescriptionView.frame.size.width - 6, self.categoryDescriptionView.frame.size.height)];
        [self.categoryDescripptionLabel setNumberOfLines:0];
        [self.categoryDescripptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.categoryDescripptionLabel setBackgroundColor:[UIColor clearColor]];
        self.categoryDescripptionLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.categoryDescripptionLabel setTextColor:[UIColor whiteColor]];
        
        [self.categoryDescriptionView addSubview:self.categoryDescripptionLabel];
        
        //бонус label
        self.bonusLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, self.categoryDescriptionView.frame.origin.y + self.categoryDescriptionView.frame.size.height + 6, 120, 11)];
        self.bonusLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.bonusLabel setTextColor:[UIColor colorWithRed:255.0 green:102/255.0 blue:0 alpha:1.0]];
        [self.bonusLabel setBackgroundColor:[UIColor clearColor]];
        [self.bonusLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.bonusLabel];
        
        //bonus value label
        self.bonusValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, self.bonusLabel.frame.origin.y + self.bonusLabel.frame.size.height, 120, 22)];
        self.bonusValueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25.0];
        [self.bonusValueLabel setTextColor:[UIColor whiteColor]];
        [self.bonusValueLabel setBackgroundColor:[UIColor clearColor]];
        [self.bonusValueLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self addSubview:self.bonusValueLabel];
        
        //bonus name label
        self.bonusNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, self.bonusValueLabel.frame.origin.y + self.bonusValueLabel.frame.size.height, 120, 12)];
        self.bonusNameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [self.bonusNameLabel setTextColor:[UIColor whiteColor]];
        [self.bonusNameLabel setBackgroundColor:[UIColor clearColor]];
        [self.bonusNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.bonusNameLabel setText:@"баллов"];
        
        [self addSubview:self.bonusNameLabel];
        
        //View message
        self.messageView = [[UIView alloc] initWithFrame:CGRectMake(10, self.bonusNameLabel.frame.origin.y + self.bonusNameLabel.frame.size.height + 20, 290, 50)];
        [self.messageView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        [self.messageView setClipsToBounds:YES];
        [self.messageView.layer setCornerRadius:5.0];
        
        [self addSubview:self.messageView];
        
        //label message 
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, self.messageView.frame.size.width - 6, self.messageView.frame.size.height)];
        [self.messageLabel setNumberOfLines:0];
        [self.messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.messageLabel setBackgroundColor:[UIColor clearColor]];
        self.messageLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
        [self.messageLabel setTextColor:[UIColor whiteColor]];
        
        [self.messageView addSubview:self.messageLabel];
        
//        self.mainFishkaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(56, -4, 198, 33)];
//        [self.mainFishkaImageView setImage:[UIImage imageNamed:@"TOS cap.png"]];
//        
//        [self addSubview:self.mainFishkaImageView];
        
        self.okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.okButton setFrame:CGRectMake(20, self.messageView.frame.origin.y + self.messageView.frame.size.height + 20, 120, 35)];
        [self.okButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
//        self.okButton set
        
        [self.okButton setTitle:@"OK" forState:UIControlStateNormal];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.okButton.titleLabel.font
        = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        
        [self addSubview:self.okButton];
        
        self.complaint = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.complaint setFrame:CGRectMake(310 - 120 - 20, self.messageView.frame.origin.y + self.messageView.frame.size.height + 20, 120, 35)];
        [self.complaint setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        //        self.okButton set
        
        [self.complaint setTitle:@"Отправить жалобу" forState:UIControlStateNormal];
        [self.complaint setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.complaint.titleLabel.font
        = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        
        [self addSubview:self.complaint];
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
