#import "MSShare.h"
@interface MSShare()
{
    SLComposeViewController *slComposeSheet;
}
@end

@implementation MSShare

- (void)shareOnFacebookWithText:(NSString *)shareText
                    withImage:(UIImage *)shareImage
        currentViewController:(UIViewController *)viewController;
{
    if ([SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook])
    {
        slComposeSheet = [[SLComposeViewController alloc]init];
        slComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [slComposeSheet setInitialText:shareText];
        [slComposeSheet addImage:shareImage];
        [slComposeSheet addURL:[NSURL URLWithString:@"id-bonus.com"]];
        [viewController presentViewController:slComposeSheet animated:YES completion:nil];
        [self slComposeSheetHandlerMethod];
    }
}

- (void)shareOnTwitterWithText:(NSString *)shareText
                      withImage:(UIImage *)shareImage
          currentViewController:(UIViewController *)viewController;
{
    if ([SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter])
    {
        slComposeSheet = [[SLComposeViewController alloc]init];
        slComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [slComposeSheet setInitialText:shareText];
        [slComposeSheet addImage:shareImage];
        [viewController presentViewController:slComposeSheet animated:YES completion:nil];
        [self slComposeSheetHandlerMethod];

    }
}

- (void) slComposeSheetHandlerMethod
{
    [slComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result)
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
