#import "MSShare.h"
#import "Vkontakte.h"
#import <QuartzCore/QuartzCore.h>

@interface MSShare()
@property (nonatomic, strong) SLComposeViewController *slComposeSheet;
@property (nonatomic) Vkontakte *vkontakte;
@property (nonatomic) UIButton *loginVKButton;
@property (nonatomic) UIButton *postVKButton;
@end

@implementation MSShare
@synthesize vkontakte = _vkontakte;
@synthesize slComposeSheet = _slComposeSheet;
@synthesize loginVKButton = _loginVKButton;
@synthesize postVKButton = _postVKButton;
@synthesize vkView = _vkView;
@synthesize vkBackgroundView = _vkBackgroundView;
@synthesize mainView = _mainView;

- (void)shareOnFacebookWithText:(NSString *)shareText
                    withImage:(UIImage *)shareImage
        currentViewController:(UIViewController *)viewController;
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        self.slComposeSheet = [[SLComposeViewController alloc]init];
        self.slComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [self.slComposeSheet setInitialText:shareText];
        [self.slComposeSheet addImage:shareImage];
        [viewController presentViewController:self.slComposeSheet animated:YES completion:nil];
        [self slComposeSheetHandlerMethod];
    }
}

- (void)shareOnTwitterWithText:(NSString *)shareText
                      withImage:(UIImage *)shareImage
          currentViewController:(UIViewController *)viewController;
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        self.slComposeSheet = [[SLComposeViewController alloc]init];
        self.slComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [self.slComposeSheet setInitialText:shareText];
        [self.slComposeSheet addImage:shareImage];
        [self.slComposeSheet addURL:[NSURL URLWithString:@"id-bonus.com"]];
        [viewController presentViewController:self.slComposeSheet animated:YES completion:nil];
        [self slComposeSheetHandlerMethod];

    }
}

- (void) slComposeSheetHandlerMethod
{
    [self.slComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result)
     {
         switch (result)
         {
             case SLComposeViewControllerResultCancelled:
                 NSLog(@"Post cancelled");
                 break;
                 
             case SLComposeViewControllerResultDone:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Posted successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alertView show];
             }
                 break;
         }
     }];

}
- (void)shareOnVK
{
    _vkontakte = [Vkontakte sharedInstance];
    _vkontakte.delegate = self;
    
    self.vkBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    [self.vkBackgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [UIView animateWithDuration:0.4 animations:^
    {
        [self.vkBackgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    }];
    [self addSubview:self.vkBackgroundView];
    
    UITapGestureRecognizer *singleCloseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeVKView)];
    [self.vkBackgroundView addGestureRecognizer:singleCloseTap];
    
    self.vkView = [[UIView alloc] initWithFrame:CGRectMake(70, 100, 180, 195)];
    [[self vkView] setBackgroundColor:[UIColor whiteColor]];
    [[self vkView] setAlpha:0];
    [self.vkView.layer setBorderColor:[UIColor colorWithRed:75/255.0 green:110/255.0 blue:148/255.0 alpha:0].CGColor];
    [UIView animateWithDuration:0.4 animations:^
     {
         [[self vkView]setAlpha:1];
     }];
    [self.vkView.layer setCornerRadius:10];
    [self.vkView.layer setBorderWidth:1.0f];
    self.vkView.clipsToBounds = YES;
    [self addSubview:self.vkView];

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
    if (![_vkontakte isAuthorized])
        self.postVKButton.hidden = YES;
    else self.postVKButton.hidden = NO;
    [self.postVKButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.vkView addSubview:self.postVKButton];
}

- (void)closeVKView
{
    [UIView animateWithDuration:0.4 animations:^{
        [self.vkBackgroundView setAlpha:0];
        [self.vkView setAlpha:0];
    } completion:^(BOOL finished){
            [[self vkBackgroundView] removeFromSuperview];
            [[self vkView]removeFromSuperview];
    }];

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
    [[self mainView] dismissViewControllerAnimated:YES completion:nil];
}

- (void)showVkontakteAuthController:(UIViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        controller.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [[self mainView] presentViewController:controller animated:YES completion:nil];
    
}

- (void)vkontakteAuthControllerDidCancelled
{
    [[self mainView] dismissViewControllerAnimated:YES completion:nil];
}

- (void)vkontakteDidFinishLogin:(Vkontakte *)vkontakte
{
    [[self mainView] dismissViewControllerAnimated:YES completion:nil];
    [self refreshButtonState];
}

- (void)vkontakteDidFinishLogOut:(Vkontakte *)vkontakte
{
    [self refreshButtonState];
}
@end
