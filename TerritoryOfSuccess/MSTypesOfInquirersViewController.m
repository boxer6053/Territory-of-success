//
//  MSInquirerViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//


#import "MSTypesOfInquirersViewController.h"
#import "MSInquirerDetailViewController.h"

@interface MSTypesOfInquirersViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;
@end


@implementation MSTypesOfInquirersViewController
@synthesize tableOfInquirers = _tableOfInquirers;
@synthesize testInquirers = _testInquirers;
@synthesize selectedValue = _selectedValue;
@synthesize allInquirerMode;
@synthesize myInquirerMode;
@synthesize inquirerTypeSegment = _inquirerTypeSegment;
@synthesize isAuthorized = _isAuthorized;
@synthesize addQuestionButton = _addQuestionButton;
@synthesize myQuestionsArray = _myQuestionsArray;
@synthesize allQuestionsArray = _allQuestionsArray;
@synthesize sendingID = _sendingID;

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
    NSLog(@"AllQuestions");
    [self.api getLastQuestions];
    self.allInquirerMode=YES;
    self.myInquirerMode = NO;
    
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefults valueForKey:@"authorization_Token" ];
    if(token.length)
        self.isAuthorized = YES;
    else
        self.isAuthorized = NO;
    
    if(!self.isAuthorized){
        [self.addQuestionButton setEnabled:NO];
    }
    [_inquirerTypeSegment setTintColor:[UIColor blackColor]];
    _tableOfInquirers.delegate = self;
    _tableOfInquirers.dataSource = self;
    _testInquirers = [[NSArray alloc] initWithObjects:@"1",@"2", nil];
    [_tableOfInquirers setShowsVerticalScrollIndicator:NO];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
    // Do any additional setup after loading the view.
}
-(void)setSegmentControlColor
{
    if (_inquirerTypeSegment.selectedSegmentIndex == 0) {
        [[_inquirerTypeSegment.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[_inquirerTypeSegment.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }else{
        [[_inquirerTypeSegment.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[_inquirerTypeSegment.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setSegmentControlColor];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(allInquirerMode)
    {
        return self.allQuestionsArray.count;
    }
    else{
        return self.myQuestionsArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString* cellIdentifier = @"customInqCell";
    cell = [_tableOfInquirers dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    
    if(allInquirerMode) {
        cell.textLabel.text = [[self.allQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        // cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    }
    else{
        cell.textLabel.text = [[self.myQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        
        //cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedValue = cell.textLabel.text;
    if(allInquirerMode) {
        self.sendingID =  [[self.allQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    }
    else{
        self.sendingID = [[self.myQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"id"];
    }
    NSLog(@"ID%@",  self.sendingID);
    NSLog (@"%@", _selectedValue);
    [self performSegueWithIdentifier:@"toInquirerDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toInquirerDetail"]){
        MSInquirerDetailViewController *controller = (MSInquirerDetailViewController *)segue.destinationViewController;
        controller.inquirerType = [_selectedValue integerValue];
        controller.itemID = self.sendingID;
        NSLog(@"ss %@", _selectedValue);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inquirerTypeSwitch:(id)sender {
    
    [self setSegmentControlColor];
    if(self.inquirerTypeSegment.selectedSegmentIndex == 0)
    {
        self.allInquirerMode = YES;
        self.myInquirerMode = NO;
        [self.api getLastQuestions];
    }
    else
    {
        self.allInquirerMode = NO;
        self.myInquirerMode = YES;
        [self.api getMyQuestionsWithOffset:0];
    }
    // [_tableOfInquirers reloadData];
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
    if (type == kLastQuest)
    {
        self.allQuestionsArray = [dictionary valueForKey:@"list"];
        // self.numberOfRows = [[self arrayOfCategories] count];
    }
    
    if (type == kMyQuestions)
    {
        self.myQuestionsArray = [dictionary valueForKey:@"list"];
        //self.numberOfRows = [[self arrayOfBrands] count];
    }
    
    [[self tableOfInquirers] reloadData];
    
    
}
@end
