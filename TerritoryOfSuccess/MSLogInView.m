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
@synthesize passwordConfrimLabel = _passwordConfrimLabel;
@synthesize passwordConfrimTextField = _passwordConfrimTextField;
@synthesize loginButton = _loginButton;
@synthesize cancelButton = _cancelButton;
@synthesize registrationButton = _registrationButton;
@synthesize registrationMode = _registrationMode;
@synthesize backToLoginButton = _backToLoginButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [self init];
    }
    return self;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(25, 150, 270, 180)];
    if (self)
    {
        self.registrationMode = NO;
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dialogViewGradient.png"]]];
        [self.layer setCornerRadius:10.0];
        [self.layer setBorderColor:[UIColor colorWithWhite:0.5 alpha:1.0].CGColor];
        [self.layer setBorderWidth:2.0];
        [self setClipsToBounds:YES];
        
        //email input
        self.emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 70, 21)];
        self.emailLabel.text = @"e-mail:";
        self.emailLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.emailLabel.textColor = [UIColor whiteColor];
        self.emailLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.emailLabel];
        
        self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(85, 15, 175, 30)];
        self.emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.emailTextField];
        
        //password input
        self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 56, 70, 21)];
        self.passwordLabel.text = @"password:";
        self.passwordLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.passwordLabel.textColor = [UIColor whiteColor];
        self.passwordLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.passwordLabel];
        
        self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(85, 51, 175, 30)];
        self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.passwordTextField];
        
        //confrim password input for registration
        self.passwordConfrimLabel = [[UILabel alloc]initWithFrame:CGRectMake(280, 92, 70, 21)];
        self.passwordConfrimLabel.text = @"password:";
        self.passwordConfrimLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.passwordConfrimLabel.textColor = [UIColor whiteColor];
        self.passwordConfrimLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.passwordConfrimLabel];
        
        self.passwordConfrimTextField = [[UITextField alloc]initWithFrame:CGRectMake(355, 87, 125, 30)];
        self.passwordConfrimTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.passwordConfrimTextField];
        
        self.backToLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(485, 87, 45, 30)];
        [self.backToLoginButton setBackgroundColor:[UIColor clearColor]];
        self.backToLoginButton.titleLabel.textColor = [UIColor orangeColor];
        [self.backToLoginButton setTitle:@">" forState:UIControlStateNormal];
        [self.backToLoginButton addTarget:self action:@selector(backToLoginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backToLoginButton];
        
        //buttons
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 131, 120, 35)];
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.textColor = [UIColor whiteColor];
        self.cancelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(screenWasTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
        
        self.loginButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 131, 120, 35)];
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"button_120*35_new.png"] forState:UIControlStateNormal];
        self.loginButton.titleLabel.textColor = [UIColor whiteColor];
        self.loginButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.loginButton];
        
        self.registrationButton = [[UIButton alloc]initWithFrame:CGRectMake(140, 91, 120, 30)];
        [self.registrationButton setBackgroundColor:[UIColor clearColor]];
        [self.registrationButton.titleLabel setTextColor:[UIColor orangeColor]];
        self.registrationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.registrationButton setTitle:@"Registrate" forState:UIControlStateNormal];
        [self.registrationButton addTarget:self action:@selector(registrationPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.registrationButton];
        
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(screenWasTapped:)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

- (void) attachPopUpAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation
                                      animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(0.5, 0.5, 1);
    CATransform3D scale2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = .2;
    
    [self.layer addAnimation:animation forKey:@"popup"];
}

-(void)screenWasTapped:(id)sender
{
    [self.delegate dismissPopView];
}

-(void)loginPressed
{
    
}

-(void)registrationPressed
{
    [UIView animateWithDuration:1.0 animations:^
     {
         self.registrationButton.frame = CGRectMake(-130, 91, self.registrationButton.frame.size.width, self.registrationButton.frame.size.height);
         self.passwordConfrimLabel.frame = CGRectMake(10, self.passwordConfrimLabel.frame.origin.y, self.passwordConfrimLabel.frame.size.width, self.passwordConfrimLabel.frame.size.height);
         self.passwordConfrimTextField.frame = CGRectMake(85, self.passwordConfrimTextField.frame.origin.y, self.passwordConfrimTextField.frame.size.width, self.passwordConfrimTextField.frame.size.height);
         self.backToLoginButton.frame = CGRectMake(215, self.backToLoginButton.frame.origin.y, self.backToLoginButton.frame.size.width, self.backToLoginButton.frame.size.height);
         [self.loginButton setTitle:@"Register" forState:UIControlStateNormal];
     }];
    self.registrationMode = YES;
}
-(void)backToLoginButtonPressed
{
    [UIView animateWithDuration:1.0 animations:^
     {
         self.registrationButton.frame = CGRectMake(140, 91, self.registrationButton.frame.size.width, self.registrationButton.frame.size.height);
         self.passwordConfrimLabel.frame = CGRectMake(280, self.passwordConfrimLabel.frame.origin.y, self.passwordConfrimLabel.frame.size.width, self.passwordConfrimLabel.frame.size.height);
         self.passwordConfrimTextField.frame = CGRectMake(355, self.passwordConfrimTextField.frame.origin.y, self.passwordConfrimTextField.frame.size.width, self.passwordConfrimTextField.frame.size.height);
         self.backToLoginButton.frame = CGRectMake(455, self.backToLoginButton.frame.origin.y, self.backToLoginButton.frame.size.width, self.backToLoginButton.frame.size.height);
         [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
     }];
    self.registrationMode = NO;
}

@end
