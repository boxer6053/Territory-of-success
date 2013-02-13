//
//  MSComplaintView.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 11.02.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSComplaintView.h"

@implementation MSComplaintView

@synthesize contentView = _contentView;
@synthesize mainFishkaImageView = _mainFishkaImageView;
@synthesize mainFishkaLabel = _mainFishkaLabel;
@synthesize productImageView = _productImageView;
@synthesize productLabel = _productLabel;
@synthesize productTextField = _productTextField;
@synthesize codeLabel = _codeLabel;
@synthesize codeTextField = _codeTextField;
@synthesize locationLabel = _locationLabel;
@synthesize locationTextField = _locationTextField;
@synthesize commentTextView = _commentTextView;
@synthesize sendComplaintButton = _sendComplaintButton;
@synthesize cancelButton = _cancelButton;
@synthesize closeButton = _closeButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 4, self.frame.size.width, self.frame.size.height - 4)];
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dialogViewGradient.png"]]];
        [self.contentView.layer setCornerRadius:10.0];
        [self.contentView.layer setBorderColor:[UIColor colorWithWhite:0.5 alpha:1.0].CGColor];
        [self.contentView.layer setBorderWidth:2.0];
        [self.contentView setClipsToBounds:YES];
        [self addSubview:self.contentView];
        
        self.mainFishkaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(56, 0, 198, 33)];
        [self.mainFishkaImageView setImage:[UIImage imageNamed:@"TOS cap.png"]];
        [self addSubview:self.mainFishkaImageView];
        
        self.mainFishkaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 178, 20)];
        self.mainFishkaLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
        [self.mainFishkaLabel setTextColor:[UIColor whiteColor]];
        [self.mainFishkaLabel setBackgroundColor:[UIColor clearColor]];
        [self.mainFishkaLabel setTextAlignment:NSTextAlignmentCenter];
        [self.mainFishkaLabel setText:@"ОТПРАВКА ЖАЛОБЫ"];
        [self.mainFishkaImageView addSubview:self.mainFishkaLabel];
        
        //кнопка Close
        self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.closeButton setFrame:CGRectMake(287, 8, 15, 15)];
        [self.closeButton setBackgroundImage:[UIImage imageNamed:@"closeIcon.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.closeButton];
        
        //product imageView
        self.productImageView = [[UIImageView alloc] init];
        [self.productImageView setFrame:CGRectMake(10, 40, 100, 100)];
        [self.productImageView setClipsToBounds:YES];
        [self.productImageView.layer setCornerRadius:5.0];
        [self.productImageView setBackgroundColor:[UIColor whiteColor]];
        [self.productImageView setImage:[UIImage imageNamed:@"photo_camera_1.png"]];
        [self.contentView addSubview:self.productImageView];
                
        //textField назви продукта
        self.productTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, self.productImageView.frame.origin.y, self.frame.size.width - 120 - 10, 30)];
        [self.productTextField setBorderStyle:UITextBorderStyleRoundedRect];
        self.productTextField.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self.productTextField setContentVerticalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.productTextField setPlaceholder:@"Название продукта"];
        [self.productTextField setDelegate:self];
        [self.contentView addSubview:self.productTextField];
                
        //textField коду
        self.codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, self.productTextField.frame.origin.y + self.productTextField.frame.size.height + 5, self.frame.size.width - 120 - 10, 30)];
        [self.codeTextField setBorderStyle:UITextBorderStyleRoundedRect];
        self.codeTextField.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self.codeTextField setContentVerticalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.codeTextField setPlaceholder:@"Код на упаковке"];
        [self.codeTextField setDelegate:self];
        [self.contentView addSubview:self.codeTextField];
                
        //textField location
        self.locationTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, self.codeTextField.frame.origin.y + self.codeTextField.frame.size.height + 5, self.frame.size.width - 120 - 10, 30)];
        [self.locationTextField setBorderStyle:UITextBorderStyleRoundedRect];
        self.locationTextField.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self.locationTextField setContentVerticalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.locationTextField setPlaceholder:@"Место покупки"];
        [self.locationTextField setDelegate:self];
        [self.contentView addSubview:self.locationTextField];
        
        //comment textView
        self.commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(self.productImageView.frame.origin.x, self.productImageView.frame.origin.y + self.productImageView.frame.size.height + 10, 290, 100)];
        [self.commentTextView.layer setCornerRadius:5.0];
        [self.commentTextView setText:@"Напышыте коментарий к жалобе!"];
        [self.commentTextView setTextColor:[UIColor lightGrayColor]];
        [self.commentTextView setDelegate:self];
        self.commentTextView.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:self.commentTextView];
                
        //send button
        self.sendComplaintButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.sendComplaintButton setFrame:CGRectMake(10, self.commentTextView.frame.origin.y + self.commentTextView.frame.size.height + 10, 140, 35)];
        [self.sendComplaintButton setBackgroundImage:[UIImage imageNamed:@"button_140*35.png"] forState:UIControlStateNormal];
        [self.sendComplaintButton setTitle:@"Отправыть" forState:UIControlStateNormal];
        [self.sendComplaintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sendComplaintButton.titleLabel.font
        = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [self.contentView addSubview:self.sendComplaintButton];
        
        //cancel button
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.cancelButton setFrame:CGRectMake(160, self.commentTextView.frame.origin.y + self.commentTextView.frame.size.height + 10, 140, 35)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"button_140*35.png"] forState:UIControlStateNormal];
        [self.cancelButton setTitle:@"Отмена" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font
        = [UIFont fontWithName:@"Helvetica-Bold" size:12.0];
        [self.contentView addSubview:self.cancelButton];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Напышыте коментарий к жалобе!"])
        textView.text = @"";
    textView.textColor = [UIColor blackColor];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]){
        textView.text = @"Напышыте коментарий к жалобе!";
        textView.textColor = [UIColor lightGrayColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140)
    {
        if (location != NSNotFound)
        {
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    else if (location != NSNotFound)
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
