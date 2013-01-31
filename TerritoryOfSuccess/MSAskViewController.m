//
//  MSAskViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAskViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MSAskSubCategoryViewController.h"

@interface MSAskViewController ()
@property (strong, nonatomic) NSArray *questionsArray;
@property int questionsCount;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;

@end

@implementation MSAskViewController
@synthesize tableOfCategories = _tableOfCategories;
@synthesize questionsArray = _questionsArray;
@synthesize questionsCount = _questionsCount;
@synthesize receivedData = _receivedData;
@synthesize api = _api;
@synthesize translatingValue;
@synthesize upButtonShows;
@synthesize upButton = _upButton;

- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    self.upButtonShows = NO;
    [super viewDidLoad];
    _tableOfCategories.delegate = self;
    _tableOfCategories.dataSource = self;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    _tableOfCategories.layer.cornerRadius = 10;
    [_tableOfCategories.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_tableOfCategories.layer setBorderWidth:1.0f];
    [_tableOfCategories.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
    [self.api getQuestionsWithParentID:0];
    
	// Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _questionsCount;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString* cellIdentifier = @"questCellID";
        cell = [_tableOfCategories dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];            cell.detailTextLabel.text = @"Оценка";
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.upButtonShows = YES;
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    self.translatingValue = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    _questionsCount = 0;
    [_tableOfCategories reloadData];
    [self.api getQuestionsWithParentID:[[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue]];
    
    NSLog(@"translate %@", self.translatingValue);
    //[self performSegueWithIdentifier:@"toAskSubCategory" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toAskSubCategory"])
    {
        MSAskSubCategoryViewController *controller = (MSAskSubCategoryViewController *)segue.destinationViewController;
        controller.parentID1 = self.translatingValue;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)typefinished
{
   
    if(typefinished == kQuestCateg)
    {
        NSLog(@"zzzzzzz %u", _questionsCount);
        _questionsArray = [dictionary valueForKey:@"list"];
    
        for (int i  = 0; i<_questionsArray.count; i++)
        {
            NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:_questionsCount inSection:0]];
            _questionsCount++;
            [_tableOfCategories insertRowsAtIndexPaths: insertIndexPath withRowAnimation:NO];
        }
              [_tableOfCategories reloadData];
      //  _questionsCount = 0;


       
    }
   
}

- (IBAction)upAction:(id)sender {
    _questionsCount = 0;
    [_tableOfCategories reloadData];
    [self.api getQuestionsWithParentID:0];
    [_upButton setEnabled:NO];

}
@end