//
//  MSQuestionsForProductViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/5/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionsForProductViewController.h"
#import "MSQuestionCell.h"
#import "MSQuestionDetailViewController.h"


@interface MSQuestionsForProductViewController ()

@end

@implementation MSQuestionsForProductViewController
@synthesize gettedUrlImage = _gettedUrlImage;
@synthesize questionsArray = _questionsArray;
@synthesize gettedProductTitle = _gettedProductTitle;
@synthesize sendingDetail = _sendingDetail;
@synthesize sendingName = _sendingName;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *oneQuestion = [[NSArray alloc] initWithObjects:@"FirstName",@"First question", nil];
    NSArray *twoQuestion = [[NSArray alloc] initWithObjects:@"SecondName",@"Second question", nil];
    NSArray *threeQuestion = [[NSArray alloc] initWithObjects:@"ThirdName",@"Third question", nil];
    _questionsArray = [NSMutableArray arrayWithObjects:oneQuestion,twoQuestion,threeQuestion, nil];
    NSLog(@"HHHHHHH %@",_gettedProductTitle);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toAskQuestion"])
    {
        MSCreateQuestionViewController *controller = [segue destinationViewController];
        controller.productTitle = _gettedProductTitle;
        controller.imageURL = _gettedUrlImage;
        controller.delegate = self;
        
    }
    if([segue.identifier isEqualToString:@"toQuestionDetail"])
    {
        MSQuestionDetailViewController *controller = [segue destinationViewController];
        controller.gettedDescription = _sendingDetail;
        controller.gettedName = _sendingName;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _questionsArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"questionCell";
    MSQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MSQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableString *name = [NSString stringWithFormat:@"%@",[[_questionsArray objectAtIndex:indexPath.row] objectAtIndex:0]];
    cell.nameLabel.text =[name stringByAppendingString:@" написал:"];
    [cell.questionLabel setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    cell.questionLabel.text = [[_questionsArray objectAtIndex:indexPath.row] objectAtIndex:1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _sendingName = [[_questionsArray objectAtIndex:indexPath.row] objectAtIndex:0];
    _sendingDetail = [[_questionsArray objectAtIndex:indexPath.row] objectAtIndex:1];
    [self performSegueWithIdentifier:@"toQuestionDetail" sender:self];
    NSLog(@"name %@", _sendingName);
}
-(void) addNewQuestion:(NSArray *)array{
    [_questionsArray addObject:array];
    [_tableOfQuestions reloadData];
    
}

@end
