#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSCatalogueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, WsCompleteDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *categoryAndBrandsControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)segmentPressed:(id)sender;
@end
