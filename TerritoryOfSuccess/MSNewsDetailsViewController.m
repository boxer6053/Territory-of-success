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
@synthesize articleTextWebView = _articleTextWebView;
@synthesize articleImageView = _articleImageView;
@synthesize articleTitleLabel = _articleTitleLabel;
@synthesize articleScrollView = _articleScrollView;
@synthesize articleActivityIndicator = _articleActivityIndicator;

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
    self.articleTextWebView.backgroundColor = [UIColor clearColor];
    self.articleTextWebView.opaque = NO;
    [self.articleActivityIndicator startAnimating];
    self.articleActivityIndicator.hidesWhenStopped = YES;
    self.articleTextWebView.hidden = YES;
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
        
        //change iframe size for youtube video

        NSString *articleText = [[dictionary valueForKey:@"post"] valueForKey:@"content"];
        articleText  = [articleText stringByReplacingOccurrencesOfString:@"width=\"327\" height=\"245\"><\/iframe>" withString:@"width=\"300\" height=\"224\"><\/iframe>"];
        
        [self.articleTextWebView loadHTMLString:[NSString stringWithFormat:@"<div background-color:transparent>%@<div>",articleText] baseURL:nil];
        
        
        self.articleBriefTextView.text = [[dictionary valueForKey:@"post"] valueForKey:@"brief"];
        self.articleDateLabel.text = [[dictionary valueForKey:@"post"] valueForKey:@"date"];
        self.articleBriefTextView.frame = CGRectMake(self.articleBriefTextView.frame.origin.x, self.articleBriefTextView.frame.origin.y, self.articleBriefTextView.frame.size.width, self.articleBriefTextView.contentSize.height);
        self.articleBriefTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.articleActivityIndicator stopAnimating];
    [self.articleTextWebView sizeToFit];
    self.articleTextWebView.frame = CGRectMake(self.articleTextWebView.frame.origin.x, self.articleBriefTextView.frame.origin.y + self.articleBriefTextView.frame.size.height, 320, self.articleTextWebView.frame.size.height);
    self.articleScrollView.contentSize= CGSizeMake(self.articleScrollView.contentSize.width, self.articleTextWebView.frame.origin.y + self.articleTextWebView.frame.size.height + 5);
    self.articleTextWebView.hidden = NO;
}
@end
