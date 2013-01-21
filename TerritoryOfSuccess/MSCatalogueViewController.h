#import <UIKit/UIKit.h>

@interface MSCatalogueViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *productAndBonusesControl;
- (IBAction)segmentPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
