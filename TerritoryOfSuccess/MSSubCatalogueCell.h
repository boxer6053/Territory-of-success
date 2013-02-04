#import <UIKit/UIKit.h>

@interface MSSubCatalogueCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productSmallImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productBrandName;
@property (strong, nonatomic) IBOutlet UIImageView *productRatingImage;
@property (nonatomic) int productAdviceNumber;
@property (nonatomic) int productCommentsNumber;
@property (nonatomic) int productRatingNumber;
@property (strong, nonatomic) NSString *productBigImageURL;
@property (strong, nonatomic) NSString *productDesctiptionText;
@end
