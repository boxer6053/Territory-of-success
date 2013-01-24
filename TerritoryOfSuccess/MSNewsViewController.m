//
//  MSNewsViewController.m
//  TerritoryOfSuccess
//
//  Created by Alex on 1/14/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSNewsViewController.h"
#import "MSNewsDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JSONParserForDataEntenties.h"

@interface MSNewsViewController ()

@property MSAPI *dbManager;
@property int newsCount;
@property NSDictionary *dictinaryOfNews;

@end

@implementation MSNewsViewController

@synthesize newsTableView = _newsTableView;
@synthesize dbManager = _dbManager;
@synthesize dictinaryOfNews = _dictinaryOfNews;
@synthesize newsCount = _newsCount;

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
    [super viewDidLoad];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
    }
    self.newsCount = 5; //number of default 5 news thet loaded at start of app
    self.newsTableView.layer.cornerRadius = 10;
    self.newsTableView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    [self.newsTableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.newsTableView.layer setBorderWidth:1.0f];
    UIButton *footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.newsTableView.frame.size.width, 50)];
    [footerButton setTitle:@"Загрузить еще" forState:UIControlStateNormal];
    [footerButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4] forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(moreNews) forControlEvents:UIControlEventTouchDown];
    self.newsTableView.tableFooterView = footerButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moreNews
{
    for (int i  = 0; i<3; i++)
    {
        NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.newsCount inSection:0]];
        self.newsCount++;
        [self.newsTableView insertRowsAtIndexPaths: insertIndexPath withRowAnimation:NO];
    }
//    self.dbManager = [[MSAPI alloc]init];
//    self.dbManager.delegate = self;
//    [self.dbManager getFiveNewsWithOffset:self.newsCount - 1];
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)typefinished
{
    
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* myIdentifier = @"newsCellIdentifier";
    UITableViewCell *cell = [self.newsTableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    cell.textLabel.text = @"Заголовок новости";
    cell.textLabel.alpha = 1.0;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%u",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"newsDetails" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newsDetails"])
    {
        //[segue.destinationViewController setContentOfArticle:[NSString stringWithFormat:@"%@"]];
    }
}
@end
