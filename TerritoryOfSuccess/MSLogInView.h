//
//  MSLogInView.h
//  TerritoryOfSuccess
//
//  Created by Alex on 2/1/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol dismissView

@required
-(void)dismissPopView;

@end

@interface MSLogInView : UIView

@property (strong, nonatomic) id <dismissView> delegate;
@property (nonatomic) BOOL registrationMode;

@property (strong, nonatomic) UILabel *emailLabel;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UILabel *passwordConfrimLabel;
@property (strong, nonatomic) UITextField *passwordConfrimTextField;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *registrationButton;
@property (strong, nonatomic) UIButton *backToLoginButton;

- (id)init;
- (void) attachPopUpAnimation;

@end
