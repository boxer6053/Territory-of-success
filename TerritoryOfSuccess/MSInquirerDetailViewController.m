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
#import "MSStatisticViewController.h"


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
@synthesize optionForAnswer = _optionForAnswer;

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
    NSLog(@"Now Statistics");
    //[self.api getStatisticQuestionWithID:item];
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
     if (type == kSendAnswer)
     {
         NSString *answer = [dictionary valueForKey:@"status"];
         NSDictionary *message = [dictionary valueForKey:@"message"];
         NSString *goodAnswer = @"ok";
         NSString *alreadyAnswer = @"!-- already-voted --!";
         if([answer isEqualToString:goodAnswer]){
             NSLog(@"Everything's fine");
         }
         else{
             NSLog(@"Trouble");
         }
         if([answer isEqualToString:goodAnswer])
         {
             UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Успех" message:@"Ваш ответ засчитан!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
             [failmessage show];
             
         }
         if([[message valueForKey:@"text"]isEqualToString:alreadyAnswer])
         {
             UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Вы уже ответили!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
             [failmessage show];
         }

     }
}
-(void)buildView
{
    NSLog(@"comparing %d", self.count);
    if(self.count == 1)
    {
        
        //ВИД ОПРОСА "ОЦЕНИТЕ ТОВАР"
        UIImageView *imageForInquirer1 = [[UIImageView alloc] init];
        self.optionForAnswer = [[[self.arrayOfProducts objectAtIndex:0] valueForKey:@"id"] integerValue];
        [imageForInquirer1 setImageWithURL:[[self.arrayOfProducts objectAtIndex:0] valueForKey:@"image"]];
        [self.view addSubview:imageForInquirer1];
        UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [likeButton setBackgroundImage:[UIImage imageNamed:@"button_310_32-1.png"] forState:UIControlStateNormal];
        [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [likeButton setTitle:@"Like it!" forState:UIControlStateNormal];
        [likeButton addTarget:self action:@selector(likeAction)  forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:likeButton];
        UIButton *dislikeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [dislikeButton setBackgroundImage:[UIImage imageNamed:@"button_310_32-1.png"] forState:UIControlStateNormal];
        [dislikeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [dislikeButton setTitle:@"Hate it!" forState:UIControlStateNormal];
        [dislikeButton addTarget:self action:@selector(dislikeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dislikeButton];


        _inquirerTitle.text = @"Оцените товар";
        //фреймы для разных экранов (4 и 5 айфон)
        if ([[UIScreen mainScreen] bounds].size.height == 568)
            
        {
            [imageForInquirer1 setFrame:CGRectMake(60, 78, 200, 200)];
            likeButton.frame = CGRectMake(20, 330, 120, 32);
            dislikeButton.frame = CGRectMake(180, 330, 120, 32);
        }
        
        else{
            [imageForInquirer1 setFrame:CGRectMake(60, 48, 200, 200)];
            likeButton.frame = CGRectMake(20, 300, 120, 32);
            dislikeButton.frame = CGRectMake(180, 300, 120, 32);
        }
    }
    else{
        //ВИД ОПРОСА КАКОЙ ТОВАР ЛУЧШЕ
        _inquirerTitle.text = @"Какой товар лучше";
        UITapGestureRecognizer *selectProduct = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAProduct:)];
        [selectProduct setNumberOfTapsRequired:1];
        UIButton *image1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *image2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *image3 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *image4 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *image5 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *image6 = [UIButton buttonWithType:UIButtonTypeCustom];
        
                //фреймы для разных экранов (4 и 5 айфон)
        if ([[UIScreen mainScreen] bounds].size.height == 568)
        {
            [image1 setFrame:CGRectMake(20, 78, 100, 100)];
            [image2 setFrame:CGRectMake(200, 78, 100, 100)];
            [image3 setFrame:CGRectMake(20, 188, 100, 100)];
            [image4 setFrame:CGRectMake(200, 188, 100, 100)];
            [image5 setFrame:CGRectMake(20, 298, 100, 100)];
            [image6 setFrame:CGRectMake(200, 298, 100, 100)];

        }
        else
        {
         
            [image1 setFrame:CGRectMake(20, 36, 100, 100)];
            [image2 setFrame:CGRectMake(200, 36, 100, 100)];
            [image3 setFrame:CGRectMake(20, 146, 100, 100)];
            [image4 setFrame:CGRectMake(200, 146, 100, 100)];
            [image5 setFrame:CGRectMake(20, 256, 100, 100)];
            [image6 setFrame:CGRectMake(200, 256, 100, 100)];
        }
        NSArray *arrayOfViews = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6, nil];
        for(int i=0;i<6;i++)
        {
            [[arrayOfViews objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"bag.png"] forState:UIControlStateNormal];
            [self.view addSubview:[arrayOfViews objectAtIndex:i]];
        }
        for (int i = 0;i<self.arrayOfProducts.count;i++)
        {
            NSURL *imageUrl = [NSURL URLWithString:[[self.arrayOfProducts objectAtIndex:i] valueForKey:@"image" ]];
            [[arrayOfViews objectAtIndex:i] setTag:[[[self.arrayOfProducts objectAtIndex:i] valueForKey:@"id" ] integerValue]];
            [[arrayOfViews objectAtIndex:i] addTarget:self action:@selector(chooseAProduct:)forControlEvents:UIControlEventTouchUpInside];
            [[arrayOfViews objectAtIndex:i]setBackgroundImageWithURL:imageUrl forState:UIControlStateNormal];
        }
        for (int i = self.arrayOfProducts.count;i<arrayOfViews.count;i++)
        {
            [[arrayOfViews objectAtIndex:i] setHidden:YES];
            
        }

    }
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString: @"toStat"]){
        MSStatisticViewController *controller = (MSStatisticViewController *)segue.destinationViewController;
        controller.questionID = [self.itemID integerValue];
        
        
        
        
    }
}
-(void)chooseAProduct:(id)sender
{
    NSInteger *questionID = [self.itemID integerValue];
    NSInteger *optionID = [sender tag];
    NSLog(@"TAP %d", [sender tag]);
    [self.api answerToQuestionWithID:questionID andOptionID:optionID];
         
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];

        }
}
-(void)likeAction{
      NSInteger *questionID = [self.itemID integerValue];
    NSLog(@"pressed option %d", self.optionForAnswer);
    [self.api answerToQuestionWithID:questionID andOptionID:self.optionForAnswer];
    //[self.navigationController popViewControllerAnimated:YES];
    NSLog(@"LIKE");
}
-(void)dislikeAction{
    NSInteger *questionID = [self.itemID integerValue];
    [self.api answerToQuestionWithID:questionID andOptionID:0];
  //   [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"DISLIKE");
}
@end
