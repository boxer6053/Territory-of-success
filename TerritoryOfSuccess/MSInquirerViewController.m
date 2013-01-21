//
//  MSInquirerViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSInquirerViewController.h"

@interface MSInquirerViewController ()

@end


@implementation MSInquirerViewController
@synthesize inquirerPic = _inquirerPic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    [self performSegueWithIdentifier:@"toInquirersTypes" sender:self];
    NSLog(@"Tapped image");
}
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
    }
    
    _inquirerPic.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognizer.delegate = self;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [_inquirerPic addGestureRecognizer:tapGestureRecognizer];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
