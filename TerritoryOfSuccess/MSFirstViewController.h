//
//  MSFirstViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/8/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"
#import "JSONParserForDataEntenties.h"

@interface MSFirstViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate, WsCompleteDelegate>
{
    UIImagePickerController *imagePickerController;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *newsScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *newsPageControl;
@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *codeInputView;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UILabel *tintLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSMutableData *receivedData;


- (IBAction)changeNewsPage:(id)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)sendCode:(UIButton *)sender;
- (UIImage *)cropImage:(UIImage *)image withX:(CGFloat)x withY:(CGFloat)y withWidth:(CGFloat)width withHeight:(CGFloat)height;
- (NSString *)recognizeImage:(UIImage *)image;

@end
