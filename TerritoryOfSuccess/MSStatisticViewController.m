//
//  MSStatisticViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/19/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSStatisticViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "MSStatisticCell.h"
@interface MSStatisticViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;
@property  (nonatomic) CGFloat totalVotes;

@end

@implementation MSStatisticViewController
@synthesize questionID = _questionID;
@synthesize interfaceIndex = _interfaceIndex;
@synthesize receivedData = _receivedData;
@synthesize receivedArray = _receivedArray;
@synthesize api = _api;
@synthesize tableView = _tableView;

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
    self.tableView.layer.cornerRadius = 10.0f;
    self.tableView.layer.borderWidth = 1.0f;
    [self.tableView.layer setBorderColor:[[UIColor blackColor] CGColor]];
 [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadingInquirerStatKey",nil)];
   
    NSLog(@"id question %d", self.questionID);
    NSLog(@"interfaceIndex %d", self.interfaceIndex);
    [self.api getStatisticQuestionWithID:self.questionID];
    

	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.interfaceIndex ==1){
        return 2;
    }
    else{
        return self.receivedArray.count;
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSStatisticCell *cell;
    static NSString* cellIdentifier = @"statisticCellId";
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[MSStatisticCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    if(self.interfaceIndex ==1){
        NSLog(@"TTOTAL %f",self.totalVotes);
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 100)];
        NSString *value = [[self.receivedArray objectAtIndex:indexPath.row] valueForKey:@"cnt"];
        NSLog(@"value %f = ", [value floatValue]);
        CGFloat index = [value floatValue]/self.totalVotes;
        NSLog(@"index =%f",index);
        NSInteger heigh = (indexPath.row+1)*50+10;
        NSLog(@"height = %d", heigh);
        NSInteger percents = index*100;
      [cell.rateView setFrame:CGRectMake(65, 15, 1+index*110, 20)];
        NSString *answer = [NSString stringWithFormat:@"%d",percents];
        cell.answerLabel.text = [answer stringByAppendingString:@"%"];
        cell.rateView.image = [UIImage imageNamed:@"terrRate.png"];


        if(indexPath.row == 0){
            cell.titleLabel.text = @"Против";
                   }
        else{
            cell.titleLabel.text = @"За";
                    }
    }
    else{
        CGFloat height = self.receivedArray.count;
        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, height*50)];

        NSString *number = [NSString stringWithFormat:@"%d",indexPath.row+1];
        cell.titleLabel.text = [@"Товар " stringByAppendingString:number];
        NSString *value = [[self.receivedArray objectAtIndex:indexPath.row] valueForKey:@"cnt"];
        NSLog(@"value %f = ", [value floatValue]);
        CGFloat index = [value floatValue]/self.totalVotes;
        NSLog(@"index =%f",index);
        NSInteger heigh = (indexPath.row+1)*50+10;
        NSLog(@"height = %d", heigh);
        NSInteger percents = index*100;
        [cell.rateView setFrame:CGRectMake(65, 15,1+index*110, 20)];
        cell.rateView.image = [UIImage imageNamed:@"terrRate.png"];
        NSString *answer = [NSString stringWithFormat:@"%d",percents];
        cell.answerLabel.text = [answer stringByAppendingString:@"%"];

        
    }
    return cell;

}
//-(void)buildView{
//    UIImageView * roundedView = [[UIImageView alloc] init];
//    [roundedView setBackgroundColor:[UIColor whiteColor]];
//    // Get the Layer of any view
//    
//    [[roundedView layer] setMasksToBounds:YES];
//    [[roundedView layer] setCornerRadius:10.0];
//    
//    // You can even add a border
//    [[roundedView layer] setBorderWidth:1.0];
//    [[roundedView layer]setBorderColor:[[UIColor blackColor] CGColor]];
//    if(self.interfaceIndex ==1){
//        [roundedView setFrame:CGRectMake(5, 55, 310, 85)];
//        [self.view addSubview:roundedView];
//        
//        
//        UIImageView *rate1 = [[UIImageView alloc] init];
//        [rate1 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        UIImageView *rate2 = [[UIImageView alloc] init];
//        [rate2 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        
//        
//        NSArray *arrayOfRates = [[NSArray alloc] initWithObjects:rate1, rate2, nil];
//        
//        UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 110, 20)];
//        UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 110, 20)];
//        UILabel *answer1 = [[UILabel alloc]initWithFrame:CGRectMake(250, 60, 50, 20)];
//        UILabel *answer2 = [[UILabel alloc]initWithFrame:CGRectMake(250, 110, 50, 20)];
//        [answer1 setText:@"0"];
//        [answer1 setBackgroundColor:[UIColor clearColor]];
//        [answer2 setBackgroundColor:[UIColor clearColor]];
//        [answer2 setText:@"0"];
//        [self.view addSubview:answer1];
//        [self.view addSubview:answer2];
//        NSArray *arrayOfTitles = [[NSArray alloc] initWithObjects:firstLabel, secondLabel, nil];
//        for(int i=0;i<arrayOfTitles.count;i++){
//            UILabel *currentTitle = [arrayOfTitles objectAtIndex:i];
//            [currentTitle setBackgroundColor:[UIColor clearColor]];
//            [currentTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
//        }
//        NSArray *arrayOfAnswers = [[NSArray alloc] initWithObjects:answer1,answer2, nil];
//        for(int i=0;i<self.receivedArray.count;i++){
//            NSString *votesForProduct = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
//            //  NSLog(@" gg %d", [votesForProduct integerValue  ])   ;
//            self.totalVotes = self.totalVotes + [votesForProduct integerValue] ;
//        }
//        for(int i=0;i<self.receivedArray.count;i++)
//        {
//            NSLog(@"total =%f", self.totalVotes);
//          
//            UILabel *currentAnswerLabel = [arrayOfAnswers objectAtIndex:i];
//            NSString *value = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
//            
//            NSLog(@"value %f = ", [value floatValue]);
//            CGFloat index = [value floatValue]/self.totalVotes;
//            NSLog(@"index =%f",index);
//            NSInteger heigh = (i+1)*50+10;
//            NSLog(@"height = %d", heigh);
//            CGFloat integer = 1.0/2.0;
//            NSInteger percents = index*100;
//            NSLog(@"%d",percents);
//            
//            
//            NSLog(@"testt %f", integer);
//            [[arrayOfRates objectAtIndex:i] setFrame:CGRectMake(125, (i+1)*50+10, 1+index*110, 20)];
//            NSString *answer = [NSString stringWithFormat:@"%d", percents];
//
//            [currentAnswerLabel setText:[answer stringByAppendingString:@" %"]];
//            [currentAnswerLabel setBackgroundColor:[UIColor clearColor]];
//            [currentAnswerLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
//            // currentAnswerLabel.text = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
//            [self.view addSubview:[arrayOfRates objectAtIndex:i]];
//            [self.view addSubview:currentAnswerLabel];
//        }
//        [self.view addSubview:firstLabel];
//        [self.view addSubview:secondLabel];
//        [firstLabel setText:@"Голосов против"];
//        [secondLabel setText:@"Голосов за"];
//    }
//    else{
//        NSLog(@"COUNTT %d",self.receivedArray.count);
//        [roundedView setFrame:CGRectMake(5, 55, 310, (self.receivedArray.count)*45+10)];
//        [self.view addSubview:roundedView];
//    UILabel *firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 60, 20)];
//    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 110, 60, 20)];
//    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 60, 20)];
//    UILabel *fourthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 60, 20)];
//    UILabel *fifthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 60, 20)];
//    UILabel *sixthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 60, 20)];
//    NSArray *arrayOfTitles = [[NSArray alloc] initWithObjects:firstLabel,secondLabel,thirdLabel,fourthLabel,fifthLabel,sixthLabel, nil];
//    UILabel *answer1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 60, 100, 20)];
//    UILabel *answer2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 110, 100, 20)];
//    UILabel *answer3 = [[UILabel alloc]initWithFrame:CGRectMake(200, 160, 100, 20)];
//    UILabel *answer4 = [[UILabel alloc]initWithFrame:CGRectMake(200, 210, 100, 20)];
//    UILabel *answer5 = [[UILabel alloc]initWithFrame:CGRectMake(200, 260, 100, 20)];
//    UILabel *answer6 = [[UILabel alloc]initWithFrame:CGRectMake(200, 310, 100, 20)];
//        
//
//        UIImageView *rate1 = [[UIImageView alloc] init];
//        [rate1 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        UIImageView *rate2 = [[UIImageView alloc] init];
//        [rate2 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        UIImageView *rate3 = [[UIImageView alloc] init];
//        [rate3 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        UIImageView *rate4 = [[UIImageView alloc] init];
//        [rate4 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        UIImageView *rate5 = [[UIImageView alloc] init];
//        [rate5 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        UIImageView *rate6 = [[UIImageView alloc] init];
//        [rate6 setImage:[UIImage imageNamed:@"terrRate.png"]];
//        NSArray *arrayOfRates = [[NSArray alloc] initWithObjects:rate1, rate2,rate3,rate4,rate5,rate6, nil];
//        
//        [self.view addSubview:rate1];
//    
//    NSArray *arrayOfAnswers = [[NSArray alloc] initWithObjects:answer1, answer2, answer3, answer4,answer5,answer6, nil];
//        for(int i=0;i<self.receivedArray.count;i++){
//                       NSString *votesForProduct = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
//          //  NSLog(@" gg %d", [votesForProduct integerValue  ])   ;
//            self.totalVotes = self.totalVotes + [votesForProduct integerValue] ;
//        }
//        NSLog(@"Total votes =%f", self.totalVotes);
//    for(int i=0;i<arrayOfTitles.count;i++){
//        UILabel *currentLabel = [arrayOfTitles objectAtIndex:i];
//        NSString *title = @"Товар  ";
//        NSString *title1 = [title stringByAppendingString:[NSString stringWithFormat:@"%i",i+1]];
//        [currentLabel setText:title1];
//        [currentLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
//        [currentLabel setBackgroundColor:[UIColor clearColor]];
//        [self.view addSubview:currentLabel];
//    }
//        
//       
//        for(int i=0;i<self.receivedArray.count;i++){
//             if(self.totalVotes !=0){
//            UILabel *currentAnswerLabel = [arrayOfAnswers objectAtIndex:i];
//            NSString *value = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
//            NSLog(@"value %f = ", [value floatValue]);
//            CGFloat index = [value floatValue]/self.totalVotes;
//            NSLog(@"index =%f",index);
//            NSInteger heigh = (i+1)*50+10;
//            NSLog(@"height = %d", heigh);
//            CGFloat integer = 1.0/2.0;
//            NSInteger percents = index*100;
//            
//            
//            NSLog(@"testt %f", integer);
//            [[arrayOfRates objectAtIndex:i] setFrame:CGRectMake(85, (i+1)*50+10, 1+index*110, 20)];
//            
//            [currentAnswerLabel setText:[[NSString stringWithFormat:@"%d", percents] stringByAppendingString:@" % Голосов"]];
//            [currentAnswerLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
//            [currentAnswerLabel setBackgroundColor:[UIColor clearColor]];
//           // currentAnswerLabel.text = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
//            [self.view addSubview:[arrayOfRates objectAtIndex:i]];
//            [self.view addSubview:currentAnswerLabel];
//        }
//             else{
//                  UILabel *currentAnswerLabel = [arrayOfAnswers objectAtIndex:i];
//                 [currentAnswerLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
//                 [currentAnswerLabel setBackgroundColor:[UIColor clearColor]];
//                 currentAnswerLabel.text = @"0%";
//                 [self.view addSubview:currentAnswerLabel];
//             }
//        }
//    for(int i=self.receivedArray.count;i<arrayOfTitles.count;i++)
//    {
//        [[arrayOfTitles objectAtIndex:i]  setHidden:YES];
//        [[arrayOfAnswers objectAtIndex:i] setHidden:YES];
//    }
//    }
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if(type == kQuestStat){
    self.receivedArray = [dictionary valueForKey:@"options"];
        for(int i=0;i<self.receivedArray.count;i++){
            NSString *votesForProduct = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
            //  NSLog(@" gg %d", [votesForProduct integerValue  ])   ;
            self.totalVotes = self.totalVotes + [votesForProduct integerValue] ;
        }
        
    //[self buildView];
    }
     [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];
    NSLog(@"COUNT %d", self.receivedArray.count);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];

    
}



@end
