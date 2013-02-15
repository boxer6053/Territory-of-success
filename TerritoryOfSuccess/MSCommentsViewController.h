#import <UIKit/UIKit.h>
#import "MSAddCommentView.h"

@interface MSCommentsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AddingCommentDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray *commentsArray;
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;
@property (strong, nonatomic) NSMutableArray *commentNew;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addCommentButton;

- (IBAction)addComment:(id)sender;
- (void)sentProductId:(int)sentProductId;
- (void)closeAddingCommentSubviewWithAdditionalActions;
@end
