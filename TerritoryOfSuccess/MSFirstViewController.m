//
//  MSFirstViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/8/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSFirstViewController.h"
#import "MSNewsDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Tesseract.h"
#import "SVProgressHUD.h"

@interface MSFirstViewController ()

//розміри екрана
@property CGFloat screenWidth;
@property CGFloat screenHeight;

//розміри маркерної рамки
@property CGFloat frameMarkWidth;
@property CGFloat frameMarkHeight;

//timer for slideshow
@property NSTimer *slideShowTimer;
@property NSTimer *userTouchTimer;

@property (strong, nonatomic) MSAPI *api;

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation MSFirstViewController

@synthesize scrollView = _scrollView;
@synthesize newsScrollView = _newsScrollView;
@synthesize newsPageControl = _newsPageControl;
@synthesize newsView = _newsView;
@synthesize codeInputView = _codeInputView;
@synthesize codeTextField = _codeTextField;
@synthesize sendCodeButton = _sendCodeButton;
@synthesize photoButton = _photoButton;
@synthesize tintLabel = _tintLabel;

@synthesize tapRecognizer = _tapRecognizer;

@synthesize screenWidth = _screenWidth;
@synthesize screenHeight = _screenHeight;

@synthesize frameMarkWidth = _frameMarkWidth;
@synthesize frameMarkHeight = _frameMarkHeight;

@synthesize api = _api;
@synthesize receivedData = _receivedData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.codeTextField setDelegate:self];
    [self.codeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
        self.codeInputView.frame = CGRectMake(self.codeInputView.frame.origin.x, self.codeInputView.frame.origin.y - 35, self.codeInputView.frame.size.width, 144);
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y - 35, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        self.sendCodeButton.frame = CGRectMake(self.sendCodeButton.frame.origin.x, self.sendCodeButton.frame.origin.y - 10, self.sendCodeButton.frame.size.width, self.sendCodeButton.frame.size.height);
        self.photoButton.frame = CGRectMake(self.photoButton.frame.origin.x, self.photoButton.frame.origin.y - 10, self.photoButton.frame.size.width, self.photoButton.frame.size.height);
        self.tintLabel.frame = CGRectMake(self.tintLabel.frame.origin.x, self.tintLabel.frame.origin.y - 10, self.tintLabel.frame.size.width, self.tintLabel.frame.size.height);
        self.codeTextField.frame = CGRectMake(self.codeTextField.frame.origin.x, self.codeTextField.frame.origin.y - 10, self.codeTextField.frame.size.width, self.codeTextField.frame.size.height);
    }
    
    NSArray *contentArray = [NSArray arrayWithObjects:[UIColor grayColor], [UIColor orangeColor], [UIColor darkGrayColor], [UIColor purpleColor], nil];
    for (int i = 0; i <contentArray.count; i++)
    {
        CGRect frame;
        frame.origin.x = i * self.newsScrollView.frame.size.width;
        frame.origin.y = 0;
        frame.size = self.newsScrollView.frame.size;
        
        UIView *subView = [[UIView alloc]initWithFrame:frame];
        subView.backgroundColor = [contentArray objectAtIndex:i];
        [self.newsScrollView addSubview:subView];
        
        UIButton *subViewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.newsScrollView.frame.size.width, self.newsScrollView.frame.size.height)];
        [subViewButton addTarget:self
                   action:@selector(picturePressed)
         forControlEvents:UIControlEventTouchDown];
        //subViewButton.alpha = 0.0;
        [subView addSubview:subViewButton];
        
    }
    self.newsScrollView.contentSize = CGSizeMake(self.newsScrollView.frame.size.width * contentArray.count, self.newsScrollView.frame.size.height);
    [self.newsScrollView.layer setCornerRadius:5.0];
    self.newsPageControl.numberOfPages = contentArray.count;
    self.newsView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    self.codeInputView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    self.newsPageControl.pageIndicatorTintColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    self.newsPageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    [self.newsView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.newsView.layer setBorderWidth:1.0f];
    
    [self.codeInputView.layer setCornerRadius:7.0];
    [self.codeInputView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.codeInputView.layer setBorderWidth:1.0f];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    self.slideShowTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(slide) userInfo:nil repeats:YES];
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)slide
{
    if (self.newsPageControl.currentPage + 1 == self.newsPageControl.numberOfPages)
    {
        self.newsPageControl.currentPage = 0;
    }
    else
    {
        self.newsPageControl.currentPage++;
    }
    [self changeImageByPageController];
}

- (IBAction)changeNewsPage:(id)sender
{
    [self changeImageByPageController];
    [self.slideShowTimer invalidate];
    self.slideShowTimer = nil;
    self.userTouchTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(touchDelay) userInfo:nil repeats:NO];
}

- (void)changeImageByPageController
{
    CGRect frame;
    frame.origin.x = self.newsScrollView.frame.size.width * self.newsPageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.newsScrollView.frame.size;
    [self.newsScrollView scrollRectToVisible:frame animated:YES];
}

- (void)picturePressed
{
    [self performSegueWithIdentifier:@"newsDetailsFromHome" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newsDetailsFromHome"])
    {
        [segue.destinationViewController setContentOfArticle];
    }
}

-(void) touchDelay
{
    [self.userTouchTimer invalidate];
    self.userTouchTimer = nil;
    self.slideShowTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(slide) userInfo:nil repeats:YES];
}

#pragma mark ScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    float pageWidth = self.newsScrollView.frame.size.width;
    int page = floor((self.newsScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.newsPageControl.currentPage = page;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.slideShowTimer invalidate];
    self.slideShowTimer = nil;
    [self.userTouchTimer invalidate];
    self.userTouchTimer =nil;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.userTouchTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(touchDelay) userInfo:nil repeats:NO];
}

//зробити фото коду
- (void)takePhoto:(UIButton *)sender
{
    //перевірка наявності камири в девайсі
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //якщо є
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImageView *overlayImageView = [[UIImageView alloc] init];
        [overlayImageView setImage:[UIImage imageNamed:@"rect160*20.png"]];
                
        UIView *overlayAlphaTopView = [[UIView alloc] init];
        [overlayAlphaTopView setBackgroundColor:[UIColor blackColor]];
        [overlayAlphaTopView setAlpha:0.6];
        
        UIView *overlayAlphaBottomView = [[UIView alloc] init];
        [overlayAlphaBottomView setBackgroundColor:[UIColor blackColor]];
        
        UIView *overlayAlphaLeftView = [[UIView alloc] init];
        [overlayAlphaLeftView setBackgroundColor:[UIColor blackColor]];
        
        UIView *overlayAlphaRightView = [[UIView alloc] init];
        [overlayAlphaRightView setBackgroundColor:[UIColor blackColor]];
        
        //розмір екрана
        self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
        self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        //розмір рамки
        self.frameMarkWidth = 160;
        self.frameMarkHeight = 20;
        
        //запуск камери
        [self presentViewController:imagePickerController animated:YES completion:^(void){
            NSLog(@"Block");
            
            //додавання рамки і напівпрозорого фону
            [overlayImageView setFrame:CGRectMake((self.screenWidth - self.frameMarkWidth)/2, (self.screenHeight - 54 - self.frameMarkHeight)/2, self.frameMarkWidth, self.frameMarkHeight)];
            
            [overlayAlphaTopView setFrame:CGRectMake(0, 0, 320, (self.screenHeight - 54 - self.frameMarkHeight)/2)];
            
            [overlayAlphaBottomView setFrame:CGRectMake(0, (self.screenHeight - 54 + self.frameMarkHeight)/2, 320, self.screenHeight - (self.screenHeight - 54 + self.frameMarkHeight)/2 - 52)];
            
            [overlayAlphaLeftView setFrame:CGRectMake(0, (self.screenHeight - 54 - self.frameMarkHeight)/2, (self.screenWidth - self.frameMarkWidth)/2, self.frameMarkHeight)];
            
            [overlayAlphaRightView setFrame:CGRectMake(self.frameMarkWidth + (self.screenWidth - self.frameMarkWidth)/2, (self.screenHeight - 54 - self.frameMarkHeight)/2, 320 - self.frameMarkWidth + (self.screenWidth - self.frameMarkWidth)/2, self.frameMarkHeight)];
            
            [overlayAlphaTopView addSubview:overlayImageView];
            [overlayAlphaTopView addSubview:overlayAlphaBottomView];
            [overlayAlphaTopView addSubview:overlayAlphaLeftView];
            [overlayAlphaTopView addSubview:overlayAlphaRightView];
            
            //добавлення маркерної рамки на камеру
            imagePickerController.cameraOverlayView = overlayAlphaTopView;

        }];
    }
    else
    {
        //якщо нема
        UIAlertView *cameraNotAvailableMessage = [[UIAlertView alloc] initWithTitle:@"Camera error" message:@"Camera not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [cameraNotAvailableMessage show];
    }
}

//перевірка коду
- (IBAction)sendCode:(UIButton *)sender {
    
    NSLog(@"You click on send button!!!");
    
    self.api = [[MSAPI alloc] init];
    
    [self.api setDelegate:self];
    
//    NSString *codeStr = @"3957-8BF4-9C17-789B";
    NSString *codeStr = [self.codeTextField text];;
    
//    [self.api checkCode:[self.codeTextField text]];
    
    if (![codeStr isEqualToString:@""] && codeStr.length == 19) {
        [self.api checkCode:codeStr];
    }
}

- (void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
//    self.receivedData = [self.api receivedData];
    
    if (type == kCode) {
        NSLog(@"checking");
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSLog(@"Picture width: %f", img.size.width);
    NSLog(@"Picture hight: %f", img.size.height);
    
    UIImage *tempImage = [self cropImage:[info objectForKey:UIImagePickerControllerOriginalImage] withX:(self.screenWidth - self.frameMarkWidth)/2 withY:(self.screenHeight - 54 - self.frameMarkHeight)/2 withWidth:self.frameMarkWidth withHeight:self.frameMarkHeight];
    
    //------------------------------
    NSString *recognizedText = [NSString stringWithString:[self recognizeImage:tempImage]];
    
    NSLog(@"%@", recognizedText);
    
    recognizedText = [recognizedText stringByReplacingOccurrencesOfString:@" " withString:@""];
    recognizedText = [recognizedText stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //розкоментити код нище для додавання тире між цифрами
    //------------------------------------------------------------------
//    NSMutableArray *substringsArray = [[NSMutableArray alloc] init];
//    NSRange substringRange;
//    for (int i = 0; i < recognizedText.length; i++) {
//        if (i%4 == 0) {
//            NSLog(@"%d", i);
//            substringRange.location = i;
//            substringRange.length = 4;
//            [substringsArray addObject:[recognizedText substringWithRange:substringRange]];
//        }
//    }
//    
//    NSMutableString *combiningString = [NSMutableString stringWithFormat:@"%@", [substringsArray objectAtIndex:0]];
//    for (int i = 1; i < substringsArray.count; i++) {
//        [combiningString appendFormat:@"-%@", [substringsArray objectAtIndex:i]];
//    }
    //------------------------------------------------------------------
    
    [self.codeTextField setText:recognizedText];
        
    //------------------------------
    
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

static inline double radians (double degrees)
{
    return degrees * M_PI/180;
}

//обрізка фото
- (UIImage *)cropImage:(UIImage *)image withX:(CGFloat)x withY:(CGFloat)y withWidth:(CGFloat)cropWidth withHeight:(CGFloat)cropHeight
{
    CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGColorSpaceCreateDeviceRGB();
	
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	CGFloat width, height;
    
	width = [image size].width;
	height = [image size].height;
    
    NSLog(@"%f", image.size.width);
    NSLog(@"%f", image.size.height);
	
	CGContextRef bitmap;
	
	if (image.imageOrientation == UIImageOrientationUp | image.imageOrientation == UIImageOrientationDown) {
		bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	} else {
		bitmap = CGBitmapContextCreate(NULL, height, width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	}
	
	if (image.imageOrientation == UIImageOrientationLeft) {
		NSLog(@"image orientation left");
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -height);
		
	} else if (image.imageOrientation == UIImageOrientationRight) {
		NSLog(@"image orientation right");
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -width, 0);
		
	} else if (image.imageOrientation == UIImageOrientationUp) {
		NSLog(@"image orientation up");
		
	} else if (image.imageOrientation == UIImageOrientationDown) {
		NSLog(@"image orientation down");
		CGContextTranslateCTM (bitmap, width,height);
		CGContextRotateCTM (bitmap, radians(-180.));
		
	}
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
    
    CGFloat koefForWidth, koefForHeight;
    
    koefForWidth = 8.1;
    koefForHeight = 4.5;
    
    CGRect rect;
    rect.origin.x = x * koefForWidth;
    rect.origin.y = y * koefForHeight;
    rect.size.width = cropWidth * koefForWidth;
    rect.size.height = cropHeight * koefForHeight;
    
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    
	UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGImageRef resultRef = CGImageCreateWithImageInRect([result CGImage], rect);
    UIImage *cropedImage = [UIImage imageWithCGImage:resultRef];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
    
    NSLog(@"Croped image size: %f * %f", cropedImage.size.width, cropedImage.size.height);
    	
	return cropedImage;
}

//роспізнавання коду
- (NSString *)recognizeImage:(UIImage *)image
{    
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:image];
    [tesseract recognize];
    
    return [tesseract recognizedText];
}

- (void)didTapAnywhere: (UITapGestureRecognizer*) recognizer
{
    [self.codeTextField resignFirstResponder];
}

-(void)keyboardWillShow:(NSNotification *) note
{
    NSLog(@"Screen height: %f", [[UIScreen mainScreen] bounds].size.height);
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.scrollView setScrollEnabled:NO];
        [self.scrollView setContentSize:CGSizeMake(320.0, 568.0 + 40.0)];
        
        CGFloat tempy = 568.0 + 40.0;//self.scrollView.contentSize.height;
        CGFloat tempx = 320.0;//self.scrollView.contentSize.width;;
        CGRect zoomRect = CGRectMake((tempx/2), (tempy/2), tempy, tempx);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [self.scrollView scrollRectToVisible:zoomRect animated:NO];
        [UIView commitAnimations];
    }
    
    else
    {
        [self.scrollView setScrollEnabled:NO];
        [self.scrollView setContentSize:CGSizeMake(320.0, 480.0 + 55.0)];
        
        CGFloat tempy = 480.0 + 55.0;//self.scrollView.contentSize.height;
        CGFloat tempx = 320.0;//self.scrollView.contentSize.width;;
        CGRect zoomRect = CGRectMake((tempx/2), (tempy/2), tempy, tempx);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [self.scrollView scrollRectToVisible:zoomRect animated:NO];
        [UIView commitAnimations];
    }
        
    [self.view addGestureRecognizer:self.tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        CGRect zoomRect = CGRectMake(0, 0, 320, 568);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [self.scrollView scrollRectToVisible:zoomRect animated:NO];
        [UIView commitAnimations];
    }
    
    else
    {
        CGRect zoomRect = CGRectMake(0, 0, 320, 480);
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [self.scrollView scrollRectToVisible:zoomRect animated:NO];
        [UIView commitAnimations];
    }
    
    [self.scrollView setScrollEnabled:NO];
    
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    string = @"";
//    
//    if (textField.text.length >= 19)
//    {
//        NSString *str;
//        
//        return YES;
//    }
//    
//    return YES;
    
    if (textField.text.length == 4) {
        NSMutableString *tempMutStr = [NSMutableString stringWithString:textField.text];
        [tempMutStr appendString:@"-"];
        textField.text = [NSString stringWithString:tempMutStr];
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    return (newLength > 19) ? NO : YES;
}

@end
