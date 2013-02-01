#import "MSSubCatalogueViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSSubCatalogueCell.h"
#import "MSDetailViewController.h"

@interface MSSubCatalogueViewController ()
@property (strong, nonatomic) MSAPI *api;
@property NSArray *arrayOfProducts;
@property int productsCounter;
@end

@implementation MSSubCatalogueViewController
@synthesize arrayOfProducts;
@synthesize productsCounter;
@synthesize productsTableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.productsTableView.delegate = self;
    self.productsTableView.dataSource = self;
    [self.productsTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Метод вызываемый при переходе на этот контроллер
-(void) sentWithBrandId:(int)brandId withCategoryId:(int)categoryId
{
    [self.api getProductsWithOffset:0 withBrandId:brandId withCategoryId:categoryId];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productsCounter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"subCatalogueCellIdentifier";
    MSSubCatalogueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MSSubCatalogueCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.productName.text = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"title"];
    [cell.productImage setImageWithURL:[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    cell.productRatingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dstar.png",[[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"rating"]integerValue]]];
    
    //на экспорт в MSDetailViewController
    cell.productAdviceNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"advises"] integerValue];
    cell.productCommentsNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"comments"] integerValue];
    cell.productRatingNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"rating"] integerValue];
    cell.productImageURL = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"];
    cell.productDesctiptionText = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"content"];
    
    cell.tag = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *currentCell = [self.productsTableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toDetailView" sender:currentCell];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetailView"])
    {
        MSSubCatalogueCell *currentCell = sender;
        [segue.destinationViewController sentProductName:currentCell.productName.text andRating:currentCell.productRatingNumber andCommentsNumber:currentCell.productCommentsNumber andAdvisesNumber:currentCell.productAdviceNumber andImageURL:currentCell.productImageURL andDescriptionText:currentCell.productDesctiptionText];
    }
}
#pragma mark - Web Methods
- (MSAPI *) api
{
    if(!_api)
    {
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if (type == kCatalog)
    {
        self.arrayOfProducts = [dictionary valueForKey:@"list"];
        for(int i = 0; i < self.arrayOfProducts.count; i++)
        {
            NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.productsCounter inSection:0]];
            self.productsCounter++;
            [self.productsTableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:NO];
        }
    }
}
@end
