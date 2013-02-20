#import <UIKit/UIKit.h>
#import "MSAskViewController.h"
#import "MSAPI.h"
@interface MSCreateQuestionViewController : UIViewController <UIGestureRecognizerDelegate, AddingRequestStringDelegate, WsCompleteDelegate>
@property (strong, nonatomic) NSArray *arrayOfViews;
@property (strong, nonatomic) NSMutableString *requestString;
- (IBAction)addMoreProduct:(id)sender;
@property (strong, nonatomic) NSMutableArray *gettedImages;
@property (strong, nonatomic) NSString *response;
@property (nonatomic) int upperID;
@property (nonatomic) int savedIndex;
- (IBAction)startButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *askButton;
@property (strong, nonatomic) NSArray *arrayOfProducts;
@end
