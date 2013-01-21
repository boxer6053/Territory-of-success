#import <UIKit/UIKit.h>

@interface MSCommentsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *commentsArray;

- (IBAction)addComment:(id)sender;
@end
