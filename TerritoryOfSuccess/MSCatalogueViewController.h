#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSCatalogueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, WsCompleteDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *productAndBonusesControl;
- (IBAction)segmentPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
