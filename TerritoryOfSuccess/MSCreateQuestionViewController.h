#import <UIKit/UIKit.h>
#import "MSAskViewController.h"
#import "MSAPI.h"
@interface MSCreateQuestionViewController : UIViewController <UIGestureRecognizerDelegate, AddingRequestStringDelegate, WsCompleteDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *productView1;
@property (weak, nonatomic) IBOutlet UIImageView *productView2;
@property (weak, nonatomic) IBOutlet UIImageView *productView3;
@property (weak, nonatomic) IBOutlet UIImageView *productView4;
@property (weak, nonatomic) IBOutlet UIImageView *productView5;
@property (weak, nonatomic) IBOutlet UIImageView *productView6;
@property (strong, nonatomic) NSMutableString *requestString;
- (IBAction)addMoreProduct:(id)sender;
@property (strong, nonatomic) NSMutableArray *gettedImages;
- (IBAction)startButton:(id)sender;
@property (strong, nonatomic) NSArray *arrayOfProducts;
@end
