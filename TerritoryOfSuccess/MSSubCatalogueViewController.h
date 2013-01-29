#import <UIKit/UIKit.h>
#import "MSAPI.h"
@interface MSSubCatalogueViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, WsCompleteDelegate>

@property (strong, nonatomic) IBOutlet UITableView *productsTableView;

-(void) sentWithBrandId:(int)brandId withCategoryId:(int)categoryId;

@end
