#import <UIKit/UIKit.h>

@protocol AddingQuestionDelegate <NSObject>

-(void) addNewQuestion:(NSArray *) array;

@end
@interface MSCreateQuestionViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)askQuestionButton:(id)sender;
@property (weak, nonatomic) NSString *productTitle;
@property (weak, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic) id <AddingQuestionDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *sentArray;
- (IBAction)cancelAction:(id)sender;

@end
