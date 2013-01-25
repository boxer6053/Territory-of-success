//
//  MSNewsDetailsViewController.m
//  TerritoryOfSuccess
//
//  Created by Alex on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSNewsDetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface MSNewsDetailsViewController ()

@property (nonatomic)MSAPI *dbApi;

@end

@implementation MSNewsDetailsViewController

@synthesize dbApi = _dbApi;
@synthesize articleTextView = _articleTextView;
@synthesize articleImageView = _articleImageView;
@synthesize articleTitleLabel = _articleTitleLabel;
@synthesize articleScrollView = _articleScrollView;

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
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    
    self.articleScrollView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
   // self.articleScrollView.layer.cornerRadius = 10.0;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setContentOfArticleWithId:(NSString *)articleId
{
    [self.dbApi getNewsWithId:articleId];
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if (type == kNewsWithId)
    {
        NSURL *imageUrl = [NSURL URLWithString: [[dictionary valueForKey:@"post"] valueForKey:@"image"]];
        [self.articleImageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
        [self.articleImageView.layer setCornerRadius:5.0];
        self.articleTitleLabel.text = [[dictionary valueForKey:@"post"] valueForKey:@"title"];
        self.articleTextView.text = [[dictionary valueForKey:@"post"] valueForKey:@"content"];
        self.articleBriefTextView.text = [[dictionary valueForKey:@"post"] valueForKey:@"brief"];
        self.articleDateLabel.text = [[dictionary valueForKey:@"post"] valueForKey:@"date"];
        self.articleBriefTextView.frame = CGRectMake(self.articleBriefTextView.frame.origin.x, self.articleBriefTextView.frame.origin.y, self.articleBriefTextView.frame.size.width, self.articleBriefTextView.contentSize.height);
        self.articleBriefTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        self.articleTextView.frame = CGRectMake(self.articleTextView.frame.origin.x, self.articleBriefTextView.frame.origin.y + self.articleBriefTextView.frame.size.height, self.articleTextView.frame.size.width, self.articleTextView.contentSize.height);
        self.articleScrollView.contentSize= CGSizeMake(self.articleScrollView.contentSize.width, self.articleTextView.frame.origin.y + self.articleTextView.frame.size.height + 5);
    }
}
@end
