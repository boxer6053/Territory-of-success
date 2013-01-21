#import <UIKit/UIKit.h>

@interface MSAddingCommentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *navigation;
@property (strong, nonatomic) IBOutlet UITextView *inputText;
@property (strong, nonatomic) IBOutlet UIImageView *starImage;

- (IBAction)starStepper:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end
