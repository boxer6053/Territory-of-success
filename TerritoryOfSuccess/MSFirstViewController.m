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

@interface MSFirstViewController ()

@end

@implementation MSFirstViewController

@synthesize newsScrollView = _newsScrollView;
@synthesize newsPageControl = _newsPageControl;
@synthesize newsView = _newsView;
@synthesize codeInputView = _codeInputView;
@synthesize codeTextField = _codeTextField;
@synthesize sendCodeButton = _sendCodeButton;
@synthesize photoButton = _photoButton;
@synthesize tintLabel = _tintLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        
        CGRect textFrame;
        textFrame.origin.x = 0;
        textFrame.origin.y = 120;
        textFrame.size = CGSizeMake(self.newsScrollView.frame.size.width, 70);
        
        UIView *textView = [[UIView alloc]initWithFrame:textFrame];
        textView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        [subView addSubview:textView];
        
        UILabel *descritionText = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, textView.frame.size.width - 10, textView.frame.size.height)];
        descritionText.textColor = [UIColor whiteColor];
        descritionText.backgroundColor = [UIColor clearColor];
        descritionText.numberOfLines = 3;
        descritionText.font = [UIFont systemFontOfSize:14];
        descritionText.text = @"Hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world";
        [textView addSubview:descritionText];
        
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recognize:(id)sender {
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:[UIImage imageNamed:@"numbers.png"]];
    [tesseract recognize];
    
    NSLog(@"%@", [tesseract recognizedText]);
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
@end
