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
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSNewsCell.h"

@interface MSNewsViewController ()

@property (nonatomic)  MSAPI *dbApi;
@property int newsCount;
@property NSMutableArray *arrayOfNews;
@property NSArray *lastDownloadedNews;
@property NSInteger totalNewsCount;
@property UIButton *footerButton;

@end

@implementation MSNewsViewController

@synthesize newsTableView = _newsTableView;
@synthesize dbApi = _dbApi;
@synthesize arrayOfNews = _arrayOfNews;
@synthesize newsCount = _newsCount;
@synthesize lastDownloadedNews = _lastDownloadedNews;
@synthesize totalNewsCount = _totalNewsCount;
@synthesize footerButton = _footerButton;

-(MSAPI *)dbApi
{
    if(!_dbApi)
    {
        _dbApi = [[MSAPI alloc]init];
        _dbApi.delegate = self;
    }
    return _dbApi;
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
    [super viewDidLoad];
    
    self.arrayOfNews = [[NSMutableArray alloc]init];
    [self.dbApi getFiveNewsWithOffset:0];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
//    self.newsTableView.layer.cornerRadius = 10;
    self.newsTableView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
//    [self.newsTableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
//    [self.newsTableView.layer setBorderWidth:1.0f];
    self.footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.newsTableView.frame.size.width, 50)];
    [self.footerButton setTitle:@"Загрузить еще" forState:UIControlStateNormal];
    [self.footerButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4] forState:UIControlStateNormal];
    [self.footerButton addTarget:self action:@selector(moreNews) forControlEvents:UIControlEventTouchDown];
    self.newsTableView.tableFooterView = self.footerButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moreNews
{
    if (self.arrayOfNews.count < self.totalNewsCount)
    {
        [self.dbApi getFiveNewsWithOffset:self.arrayOfNews.count - 1];
    }
    else
    {
        [self.footerButton setTitle:@"Загружены все новости" forState:UIControlStateNormal];
    }
        
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)typefinished
{
    [self.arrayOfNews addObjectsFromArray: [dictionary valueForKey:@"list"]];
    self.lastDownloadedNews = [dictionary valueForKey:@"list"];
    for (int i  = 0; i<self.lastDownloadedNews.count; i++)
    {
        NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.newsCount inSection:0]];
        self.newsCount++;
        [self.newsTableView insertRowsAtIndexPaths: insertIndexPath withRowAnimation:NO];
    }
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
    MSNewsCell *cell = [self.newsTableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[MSNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    [cell.newsImageView setImageWithURL:[[self.arrayOfNews objectAtIndex:indexPath.row] valueForKey:@"image"]  placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    cell.newsTitleLabel.text = [[self.arrayOfNews objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.newsDetailLabel.text = [[self.arrayOfNews objectAtIndex:indexPath.row] valueForKey:@"brief"];
    cell.newsDateLabel.text = [[self.arrayOfNews objectAtIndex:indexPath.row] valueForKey:@"date"];
    cell.tag = [[[self.arrayOfNews objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * currentCell = [self.newsTableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"newsDetails" sender:currentCell];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newsDetails"])
    {
        UITableViewCell *currentCell = sender;
        [segue.destinationViewController setContentOfArticleWithId:[NSString stringWithFormat:@"%d",currentCell.tag]];
    }
}
@end
