//
//  MSAddingProductView.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 3/18/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAddingProductView.h"
#import <QuartzCore/QuartzCore.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



@implementation MSAddingProductView
@synthesize contentView = _contentView;
@synthesize productImageView = _productImageView;
@synthesize categoryLabel = _categoryLabel;
@synthesize productTextField = _productTextField;
@synthesize brandTextField = _brandTextField;
@synthesize sendProductButton = _sendProductButton;
@synthesize cancelButton = _cancelButton;
@synthesize categoryID;
@synthesize api = _api;
@synthesize nc = _nc;

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
        self.contentView = [[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, 320, 170)];
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dialogViewGradient.png"]]];
        [self.contentView.layer setCornerRadius:10.0];
        [self.contentView.layer setBorderColor:[UIColor colorWithWhite:0.5 alpha:1.0].CGColor];
        [self.contentView.layer setBorderWidth:2.0];
        [self.contentView setClipsToBounds:YES];
        [self addSubview:self.contentView];
        
//        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 100, 60)];
//        self.categoryLabel.numberOfLines = 2;
//        self.categoryLabel.text = NSLocalizedString(@"ProductNameKey", nil);
//         self.categoryLabel.backgroundColor = [UIColor clearColor];
//        self.categoryLabel.lineBreakMode = UILineBreakModeWordWrap;
//        [self.categoryLabel setTextColor:[UIColor whiteColor]];
//        [self.contentView addSubview:self.categoryLabel];
        
        
        
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 5, 150, 20)];
        
        self.categoryLabel.numberOfLines = 1;
        self.categoryLabel.text = NSLocalizedString(@"ProductNameKey", nil);
        self.categoryLabel.backgroundColor = [UIColor clearColor];
        [self.categoryLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.categoryLabel];
        
        self.brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 60, 100, 20)];
        self.brandLabel.numberOfLines = 1;
        self.brandLabel.text = NSLocalizedString(@"BrandKey", nil);
        self.brandLabel.backgroundColor = [UIColor clearColor];
        self.brandLabel.lineBreakMode = UILineBreakModeWordWrap;
        [self.brandLabel setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.brandLabel];
        
        if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
            self.categoryLabel.minimumFontSize = 8.0f;
            self.categoryLabel.adjustsFontSizeToFitWidth = YES;
            self.brandLabel.minimumFontSize = 8.0f;
            self.brandLabel.adjustsFontSizeToFitWidth = YES;
        }else{
            self.categoryLabel.minimumScaleFactor = 0.7;
            self.categoryLabel.adjustsFontSizeToFitWidth = YES;
            self.brandLabel.minimumScaleFactor = 0.7;
            self.brandLabel.adjustsFontSizeToFitWidth = YES;
        }
        
        self.productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        [self.productImageView setImage:[UIImage imageNamed:@"plaseholder_415*415.png"]];
        self.productImageView.layer.cornerRadius = 5;
        self.productImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.productImageView];
     
        
        self.sendProductButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 120, 120, 35)];
        [self.sendProductButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.sendProductButton.titleLabel.textColor = [UIColor whiteColor];
        self.sendProductButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [self.sendProductButton setTitle:NSLocalizedString(@"SendKey", nil) forState:UIControlStateNormal];
        [self.sendProductButton addTarget:self action:@selector(sendPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.sendProductButton];
        
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 120, 120, 35)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.textColor = [UIColor whiteColor];
        self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [self.cancelButton setTitle:NSLocalizedString(@"Отмена", nil) forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.cancelButton];
        
        self.productTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 30, 190, 30)];
        self.productTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.productTextField.clearButtonMode = YES;
        self.productTextField.delegate = self;
        self.productTextField.keyboardType = UIKeyboardTypeEmailAddress;
        [self.contentView addSubview:self.productTextField];
        
        self.brandTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 80, 190, 30)];
        self.brandTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.brandTextField.clearButtonMode = YES;
        self.brandTextField.delegate = self;
        self.brandTextField.keyboardType = UIKeyboardTypeEmailAddress;
        [self.contentView addSubview:self.brandTextField];
        
        
      

        self.nc = [NSNotificationCenter defaultCenter];
        
        [self.nc addObserver:self selector:@selector(keyboardWillShow:) name:
         UIKeyboardWillShowNotification object:nil];
        
        [self.nc addObserver:self selector:@selector(keyboardWillHide:) name:
         UIKeyboardWillHideNotification object:nil];

        
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

         [self.delegate dismissPopViewAdd:result];
     }];
}
-(void)sendPressed{
    
    NSString *divider = @" ";
    NSString *firstPart = [self.brandTextField.text stringByAppendingString:divider];
    
    self.sendingText =[firstPart stringByAppendingString:self.productTextField.text];
    //self.productTextField.text;
    NSLog(@"category ID %d",self.categoryID);
    NSLog(@"name %@",self.sendingText);
    [self.api sendCustomProductWithImage:self.sendingImage withName:self.sendingText withImageName:@"productImage" withParentID:self.categoryID];
    [self.delegate updateTable];
    [self dismissSendingViewWithResult:YES];
    
}
- (void)keyboardWillShow:(NSNotification *)note
{
    if (!([[UIScreen mainScreen] bounds].size.height == 568))
    {
        [UIView animateWithDuration:0.2 animations:
         ^{
             self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y - 50, self.contentView.frame.size.width, self.contentView.frame.size.height);
         }];
    }
    //    [self addGestureRecognizer:self.tapRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    if (!([[UIScreen mainScreen] bounds].size.height == 568))
    {
        [UIView animateWithDuration:0.2 animations:
         ^{
             self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y + 50, self.contentView.frame.size.width, self.contentView.frame.size.height);
         }];
    }
    //    [self removeGestureRecognizer:self.tapRecognizer];
}
-(void)cancelPressed
{
   // [self.delegate updateTable];
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
