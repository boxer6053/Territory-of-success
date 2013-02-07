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
#import "MSShare.h"
#import "SVProgressHUD.h"

@interface MSNewsDetailsViewController ()

@property (nonatomic) MSAPI *dbApi;
@property (nonatomic) BOOL shareButtonsShowed;
@property (strong, nonatomic) MSShare *share;

@end

@implementation MSNewsDetailsViewController

@synthesize dbApi = _dbApi;
@synthesize shareButtonsShowed = _shareButtonsShowed;
@synthesize articleTextWebView = _articleTextWebView;
@synthesize articleImageView = _articleImageView;
@synthesize articleTitleLabel = _articleTitleLabel;
@synthesize articleScrollView = _articleScrollView;
@synthesize articleShareButton = _articleShareButton;
@synthesize articleShareFbButton = _articleShareFbButton;
@synthesize articleShareTwButton = _articleShareTwButton;
@synthesize articleShareVkButton = _articleShareVkButton;
@synthesize share = _share;

- (MSAPI *)dbApi
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
    
    self.shareButtonsShowed = NO;
    self.articleScrollView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    self.articleTextWebView.backgroundColor = [UIColor clearColor];
    self.articleTextWebView.opaque = NO;
    self.articleTextWebView.hidden = YES;
   // self.articleScrollView.layer.cornerRadius = 10.0;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Share Methods

- (MSShare *)share
{
    if (!_share) {
        _share = [[MSShare alloc] init];
    }
    return _share;
}
- (IBAction)vkButtonPressed:(id)sender
{
    self.share.mainView = self;
    [[self share] shareOnVKWithText:@"trololo" withImage:@"trololo"];
    [self.view addSubview:self.share];
}

- (IBAction)twbButtonPressed:(id)sender
{
    [[self share] shareOnTwitterWithText:@"Trololo"
                               withImage:[UIImage imageNamed:@"twButton.png"]
                   currentViewController:self];

}

- (IBAction)fbButtonPressed:(id)sender
{
    [[self share] shareOnFacebookWithText:@"Trololo"
                                withImage:[UIImage imageNamed:@"fbButton.png"]
                    currentViewController:self];
}

- (IBAction)shareButtonPressed:(id)sender
{
    if (!self.shareButtonsShowed)
    {
        self.shareButtonsShowed = YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        self.articleShareVkButton.frame = CGRectMake(self.articleShareVkButton.frame.origin.x, self.articleShareVkButton.frame.origin.y + 40, self.articleShareVkButton.frame.size.width, self.articleShareVkButton.frame.size.height);
        self.articleShareTwButton.frame = CGRectMake(self.articleShareTwButton.frame.origin.x, self.articleShareTwButton.frame.origin.y + 40, self.articleShareTwButton.frame.size.width, self.articleShareTwButton.frame.size.height);
        self.articleShareFbButton.frame = CGRectMake(self.articleShareFbButton.frame.origin.x, self.articleShareFbButton.frame.origin.y + 40, self.articleShareFbButton.frame.size.width, self.articleShareFbButton.frame.size.height);
        self.articleScrollView.frame = CGRectMake(0, 35, self.articleScrollView.frame.size.width, self.articleScrollView.frame.size.height);
        [UIView commitAnimations];
    }
    else
    {
        self.shareButtonsShowed = NO;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        self.articleShareVkButton.frame = CGRectMake(self.articleShareVkButton.frame.origin.x, self.articleShareVkButton.frame.origin.y - 40, self.articleShareVkButton.frame.size.width, self.articleShareVkButton.frame.size.height);
        self.articleShareTwButton.frame = CGRectMake(self.articleShareTwButton.frame.origin.x, self.articleShareTwButton.frame.origin.y - 40, self.articleShareTwButton.frame.size.width, self.articleShareTwButton.frame.size.height);
        self.articleShareFbButton.frame = CGRectMake(self.articleShareFbButton.frame.origin.x, self.articleShareFbButton.frame.origin.y - 40, self.articleShareFbButton.frame.size.width, self.articleShareFbButton.frame.size.height);
        self.articleScrollView.frame = CGRectMake(0, 0, self.articleScrollView.frame.size.width, self.articleScrollView.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)setContentOfArticleWithId:(NSString *)articleId
{
    [self.dbApi getNewsWithId:articleId];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadingInformationKey",nil)];
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
        articleText  = [articleText stringByReplacingOccurrencesOfString:@"width=\"327\" height=\"245\"></iframe>" withString:@"width=\"300\" height=\"224\"></iframe>"];
        
        [self.articleTextWebView loadHTMLString:[NSString stringWithFormat:@"<div background-color:transparent>%@<div>",articleText] baseURL:nil];
        
        
        self.articleBriefTextView.text = [[dictionary valueForKey:@"post"] valueForKey:@"brief"];
        self.articleDateLabel.text = [[dictionary valueForKey:@"post"] valueForKey:@"date"];
        self.articleBriefTextView.frame = CGRectMake(self.articleBriefTextView.frame.origin.x, self.articleBriefTextView.frame.origin.y, self.articleBriefTextView.frame.size.width, self.articleBriefTextView.contentSize.height);
        self.articleBriefTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.articleTextWebView sizeToFit];
    self.articleTextWebView.frame = CGRectMake(self.articleTextWebView.frame.origin.x, self.articleBriefTextView.frame.origin.y + self.articleBriefTextView.frame.size.height, 320, self.articleTextWebView.frame.size.height);
    self.articleScrollView.contentSize= CGSizeMake(self.articleScrollView.contentSize.width, self.articleTextWebView.frame.origin.y + self.articleTextWebView.frame.size.height + 5);
    self.articleTextWebView.hidden = NO;
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];
}
@end
