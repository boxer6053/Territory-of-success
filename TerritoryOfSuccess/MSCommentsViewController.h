#import <UIKit/UIKit.h>
#import "MSAddCommentView.h"
#import "MSAPI.h"

@interface MSCommentsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AddingCommentDelegate, UIAlertViewDelegate, UIScrollViewDelegate, WsCompleteDelegate>
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;
@property (strong, nonatomic) NSMutableArray *commentNew;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addCommentButton;

- (IBAction)addComment:(id)sender;
- (void)sentProductId:(int)sentProductId isFromBonus:(BOOL)bonus;
- (void)closeAddingCommentSubviewWithAdditionalActions;
@end
