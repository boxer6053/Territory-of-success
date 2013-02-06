//
//  MSQuestionsForProductViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/5/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionsForProductViewController.h"
#import "MSQuestionCell.h"


@interface MSQuestionsForProductViewController ()

@end

@implementation MSQuestionsForProductViewController
@synthesize gettedUrlImage = _gettedUrlImage;
@synthesize questionsArray = _questionsArray;
@synthesize gettedProductTitle = _gettedProductTitle;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *oneQuestion = [[NSArray alloc] initWithObjects:@"FirstName",@"First comment", nil];
    NSArray *twoQuestion = [[NSArray alloc] initWithObjects:@"SecondName",@"Second Comment", nil];
    NSArray *threeQuestion = [[NSArray alloc] initWithObjects:@"ThirdName",@"Third Comment", nil];
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

-(void) addNewQuestion:(NSArray *)array{
    [_questionsArray addObject:array];
    [_tableOfQuestions reloadData];
    
}

@end
