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
@synthesize nameLabel = _nameLabel;

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
//    [self.tableView setContentOffset:CGPointMake(5, 100)animated:YES];
    [self.nameLabel setText:NSLocalizedString(@"AnswersKey", nil)];
    NSLog(@"TOTAL %f", self.totalVotes);
 
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
//    self.tableView.layer.cornerRadius = 10.0f;
//    self.tableView.layer.borderWidth = 1.0f;
//    [self.tableView.layer setBorderColor:[[UIColor blackColor] CGColor]];
 [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadingInquirerStatKey",nil)];
   
    NSLog(@"id question %d", self.questionID);
    NSLog(@"interfaceIndex %d", self.interfaceIndex);
    [self.api getStatisticQuestionWithID:self.questionID];
    

	// Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.interfaceIndex ==1){
        return self.receivedArray.count;
    }
    else{
        return self.receivedArray.count;
        NSLog(@"return %d", self.receivedArray.count);
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.rateView.layer.cornerRadius = 5.0f;
    cell.rateView.clipsToBounds = YES;
    if(self.interfaceIndex ==1){
        NSLog(@"TTOTAL %f",self.totalVotes);
        NSLog(@"count %d",self.receivedArray.count);
//        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.receivedArray.count*50)];
        
        NSString *value = [[self.receivedArray objectAtIndex:indexPath.row] valueForKey:@"cnt"];
        NSLog(@"value %f = ", [value floatValue]);
        CGFloat index = [value floatValue]/self.totalVotes;
        NSLog(@"index =%f",index);
        NSInteger heigh = (indexPath.row+1)*45+10;
        NSLog(@"height = %d", heigh);
        NSInteger percents = index*100;
      [cell.rateView setFrame:CGRectMake(61, 13, 0+index*190, 20)];
        NSString *answer = [NSString stringWithFormat:@"%d",percents];
        cell.answerLabel.text = [answer stringByAppendingString:@"%"];
        cell.rateView.image = [UIImage imageNamed:@"terrRate.png"];
 
        if([[[self.receivedArray objectAtIndex:indexPath.row] valueForKey:@"title"] isEqualToString:@"!-- like --!"]){
            cell.titleLabel.text = NSLocalizedString(@"GoodKey",nil);
                   }
        else{
            cell.titleLabel.text = NSLocalizedString(@"BadKey",nil);
                    }
       
    }
    else{
        
      //  CGFloat height = self.receivedArray.count;
//        [self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, height*50)];
        NSLog(@"count %d",self.receivedArray.count);
        NSLog(@"current row %d", indexPath.row);
        NSLog(@"title %@", [[self.receivedArray objectAtIndex:indexPath.row] valueForKey:@"title"]);
        NSString *number = [NSString stringWithFormat:@" %d",indexPath.row+1];
        cell.titleLabel.text = [NSLocalizedString(@"ItemKey",nil) stringByAppendingString:number];
        NSString *value = [[self.receivedArray objectAtIndex:indexPath.row] valueForKey:@"cnt"];
       // NSLog(@"value %f = ", [value floatValue]);
        CGFloat index = [value floatValue]/self.totalVotes;
        //NSLog(@"index =%f",index);
        //NSInteger heigh = (indexPath.row+1)*50+10;
        //NSLog(@"height = %d", heigh);
        NSInteger percents;
        if(self.totalVotes==0){
            percents = 0;
        [cell.rateView setFrame:CGRectMake(61, 15,0, 20)];
        }
        else{
            percents = index*100;
           [cell.rateView setFrame:CGRectMake(61, 13,0+index*190, 20)];
        }
        cell.rateView.image = [UIImage imageNamed:@"terrRate.png"];
        NSString *answer = [NSString stringWithFormat:@"%d",percents];
        cell.answerLabel.text = [answer stringByAppendingString:@"%"];

        
    }
    return cell;

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
        for(int i=0;i<self.receivedArray.count;i++){
            NSString *votesForProduct = [[self.receivedArray objectAtIndex:i] valueForKey:@"cnt"];
            //  NSLog(@" gg %d", [votesForProduct integerValue  ])   ;
            self.totalVotes = self.totalVotes + [votesForProduct integerValue] ;
        }
        
    //[self buildView];
    }
    NSString *response = [[dictionary valueForKey:@"message"] valueForKey:@"text"];
    if([response isEqualToString:@"To get access to this page please log in to the system."]){
        UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Пожалуйста перезайдите в систему!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
        [failmessage show];
        
    }

    // [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];
    NSLog(@"COUNT %d", self.receivedArray.count);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];

    
}



@end
