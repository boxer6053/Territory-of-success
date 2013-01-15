//
//  MSFirstViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/8/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSFirstViewController.h"
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

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_image.png"]]];
    NSLog(@"%f",self.newsScrollView.frame.size.height);
    
    NSArray *contentArray = [NSArray arrayWithObjects:[UIColor grayColor], [UIColor orangeColor], [UIColor darkGrayColor], [UIColor purpleColor], nil];
    for (int i = 0; i <contentArray.count; i++)
    {
        CGRect frame;
        frame.origin.x = i * self.newsScrollView.frame.size.width;
        frame.origin.y = 0;
        frame.size = self.newsScrollView.frame.size;
        
        NSLog(@"%f",self.newsScrollView.frame.size.height);
        NSLog(@"%f",self.newsView.frame.size.height);
        NSLog(@"%f",self.view.frame.size.height);
        
        UIView *subView = [[UIView alloc]initWithFrame:frame];
        subView.backgroundColor = [contentArray objectAtIndex:i];
        [self.newsScrollView addSubview:subView];
        
    }
    self.newsScrollView.contentSize = CGSizeMake(self.newsScrollView.frame.size.width * contentArray.count, self.newsScrollView.frame.size.height);
    [self.newsScrollView.layer setCornerRadius:5.0];
    self.newsPageControl.numberOfPages = contentArray.count;
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
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeNewsPage:(id)sender
{
    CGRect frame;
    frame.origin.x = self.newsScrollView.frame.size.width * self.newsPageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.newsScrollView.frame.size;
    [self.newsScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark ScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    float pageWidth = self.newsScrollView.frame.size.width;
    int page = floor((self.newsScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.newsPageControl.currentPage = page;
}

//зробити фото коду
- (void)takePhoto:(UIButton *)sender
{
    //перевірка наявності камире в девайсі
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //якщо є
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImageView *overlayImageView = [[UIImageView alloc] init];
        [overlayImageView setImage:[UIImage imageNamed:@"rect200*50.png"]];
        
        
        self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
        self.screenHeight = [[UIScreen mainScreen] bounds].size.height;
        
        self.frameMarkWidth = 160;
        self.frameMarkHeight = 20;
        
        //запуск камери
        [self presentViewController:imagePickerController animated:YES completion:^(void){
            NSLog(@"Block");
            
            if (self.screenHeight == 480) {
                [overlayImageView setFrame:CGRectMake((self.screenWidth - self.frameMarkWidth)/2, (self.screenHeight - 54 - self.frameMarkHeight)/2, self.frameMarkWidth, self.frameMarkHeight)];
                
                //добавлення маркерної рамки на камеру
                imagePickerController.cameraOverlayView = overlayImageView;
            }
        }];
    }
    else
    {
        //якщо нема
        UIAlertView *cameraNotAvailableMessage = [[UIAlertView alloc] initWithTitle:@"Camera error" message:@"Camera not available" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [cameraNotAvailableMessage show];
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
    
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView setContentSize:CGSizeMake(320.0, 568.0 + 40.0)];
    
    CGFloat tempy = 568.0 + 40.0;//self.scrollView.contentSize.height;
    CGFloat tempx = 320.0;//self.scrollView.contentSize.width;;
    CGRect zoomRect = CGRectMake((tempx/2), (tempy/2), tempy, tempx);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [self.scrollView scrollRectToVisible:zoomRect animated:NO];
    [UIView commitAnimations];
    
    [self.view addGestureRecognizer:self.tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    CGRect zoomRect = CGRectMake(0, 0, 320, 568);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [self.scrollView scrollRectToVisible:zoomRect animated:NO];
    [UIView commitAnimations];
    
    [self.scrollView setScrollEnabled:NO];
    
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

@end
