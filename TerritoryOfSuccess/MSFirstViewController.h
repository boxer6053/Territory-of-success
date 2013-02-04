//
//  MSFirstViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/8/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"
#import "MSDialogView.h"

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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *profileBarButton;
@property (strong, nonatomic) NSMutableData *receivedData;
//@property (strong, nonatomic) UIView *dialogView;
@property (strong, nonatomic) UIImageView *productImageView;
@property (strong, nonatomic) MSDialogView *dialogView;
@property (strong, nonatomic) UIImageView *mainFishkaImageView;
@property (strong, nonatomic) UILabel *mainFishkaLabel;
@property (strong, nonatomic) UIView *backAlphaView;


- (IBAction)changeNewsPage:(id)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)sendCode:(UIButton *)sender;
- (IBAction)profileButtonPressed:(id)sender;
- (UIImage *)cropImage:(UIImage *)image withX:(CGFloat)x withY:(CGFloat)y withWidth:(CGFloat)width withHeight:(CGFloat)height;
- (NSString *)recognizeImage:(UIImage *)image;
- (void)showDialogView;
- (void)closeDialogView;
- (NSString *)filtringCode:(NSString *)code;

@end
