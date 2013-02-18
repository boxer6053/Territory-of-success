//
//  MSInquirerDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSInquirerDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>


@interface MSInquirerDetailViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;

@end

@implementation MSInquirerDetailViewController
@synthesize inquirerType = _inquirerType;
@synthesize inquirerTitle = _inquirerTitle;
@synthesize itemID = _itemID;
@synthesize arrayOfProducts = _arrayOfProducts;
@synthesize receivedData = _receivedData;
@synthesize api = _api;
@synthesize count = _count;

- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (void)viewDidLoad
{
    NSLog(@"itemID %ld", (long)self.itemID);
    
    NSLog(@"adfdsfsdf%d", _inquirerType);
    int item = [self.itemID integerValue];
    NSLog(@"gonnatakeID %d", item);
    [self.api getDetailQuestionWithID:item];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
    
    
    [super viewDidLoad];
    
    
    
	// Do any additional setup after loading the view.
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
    if (type == kQuestDetail)
    {
        self.arrayOfProducts = [dictionary valueForKey:@"options"];
        self.count = self.arrayOfProducts.count;
        NSLog(@"COUNT %d", self.count);
        [self buildView];
    }
    
}
-(void)buildView
{
    NSLog(@"comparing %d", self.count);
    if(self.count == 1)
    {
        _inquirerTitle.text = @"Оцените товар";
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        { UIImageView *imageForInquirer1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 78, 200, 200)];
            [imageForInquirer1 setImageWithURL:[[self.arrayOfProducts objectAtIndex:0] valueForKey:@"image"]];
            [self.view addSubview:imageForInquirer1];
            UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            likeButton.frame = CGRectMake(20, 330, 120, 32);
            
            [likeButton setBackgroundImage:[UIImage imageNamed:@"button_310_32-1.png"] forState:UIControlStateNormal];
            [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [likeButton setTitle:@"Like it!" forState:UIControlStateNormal];
            [likeButton addTarget:self action:@selector(likeAction)  forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:likeButton];
            UIButton *dislikeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            dislikeButton.frame = CGRectMake(180, 330, 120, 32);
            [dislikeButton setBackgroundImage:[UIImage imageNamed:@"button_310_32-1.png"] forState:UIControlStateNormal];
            [dislikeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [dislikeButton setTitle:@"Hate it!" forState:UIControlStateNormal];
            [dislikeButton addTarget:self action:@selector(dislikeAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:dislikeButton];
            
            
        }
        
        else{
            UIImageView *imageForInquirer1 = [[UIImageView alloc] initWithFrame:CGRectMake(60, 48, 200, 200)];
            [imageForInquirer1 setImageWithURL:[[self.arrayOfProducts objectAtIndex:0] valueForKey:@"image"]];
            [self.view addSubview:imageForInquirer1];
            UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            likeButton.frame = CGRectMake(20, 300, 120, 32);
            
            [likeButton setBackgroundImage:[UIImage imageNamed:@"button_310_32-1.png"] forState:UIControlStateNormal];
            [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [likeButton setTitle:@"Like it!" forState:UIControlStateNormal];
            [likeButton addTarget:self action:@selector(likeAction)  forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:likeButton];
            UIButton *dislikeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            dislikeButton.frame = CGRectMake(180, 300, 120, 32);
            [dislikeButton setBackgroundImage:[UIImage imageNamed:@"button_310_32-1.png"] forState:UIControlStateNormal];
            [dislikeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [dislikeButton setTitle:@"Hate it!" forState:UIControlStateNormal];
            [dislikeButton addTarget:self action:@selector(dislikeAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:dislikeButton];
            
        }
    }
    else{
        _inquirerTitle.text = @"Какой товар лучше";
        UITapGestureRecognizer *selectProduct = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAProduct:)];
        [selectProduct setNumberOfTapsRequired:1];
        
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            UIButton *image1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image1 setFrame:CGRectMake(20, 78, 100, 100)];
            UIButton *image2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image2 setFrame:CGRectMake(200, 78, 100, 100)];
            UIButton *image3 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image3 setFrame:CGRectMake(20, 188, 100, 100)];
            UIButton *image4 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image4 setFrame:CGRectMake(200, 188, 100, 100)];
            UIButton *image5 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image5 setFrame:CGRectMake(20, 298, 100, 100)];
            UIButton *image6 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image6 setFrame:CGRectMake(200, 298, 100, 100)];
            
            NSArray *arrayOfViews = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6, nil];
            for(int i=0;i<6;i++)
            {
                [[arrayOfViews objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"bag.png"] forState:UIControlStateNormal];
                [self.view addSubview:[arrayOfViews objectAtIndex:i]];
            }
            for (int i = 0;i<self.arrayOfProducts.count;i++)
            {
                NSURL *imageUrl = [NSURL URLWithString:[[self.arrayOfProducts objectAtIndex:i] valueForKey:@"image" ]];
                [[arrayOfViews objectAtIndex:i]setBackgroundImageWithURL:imageUrl forState:UIControlStateNormal];
            }
        }
        else
        {
            UIButton *image1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image1 setFrame:CGRectMake(20, 36, 100, 100)];
            UIButton *image2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image2 setFrame:CGRectMake(200, 36, 100, 100)];
            UIButton *image3 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image3 setFrame:CGRectMake(20, 146, 100, 100)];
            UIButton *image4 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image4 setFrame:CGRectMake(200, 146, 100, 100)];
            UIButton *image5 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image5 setFrame:CGRectMake(20, 256, 100, 100)];
            UIButton *image6 = [UIButton buttonWithType:UIButtonTypeCustom];
            [image6 setFrame:CGRectMake(200, 256, 100, 100)];
            
            NSArray *arrayOfViews = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6, nil];
            for(int i=0;i<6;i++)
            {
                [[arrayOfViews objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"bag"] forState:UIControlStateNormal];
                [[arrayOfViews objectAtIndex:i] addTarget:self action:@selector(chooseAProduct) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:[arrayOfViews objectAtIndex:i]];
            }
            
            for (int i = 0;i<self.arrayOfProducts.count;i++)
            {
                
                NSURL *imageUrl = [NSURL URLWithString:[[self.arrayOfProducts objectAtIndex:i] valueForKey:@"image" ]];
                [[arrayOfViews objectAtIndex:i]setBackgroundImageWithURL:imageUrl forState:UIControlStateNormal];
                
                
            }
        }
    }
    //    int item = [self.itemID integerValue];
    //    NSLog(@"Now Statistics");
    //    [self.api getStatisticQuestionWithID:item];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)chooseAProduct
{
    NSLog(@"TAP");
}
-(void)likeAction{
    NSLog(@"LIKE");
}
-(void)dislikeAction{
    NSLog(@"DISLIKE");
}
@end
