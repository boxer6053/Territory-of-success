#import <UIKit/UIKit.h>
#import "MSAPI.h"
@interface MSDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *likeView;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UITextView *productDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;

@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *advisesLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ratingImage;
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;

@property (strong, nonatomic) IBOutlet UIButton *fbButton;
- (IBAction)fbButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *twButton;
- (IBAction)twButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *vkButton;
- (IBAction)vkButtonPressed:(id)sender;

- (IBAction)shareButtonPressed:(id)sender;

- (void)sentProductName:(NSString *)name
              andRating:(int)rating
      andCommentsNumber:(int)comments
       andAdvisesNumber:(int)advises
            andImageURL:(NSString *)imageURL
     andDescriptionText:(NSString *) descriptionText;
@end
