#import <UIKit/UIKit.h>

@interface MSDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *detailImage;
@property (strong, nonatomic) IBOutlet UIView *likeView;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UITextView *productDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *questionsButton;
@property (strong, nonatomic) IBOutlet UIButton *commentsButton;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
