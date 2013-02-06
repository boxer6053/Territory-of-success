//
//  MSQuestionDetailViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/6/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionDetailViewController.h"

@interface MSQuestionDetailViewController ()

@end

@implementation MSQuestionDetailViewController
@synthesize gettedName = _gettedName;
@synthesize gettedDescription = _gettedDescription;
@synthesize askerNameLabel = _askerNameLabel;
@synthesize questionDescriptionView = _questionDescriptionView;
@synthesize answersArray = _answersArray;

@synthesize answersTable = _answersTable;
- (void)viewDidLoad
{
    _answersTable.delegate = self;
    _answersTable.dataSource = self;
    _answersArray = [[NSArray alloc] initWithObjects:@"Bad",@"Fine",@"Good",@"Perfect", nil];
    _askerNameLabel.text = _gettedName;
    _questionDescriptionView.text = _gettedDescription;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _answersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"answerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableString *answer = [_answersArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = answer ;
    cell.textLabel.text = @"responder";
    return cell;
}

@end
