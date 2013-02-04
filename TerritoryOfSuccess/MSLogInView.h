//
//  MSLogInView.h
//  TerritoryOfSuccess
//
//  Created by Alex on 2/1/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSLogInView : UIView

@property (strong, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *cancelButton;

- (id)initWithScreenFrame:(CGRect)screenFrame LoginButtonText:(NSString *) loginText CancelButtonText:(NSString *)cancelText EmailLabelText:(NSString *)emailText PasswordLabelText:(NSString *)passwordText;
@end
