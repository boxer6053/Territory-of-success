#import <UIKit/UIKit.h>
#import "MSAddingCommentViewController.h"

@interface MSCommentsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AddingCommentDelegate>
@property (strong, nonatomic) NSMutableArray *commentsArray;
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;
@property (strong, nonatomic) NSMutableArray *commentNew;

- (IBAction)addComment:(id)sender;
@end
