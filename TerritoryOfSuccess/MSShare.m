#import "MSShare.h"
@interface MSShare()

@property (nonatomic) SLComposeViewController *slComposeSheet;

@end

@implementation MSShare
@synthesize slComposeSheet = _slComposeSheet;

- (void)shareOnFacebookWithText:(NSString *)shareText
                    withImage:(UIImage *)shareImage
        currentViewController:(UIViewController *)viewController;
{
    if ([SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook])
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
    if ([SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter])
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

@end
