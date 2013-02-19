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
    NSLog(@"id question %d", self.questionID);
    [self.api getStatisticQuestionWithID:self.questionID];
   
	// Do any additional setup after loading the view.
}
-(void)buildView{
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
        [self.view addSubview:currentLabel];
    }
        for(int i=0;i<self.receivedArray.count;i++){
            UILabel *currentAnswerLabel = [arrayOfAnswers objectAtIndex:i];
            NSString *value = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
           

            [currentAnswerLabel setText:[value stringByAppendingString:@"  Голосов"]];
           // currentAnswerLabel.text = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
            [self.view addSubview:currentAnswerLabel];
        }
    for(int i=self.receivedArray.count;i<arrayOfTitles.count;i++)
    {
        [[arrayOfTitles objectAtIndex:i]  setHidden:YES];
        [[arrayOfAnswers objectAtIndex:i] setHidden:YES];
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
