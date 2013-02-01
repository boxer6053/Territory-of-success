#import <Foundation/Foundation.h>
#import <Social/Social.h>

@interface MSShare : NSObject

- (void)shareOnFacebookWithText:(NSString *)shareText
                      withImage:(UIImage *)shareImage
          currentViewController:(UIViewController *)viewController;

- (void)shareOnTwitterWithText:(NSString *)shareText
                     withImage:(UIImage *)shareImage
         currentViewController:(UIViewController *)viewController;
@end
