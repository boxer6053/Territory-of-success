//
//  MSStatisticViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/19/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSStatisticViewController.h"

@interface MSStatisticViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;

@end

@implementation MSStatisticViewController
@synthesize questionID = _questionID;
@synthesize interfaceIndex = _interfaceIndex;
@synthesize receivedData = _receivedData;
@synthesize receivedArray = _receivedArray;
@synthesize api = _api;

- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }

    NSLog(@"id question %d", self.questionID);
    NSLog(@"interfaceIndex %d", self.interfaceIndex);
    [self.api getStatisticQuestionWithID:self.questionID];
   
	// Do any additional setup after loading the view.
}
-(void)buildView{
    if(self.interfaceIndex ==1){
        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 120, 20)];
        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 160, 20)];
        UILabel *answer1 = [[UILabel alloc]initWithFrame:CGRectMake(180, 60, 120, 20)];
        UILabel *answer2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 110, 120, 20)];
        [answer1 setText:@"0"];
        [answer1 setBackgroundColor:[UIColor clearColor]];
        [answer2 setBackgroundColor:[UIColor clearColor]];
        [answer2 setText:@"0"];
        [self.view addSubview:answer1];
        [self.view addSubview:answer2];
        NSArray *arrayOfTitles = [[NSArray alloc] initWithObjects:firstLabel, secondLabel, nil];
        for(int i=0;i<arrayOfTitles.count;i++){
            UILabel *currentTitle = [arrayOfTitles objectAtIndex:i];
            [currentTitle setBackgroundColor:[UIColor clearColor]];
            [currentTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        }
        NSArray *arrayOfAnswers = [[NSArray alloc] initWithObjects:answer1,answer2, nil];
        for(int i=0;i<self.receivedArray.count;i++)
        {
            UILabel *currentAnswerLabel = [arrayOfAnswers objectAtIndex:i];
            NSString *value = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
            
            
            [currentAnswerLabel setText:[value stringByAppendingString:@"  Голос(ов)"]];
            [currentAnswerLabel setBackgroundColor:[UIColor clearColor]];
            [currentAnswerLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
            // currentAnswerLabel.text = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
            [self.view addSubview:currentAnswerLabel];
        }
        [self.view addSubview:firstLabel];
        [self.view addSubview:secondLabel];
        [firstLabel setText:@"Голосов ЗА"];
        [secondLabel setText:@"Голосов ПРОТИВ"];
    }
    else{
    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 120, 20)];
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 120, 20)];
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 120, 20)];
    UILabel *fourthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 120, 20)];
    UILabel *fifthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 120, 20)];
    UILabel *sixthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 120, 20)];
    NSArray *arrayOfTitles = [[NSArray alloc] initWithObjects:firstLabel,secondLabel,thirdLabel,fourthLabel,fifthLabel,sixthLabel, nil];
    UILabel *answer1 = [[UILabel alloc]initWithFrame:CGRectMake(180, 60, 120, 20)];
    UILabel *answer2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 110, 120, 20)];
    UILabel *answer3 = [[UILabel alloc]initWithFrame:CGRectMake(180, 160, 120, 20)];
    UILabel *answer4 = [[UILabel alloc]initWithFrame:CGRectMake(180, 210, 120, 20)];
    UILabel *answer5 = [[UILabel alloc]initWithFrame:CGRectMake(180, 260, 120, 20)];
    UILabel *answer6 = [[UILabel alloc]initWithFrame:CGRectMake(180, 310, 120, 20)];
    
    NSArray *arrayOfAnswers = [[NSArray alloc] initWithObjects:answer1, answer2, answer3, answer4,answer5,answer6, nil];
    for(int i=0;i<arrayOfTitles.count;i++){
        UILabel *currentLabel = [arrayOfTitles objectAtIndex:i];
        NSString *title = @"Товар  ";
        NSString *title1 = [title stringByAppendingString:[NSString stringWithFormat:@"%i",i+1]];
        [currentLabel setText:title1];
        [currentLabel setFont:[UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:17]];
        [currentLabel setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:currentLabel];
    }
        for(int i=0;i<self.receivedArray.count;i++){
            UILabel *currentAnswerLabel = [arrayOfAnswers objectAtIndex:i];
            NSString *value = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
           

            [currentAnswerLabel setText:[value stringByAppendingString:@"  Голос(ов)"]];
            [currentAnswerLabel setFont:[UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:17]];
            [currentAnswerLabel setBackgroundColor:[UIColor clearColor]];
           // currentAnswerLabel.text = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
            [self.view addSubview:currentAnswerLabel];
        }
    for(int i=self.receivedArray.count;i<arrayOfTitles.count;i++)
    {
        [[arrayOfTitles objectAtIndex:i]  setHidden:YES];
        [[arrayOfAnswers objectAtIndex:i] setHidden:YES];
    }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if(type == kQuestStat){
    self.receivedArray = [dictionary valueForKey:@"options"];
        [self buildView];
    }
    NSLog(@"COUNT %d", self.receivedArray.count);

    
}

@end
