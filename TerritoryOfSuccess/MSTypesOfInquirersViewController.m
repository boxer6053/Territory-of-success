//
//  MSInquirerViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//


#import "MSTypesOfInquirersViewController.h"
#import "MSInquirerDetailViewController.h"
#import "SVProgressHUD.h"
#import "MSInquirerCell.h"
#import "MSLogInView.h"
@interface MSTypesOfInquirersViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;
@property (nonatomic, strong) MSLogInView *loginView;
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
@synthesize loginView = _loginView;

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
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefults valueForKey:@"authorization_Token" ];
    if(token.length)
        self.isAuthorized = YES;
    else
        self.isAuthorized = NO;
//    if(!token.length){
//        
//        if (!self.loginView)
//        {
//            self.loginView = [[MSLogInView alloc]initWithOrigin:CGPointMake(25, self.view.frame.size.height/2 - 120)];
//            [self.view addSubview:self.loginView];
//            [self.loginView blackOutOfBackground];
//            [self.loginView attachPopUpAnimationForView:self.loginView.loginView];
//            self.loginView.delegate = self;
//            self.loginView.emailTextField.delegate = self;
//            self.loginView.passwordConfirmTextField.delegate = self;
//            self.loginView.passwordTextField.delegate = self;
//        }
//
//    }
    NSLog(@"AllQuestions");
    [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadInquirersKey",nil)];
    
    
    
    [self.api getLastQuestions];
    self.allInquirerMode=YES;
   // UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 320, 220)];
//    [imageView setImage:[UIImage imageNamed:@"inquirerPic.png"]];
//    [imageView setAlpha:0.3];
//    [self.view addSubview:imageView];
    [self.view addSubview:self.tableOfInquirers];
    //[self.view addSubview:[UIImageView *imageView = [UIImageView alloc]init]]
    self.myInquirerMode = NO;
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }

    
   
    
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

-(void)dismissPopView:(BOOL)result
{
    if(result)
    {
        self.isAuthorized = YES;
        //[self.profileBarButton setImage:[UIImage imageNamed:@"Profile-Picture_40*28_white.png"]];
    }
    self.loginView = nil;
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
    MSInquirerCell *cell;
    static NSString* cellIdentifier = @"inquirerCellId";
    cell = [_tableOfInquirers dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[MSInquirerCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    cell.titleLabel.numberOfLines = 2;
    if(allInquirerMode) {
        cell.titleLabel.text = [[self.allQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        if([[[self.allQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"cnt"] integerValue]== 1){
         cell.typeImage.image = [UIImage imageNamed:@"likeIcon.png"];
        }
        else{
            cell.typeImage.image = [UIImage imageNamed:@"questionMark.png"];
        }
    }
    else{
        cell.titleLabel.text = [[self.myQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"title"];
        
        
        if([[[self.myQuestionsArray objectAtIndex:indexPath.row] valueForKey:@"cnt"] integerValue]== 1){
            cell.typeImage.image = [UIImage imageNamed:@"likeIcon.png"];
        }
        else{
            cell.typeImage.image = [UIImage imageNamed:@"questionMark.png"];
        }
        
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
       NSString *response = [[dictionary valueForKey:@"message"] valueForKey:@"text"];       if([response isEqualToString:@"To get access to this page please log in to the system."])
       {
            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Пожалуйста перезайдите в систему!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
            [failmessage show];
                    }
        // self.numberOfRows = [[self arrayOfCategories] count];
    }
    
    if (type == kMyQuestions)
    {
        self.myQuestionsArray = [dictionary valueForKey:@"list"];
     
        //self.numberOfRows = [[self arrayOfBrands] count];
        self.allQuestionsArray = [dictionary valueForKey:@"list"];
        NSString *response = [[dictionary valueForKey:@"message"] valueForKey:@"text"];
        if([response isEqualToString:@"To get access to this page please log in to the system."]){
            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Пожалуйста перезайдите в систему!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
            [failmessage show];
        }

    }
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];
    [[self tableOfInquirers] reloadData];
      
    
    
}
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
      //  MSFirstViewController *loginViewController = [[MSFirstViewController alloc] init];

        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
@end
