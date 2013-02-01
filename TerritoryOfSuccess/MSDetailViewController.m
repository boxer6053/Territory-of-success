#import "MSDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSShare.h"
#import <Social/Social.h>

@interface MSDetailViewController ()
{
    BOOL shareIsPressed;
    BOOL accessToContinue;
}

@property (nonatomic) int commentsDetail, advisesDetail, ratingDetail;
@property (strong, nonatomic) NSString *productImageURL;
@property (strong, nonatomic) NSString *productSentName;
@property (strong, nonatomic) NSString *productSentDescription;
@property (strong, nonatomic) MSShare *share;
@property (nonatomic) Vkontakte *vkontakte;
@property (nonatomic) UIButton *loginVKButton;
@property (nonatomic) UIButton *postVKButton;
@property (nonatomic) UIView *vkView;

@end

@implementation MSDetailViewController

@synthesize commentsDetail = _commentsDetail;
@synthesize advisesDetail = _advisesDetail;
@synthesize ratingDetail = _ratingDetail;
@synthesize productName = _productName;
@synthesize share = _share;
@synthesize vkontakte = _vkontakte;
@synthesize loginVKButton = _loginVKButton;
@synthesize postVKButton = _postVKButton;
@synthesize vkView = _vkView;
@synthesize productSentDescription = _productSentDescription;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    shareIsPressed = NO;
    accessToContinue = YES;
    
    // вью с лайками и количеством комментариев
    self.likeView.layer.cornerRadius = 10;
    [self.likeView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    //вью со звездочками
    self.starView.layer.cornerRadius = 10;
    [self.starView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    [self.mainView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    [self.productDescriptionTextView setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.0]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.commentsLabel.text = [NSString stringWithFormat:@"%d",self.commentsDetail];
    self.advisesLabel.text = [NSString stringWithFormat:@"%d",self.advisesDetail];
    self.productName.text = self.productSentName;
    self.ratingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dstar",self.ratingDetail]];
    [self.detailImage setImageWithURL:[NSURL URLWithString:self.productImageURL]];
    self.productDescriptionTextView.text = self.productSentDescription;
    CGRect frame = self.productDescriptionTextView.frame;
    frame.size.height = self.productDescriptionTextView.contentSize.height;
    self.productDescriptionTextView.frame = frame;
    
    // проверка на развер экрана
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        [self.detailScrollView setContentSize:CGSizeMake(self.detailScrollView .frame.size.width, self.imageView.frame.size.height + self.productDescriptionTextView.frame.size.height + 50)];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + 85, self.imageView.frame.size.width, self.imageView.frame.size.height);
        self.productDescriptionTextView.frame = CGRectMake(self.productDescriptionTextView.frame.origin.x, self.productDescriptionTextView.frame.origin.y + 85, self.productDescriptionTextView.frame.size.width, self.productDescriptionTextView.frame.size.height);
        self.detailScrollView.frame = CGRectMake(self.detailScrollView.frame.origin.x, self.detailScrollView.frame.origin.y, self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
        self.commentsButton.frame = CGRectMake(self.commentsButton.frame.origin.x, 325, self.commentsButton.frame.size.width, self.commentsButton.frame.size.height);
        self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, self.mainView.frame.size.width, self.mainView.frame.size.height - 85);
        self.productName.frame = CGRectMake(self.productName.frame.origin.x , self.productName.frame.origin.y + 85, self.productName.frame.size.width, self.productName.frame.size.height);
        self.fbButton.frame = CGRectMake(self.fbButton.frame.origin.x, self.fbButton.frame.origin.y + 85, self.fbButton.frame.size.width, self.fbButton.frame.size.height);
        self.vkButton.frame = CGRectMake(self.vkButton.frame.origin.x, self.vkButton.frame.origin.y + 85, self.vkButton.frame.size.width, self.vkButton.frame.size.height);
        self.twButton.frame = CGRectMake(self.twButton.frame.origin.x, self.twButton.frame.origin.y + 85, self.twButton.frame.size.width, self.twButton.frame.size.height);
        [self.detailScrollView setContentSize:CGSizeMake(self.detailScrollView .frame.size.width, self.imageView.frame.size.height + self.productDescriptionTextView.frame.size.height + 135)];
    }
}
//необходим рефакторинг
//метод получения информации о продукте от сигвея
- (void)sentProductName:(NSString *)name
              andRating:(int)rating
      andCommentsNumber:(int)comments
       andAdvisesNumber:(int)advises
            andImageURL:(NSString *)imageURL
     andDescriptionText:(NSString *) descriptionText
{
    self.productSentName = name;
    self.productImageURL = imageURL;
    self.ratingDetail = rating;
    self.commentsDetail = comments;
    self.advisesDetail = advises;
    self.productSentDescription = descriptionText;
}

#pragma mark Share Methods
- (MSShare *) share
{
    if (!_share) {
        _share = [[MSShare alloc] init];
    }
    return _share;
}

- (void)setShare:(MSShare *)share
{
    _share = share;
}

//необходим рефакторинг
- (IBAction)shareButtonPressed:(id)sender {
    if (shareIsPressed == NO && accessToContinue == YES) {
        [UIView animateWithDuration:1 animations:^{
            accessToContinue = NO;
            self.vkButton.alpha = 1;
            self.fbButton.alpha = 1;
            self.twButton.alpha = 1;
            shareIsPressed = YES;
        } completion:^(BOOL finished) {
            accessToContinue = YES;
        }];
    }else if(shareIsPressed == YES && accessToContinue == YES){
        [UIView animateWithDuration:1 animations:^{
            accessToContinue = NO;
            self.vkButton.alpha = 0;
            self.fbButton.alpha = 0;
            self.twButton.alpha = 0;
            shareIsPressed = NO;
        } completion:^(BOOL finished) {
            accessToContinue = YES;
        }];
    }
    
}

- (IBAction)fbButtonPressed:(id)sender
{
    [[self share] shareOnFacebookWithText:@"I like Territory of Success"
                                withImage:[UIImage imageNamed:@"fbButton.png"]
                    currentViewController:self];
}

- (IBAction)twButtonPressed:(id)sender
{
    [[self share] shareOnTwitterWithText:self.productName.text
                               withImage:[UIImage imageNamed:@"twButton.png"]
                   currentViewController:self];
}
- (IBAction)vkButtonPressed:(id)sender
{
    _vkontakte = [Vkontakte sharedInstance];
    _vkontakte.delegate = self;
    
    self.vkView = [[UIView alloc] initWithFrame:CGRectMake(70, 100, 180, 195)];
    [self.vkView setBackgroundColor:[UIColor whiteColor]];
    [self.vkView.layer setBorderColor:[UIColor colorWithRed:75/255.0 green:110/255.0 blue:148/255.0 alpha:1].CGColor];
    [self.vkView.layer setCornerRadius:10];
    [self.vkView.layer setBorderWidth:1.0f];
    self.vkView.clipsToBounds = YES;
    [self.view addSubview:self.vkView];
    
    UIImageView *vkHeaderImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"vkHeader.png"]];
    vkHeaderImage.frame = CGRectMake(0, 0, 180, 45);
    [self.vkView addSubview:vkHeaderImage];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"cancelVKButton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(closeVKView) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(162, 3, 15, 15);
    cancelButton.hidden = NO;
    [self.vkView addSubview:cancelButton];
    
    self.loginVKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginVKButton setBackgroundImage:[UIImage imageNamed:@"vkActionButton.png"] forState:UIControlStateNormal];
    [self.loginVKButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
    self.loginVKButton.hidden = NO;
    [self.vkView addSubview:self.loginVKButton];
    [self refreshButtonState];
    
    self.postVKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.postVKButton addTarget:self action:@selector(postImageWithTextAndLink) forControlEvents:UIControlEventTouchUpInside];
    self.postVKButton.frame = CGRectMake (self.vkView.frame.size.width/2 - 58, 130, 117, 27);
    [self.postVKButton setBackgroundImage:[UIImage imageNamed:@"vkActionButton.png"] forState:UIControlStateNormal];
    self.postVKButton.hidden = YES;
    [self.postVKButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.vkView addSubview:self.postVKButton];
}

- (void)refreshButtonState
{
    if (![_vkontakte isAuthorized])
    {
        self.loginVKButton.frame = CGRectMake(self.vkView.frame.size.width/2 - 58, 100, 117, 27);
        [self.loginVKButton setTitle:@"LogIn"
                            forState:UIControlStateNormal];
        self.postVKButton.hidden = YES;
    }
    else
    {
        self.loginVKButton.frame = CGRectMake(self.vkView.frame.size.width/2 - 58, 70, 117, 27);
        [self.loginVKButton setTitle:@"LogOut"
                            forState:UIControlStateNormal];
        self.postVKButton.hidden = NO;
    }
}

- (void)loginPressed
{
    if (![_vkontakte isAuthorized])
    {
        [_vkontakte authenticate];
    }
    else
    {
        [_vkontakte logout];
    }
}

- (void)postImageWithTextAndLink
{
    [_vkontakte postImageToWall:[UIImage imageNamed:@"test.jpg"]
                           text:@"Vkontakte iOS SDK Trololo"
                           link:[NSURL URLWithString:@"https://www.ex.ua"]];
}

- (void)vkontakteDidFinishPostingToWall:(NSDictionary *)responce
{
    NSLog(@"%@", responce);
    UIAlertView *alertVK = [[UIAlertView alloc] initWithTitle:nil message:@"Posted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertVK show];
    [self.vkView removeFromSuperview];
}

#pragma mark - VkontakteDelegate

- (void)vkontakteDidFailedWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showVkontakteAuthController:(UIViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        controller.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkontakteAuthControllerDidCancelled
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)vkontakteDidFinishLogin:(Vkontakte *)vkontakte
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self refreshButtonState];
}

- (void)vkontakteDidFinishLogOut:(Vkontakte *)vkontakte
{
    [self refreshButtonState];
}
@end
