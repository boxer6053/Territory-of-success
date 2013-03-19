//
//  MSAddingProductView.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 3/18/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAddingProductView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MSAddingProductView
@synthesize contentView = _contentView;
@synthesize productImageView = _productImageView;
@synthesize categoryLabel = _categoryLabel;
@synthesize productTextField = _productTextField;
@synthesize sendProductButton = _sendProductButton;
@synthesize cancelButton = _cancelButton;
@synthesize categoryID;
@synthesize api = _api;

@synthesize sendingImage = _sendingImage;
@synthesize sendingText = _sendingText;

- (MSAPI *)api
{
    if(!_api)
    {
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}
- (id)initWithOrigin:(CGPoint)origin{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        self.sendingText = [[NSString alloc]init];
        self.sendingImage = [[UIImage alloc] init];
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
        self.contentView = [[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 260, 250)];
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dialogViewGradient.png"]]];
        [self.contentView.layer setCornerRadius:10.0];
        [self.contentView.layer setBorderColor:[UIColor colorWithWhite:0.5 alpha:1.0].CGColor];
        [self.contentView.layer setBorderWidth:2.0];
        [self.contentView setClipsToBounds:YES];
        [self addSubview:self.contentView];
        
        self.categoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 70, 21)];
         self.categoryLabel.text = @"e-mail:";
         self.categoryLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
         self.categoryLabel.textColor = [UIColor whiteColor];
         self.categoryLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.categoryLabel];
        
        self.productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        [self.productImageView setImage:[UIImage imageNamed:@"plaseholder_415*415.png"]];
        [self.contentView addSubview:self.productImageView];
        self.productTextField = [[UITextField alloc]initWithFrame:CGRectMake(110, 51, 175, 30)];
        [self.contentView addSubview:self.productTextField];
        
        self.sendProductButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 200, 120, 35)];
        [self.sendProductButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.sendProductButton.titleLabel.textColor = [UIColor whiteColor];
        self.sendProductButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [self.sendProductButton setTitle:NSLocalizedString(@"Войти", nil) forState:UIControlStateNormal];
        [self.sendProductButton addTarget:self action:@selector(sendPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.sendProductButton];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 200, 120, 35)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.textColor = [UIColor whiteColor];
        self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [self.cancelButton setTitle:NSLocalizedString(@"Отмена", nil) forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.cancelButton];
        
        self.productTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 120, 240, 30)];
        self.productTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.productTextField.clearButtonMode = YES;
        self.productTextField.delegate = self;
        self.productTextField.keyboardType = UIKeyboardTypeEmailAddress;
        [self.contentView addSubview:self.productTextField];
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 100, 30)];
        self.categoryLabel.text = @"Input name";
        [self.categoryLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.categoryLabel];

        
    }
    return self;

}
-(void)dismissSendingViewWithResult:(BOOL)result
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    }
                     completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         [self.delegate dismissPopView:result];
     }];
}
-(void)sendPressed{
    
    self.sendingText = self.productTextField.text;
    NSLog(@"category ID %d",self.categoryID);
    NSLog(@"name %@",self.sendingText);
    [self.api sendCustomProductWithImage:self.sendingImage withName:self.sendingText withImageName:@"productImage" withParentID:self.categoryID];
    [self dismissSendingViewWithResult:YES];
    
}

-(void)cancelPressed
{
    
[self dismissSendingViewWithResult:YES];
}
-(void)blackOutOfBackground
{
    [UIView animateWithDuration:0.2 animations:^
     {
         [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
     }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type {
    
}
@end
