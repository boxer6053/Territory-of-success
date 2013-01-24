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
@synthesize articleImageView = _articleImageView;
@synthesize articleTextView = _articleTextView;
@synthesize articleTitleLabel = _articleTitleLabel;

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
//        self.newsPageControl.numberOfPages = arrayOfNews.count;
    }
}
@end
