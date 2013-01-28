//
//  MSInquirerDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSInquirerDetailViewController.h"

@interface MSInquirerDetailViewController ()

@end

@implementation MSInquirerDetailViewController
@synthesize inquirerType = _inquirerType;
@synthesize inquirerTitle = _inquirerTitle;


- (void)viewDidLoad
{
      NSLog(@"adfdsfsdf%d", _inquirerType);
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
  
       if(_inquirerType ==1)
    {
        _inquirerTitle.text = @"Оцените товар";
        UIImageView *imageForInquirer1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 78, 200, 200)];
        [imageForInquirer1 setImage:[UIImage imageNamed:@"appllee.png"]];
        [self.view addSubview:imageForInquirer1];
    }
    else{
        _inquirerTitle.text = @"Какой товар лучше";
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
           UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 78, 100, 100)];
             UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 78, 100, 100)];
             UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 188, 100, 100)];
             UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 188, 100, 100)];
             UIImageView *image5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 298, 100, 100)];
             UIImageView *image6 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 298, 100, 100)];
            
            NSArray *arrayOfViews = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6, nil];
            for(int i=0;i<6;i++)
            {
                [[arrayOfViews objectAtIndex:i] setImage:[UIImage imageNamed:@"appllee2.png"]];
                [self.view addSubview:[arrayOfViews objectAtIndex:i]];
                
            }
            
            
        }
        else
        {
           // [_inquirerTitle setHidden:YES];
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 36, 100, 100)];
            UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 36, 100, 100)];
            UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 146, 100, 100)];
            UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 146, 100, 100)];
            UIImageView *image5 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 256, 100, 100)];
            UIImageView *image6 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 256, 100, 100)];
            
            NSArray *arrayOfViews = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6, nil];
            for(int i=0;i<6;i++)
            {
                [[arrayOfViews objectAtIndex:i] setImage:[UIImage imageNamed:@"appllee2.png"]];
                [self.view addSubview:[arrayOfViews objectAtIndex:i]];
                
            }
        }
    
        
        
    }
    [super viewDidLoad];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
