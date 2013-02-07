#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import "Vkontakte.h"

@interface MSShare : UIView <VkontakteDelegate>
@property (nonatomic) UIViewController *mainView;
@property (nonatomic) UIView *vkView;
@property (nonatomic) UIView *vkBackgroundView;

- (void)shareOnFacebookWithText:(NSString *)shareText
                      withImage:(UIImage *)shareImage
          currentViewController:(UIViewController *)viewController;

- (void)shareOnTwitterWithText:(NSString *)shareText
                     withImage:(UIImage *)shareImage
         currentViewController:(UIViewController *)viewController;

- (void)shareOnVKWithText:(NSString *)shareText withImage:(NSString *)shareImage;
@end
