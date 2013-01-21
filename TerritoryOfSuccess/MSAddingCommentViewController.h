#import <UIKit/UIKit.h>

@interface MSAddingCommentViewController : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UINavigationItem *navigation;
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UITextView *inputText;
@property (strong, nonatomic) IBOutlet UIImageView *starImage;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UIView *containView;

- (IBAction)starStepper:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end
