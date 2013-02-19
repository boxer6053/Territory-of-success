//
//  MSAskViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAskViewController.h"






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
@synthesize defaultID = _defaultID;
@synthesize finalID = _finalID;
@synthesize translatingValue;
@synthesize upButtonShows;
@synthesize upButton = _upButton;
@synthesize sendingTitle = _sendingTitle;
@synthesize translatingUrl = _translatingUrl;
@synthesize upperID = _upperID;
@synthesize requestItemsString = _requestItemsString;
@synthesize isAuthorized = _isAuthorized;
@synthesize delegate = _delegate;


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
    
    NSLog(@"ASK VIEW CONTROLLER");
    [_tableOfCategories setShowsVerticalScrollIndicator:NO];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    NSLog(@"upper %d", self.upperID);
    NSLog(@"ask %d", self.defaultID);
    self.upButtonShows = NO;
    [super viewDidLoad];
    _tableOfCategories.delegate = self;
    _tableOfCategories.dataSource = self;
    self.requestItemsString = [[NSMutableString alloc] initWithString:@""];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
    
    if(!self.defaultID){
    [self.api getQuestionsWithParentID:0];
    }
    else
    {
        [self.api getQuestionsWithParentID:self.defaultID];
    }
    NSLog(@"NEWWWW");
    
    }
-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    
    if([[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"cnt"] integerValue] != 0)
    {
        _questionsCount = 0;
        [_tableOfCategories reloadData];
        [self.api getQuestionsWithParentID:[[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue]];
        _upperID = [[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
        NSLog(@"Upper ID = %d", _upperID);
        
        NSLog(@"translate %@", self.translatingValue);
    }
    else
    {
        if(self.defaultID)
        {self.upperID = self.defaultID;
        }
        if([[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"] isEqualToString:@""])
        {
            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"No picture or not enough data =(" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [failmessage show];
        }
        else
        {
            _translatingUrl = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"];
            _sendingTitle = [[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
            self.finalID = self.defaultID;
            NSLog(@"finalID = %d", self.finalID);
            //self.upperID = self.finalID;
            NSLog(@"wazaaaa %@",_translatingUrl);
            NSLog(@"asdadsfdsfsf %@",_sendingTitle);
            NSLog(@"After select %d", self.upperID);
            [self.delegate setUpperId:self.upperID];
            if([[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"]){
                
                [self.delegate addProduct:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] withURL:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"]];}
           // [self.delegate setUpperId:self.finalID];
            
            //[self.delegate addProduct:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"id"] withURL:[[_questionsArray objectAtIndex:indexPath.row] valueForKey:@"image"]];
            
            //
            //            [self.requestItemsString appendString:@"hello1"];
            //            NSLog(@"reqyest %@", self.requestItemsString);
            [self dismissViewControllerAnimated:YES completion:nil];
            // [self performSegueWithIdentifier:@"toQuestionProductDetail" sender:self];
        }
        
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
    if(typefinished == kLastQuest)
    {
        
    }
    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate setUpperId:0];
}

- (IBAction)upAction:(id)sender {
    _questionsCount = 0;
    [_tableOfCategories reloadData];
    [self.api getQuestionsWithParentID:0];
    [_upButton setEnabled:NO];
    
}
@end
