//
//  MSLogInView.m
//  TerritoryOfSuccess
//
//  Created by Alex on 2/1/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSLogInView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MSLogInView

@synthesize emailLabel = _emailLabel;
@synthesize emailTextField = _emailTextField;
@synthesize passwordLabel = _passwordLabel;
@synthesize passwordTextField = _passwordTextField;
@synthesize loginButton = _loginButton;
@synthesize cancelButton = _cancelButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // some code
    }
    return self;
}

- (id)initWithLoginButtonText:(NSString *) loginText CancelButtonText:(NSString *)cancelText EmailLabelText:(NSString *)emailText PasswordLabelText:(NSString *)passwordText
{
    self = [super initWithFrame:CGRectMake(25, 150, 270, 135)];
    if (self)
    {
        //global design
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dialogViewGradient.png"]]];
        [self.layer setCornerRadius:10.0];
        [self setClipsToBounds:YES];
        
        //email input
        self.emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 70, 21)];
        self.emailLabel.text = emailText;
        self.emailLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.emailLabel.textColor = [UIColor whiteColor];
        self.emailLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.emailLabel];
        
        self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(85, 15, 175, 30)];
        self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.emailTextField];
        
        //password input
        self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 56, 70, 21)];
        self.passwordLabel.text = passwordText;
        self.passwordLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.passwordLabel.textColor = [UIColor whiteColor];
        self.passwordLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.passwordLabel];
        
        self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(85, 51, 175, 30)];
        self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.passwordTextField];
        
        //buttons
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 91, 120, 35)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.textColor = [UIColor whiteColor];
        self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.cancelButton setTitle:cancelText forState:UIControlStateNormal];
        [self addSubview:self.cancelButton];
        
        self.loginButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 91, 120, 35)];
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.loginButton.titleLabel.textColor = [UIColor whiteColor];
        self.loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.loginButton setTitle:loginText forState:UIControlStateNormal];
        [self addSubview:self.loginButton];
        
    }
    return self;
}

@end
