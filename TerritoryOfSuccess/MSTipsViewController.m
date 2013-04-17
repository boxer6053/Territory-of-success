//
//  MSTipsViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 4/17/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSTipsViewController.h"

@interface MSTipsViewController ()

@end

@implementation MSTipsViewController
@synthesize tipsScrollView = _tipsScrollView;
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
  NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"lang = %@",language);
      [self.tipsScrollView setContentSize:CGSizeMake(320*9
                                                   , 416)];
    for(int i=0;i<=8;i++){
        UIImageView *view = [[UIImageView alloc] initWithFrame:(CGRectMake(i*320, 0, 320, 416))];
        
        NSString *imageName = [NSString stringWithFormat:@"%d",i+1];
        NSString *newName = [imageName stringByAppendingString:@"_"];
        NSString *newName1 = [newName stringByAppendingString:imageName];
        NSString *newName2 = [newName1 stringByAppendingString:@"_"];
        NSString *newName3 = [newName2 stringByAppendingString:language];
        NSString *newName4 = [newName3 stringByAppendingString:@".png"];
        NSLog(@"%@",newName4);
        //[view setBackgroundColor:[UIColor blackColor]];
        [view setImage:[UIImage imageNamed:newName4]];
        //[view setAlpha:0.7];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(17, 0, 5520, 411))];
//        imageView.image = [UIImage imageNamed:@"Gallery1.png"];
//        [view addSubview:imageView];
        [self.tipsScrollView addSubview:view];
      //  NSLog(@"%d",i);
        
    }
    
    self.tipsScrollView.pagingEnabled = YES;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTipsScrollView:nil];
      [super viewDidUnload];
}
- (IBAction)closeButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
