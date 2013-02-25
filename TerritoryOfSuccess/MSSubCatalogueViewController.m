#import "MSSubCatalogueViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSSubCatalogueCell.h"
#import "MSDetailViewController.h"
#import "SVProgressHUD.h"

@interface MSSubCatalogueViewController ()
@property (strong, nonatomic) MSAPI *api;
@property NSArray *arrayOfProducts;
@property NSDictionary *brandDictionaryIfWeComeFromBrandsSegment;
@property int productsCounter;
@property int tempBrandId;
@property int tempCategoryId;
@end

@implementation MSSubCatalogueViewController
@synthesize arrayOfProducts;
@synthesize productsCounter = _productsCounter;
@synthesize productsTableView;
@synthesize brandDictionaryIfWeComeFromBrandsSegment = _brandDictionaryIfWeComeFromBrandsSegment;
@synthesize tempBrandId = _tempBrandId;
@synthesize tempCategoryId = _tempCategoryId;

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
    [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadProductsKey",nil)];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.api getProductsWithOffset:0 withBrandId:self.tempBrandId withCategoryId:self.tempCategoryId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Метод вызываемый при переходе на этот контроллер
-(void) sentWithBrandId:(int)brandId withCategoryId:(int)categoryId
{
    self.tempBrandId = brandId;
    self.tempCategoryId = categoryId;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self productsCounter];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"subCatalogueCellIdentifier";
    MSSubCatalogueCell *cell = [[self productsTableView] dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MSSubCatalogueCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.productName.text = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"title"];
    [cell.productSmallImage setImageWithURL:[[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] valueForKey:@"small"] placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    cell.productRatingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dstar.png",[[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"rating"]integerValue]]];
    
    if([[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"brand"])
    {
        cell.productBrandName.text = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"brand"] valueForKey:@"title"];
    }
    else
    {
        cell.productBrandName.text = [self.brandDictionaryIfWeComeFromBrandsSegment valueForKey:@"title"];
    }
    
    //на экспорт в MSDetailViewController
    cell.productAdviceNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"advises"] integerValue];
    cell.productCommentsNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"comments"] integerValue];
    cell.productRatingNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"rating"] integerValue];
    cell.productBigImageURL = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] valueForKey:@"big"];
    cell.productDesctiptionText = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"content"];
    cell.productId = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"id"]integerValue];
    cell.productNumberInList = indexPath.row;
    
    cell.tag = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *currentCell = [self.productsTableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toDetailView" sender:currentCell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetailView"])
    {
        MSSubCatalogueCell *currentCell = sender;
        [segue.destinationViewController sentProductName:currentCell.productName.text
                                                   andId:currentCell.productId
                                               andRating:currentCell.productRatingNumber
                                       andCommentsNumber:currentCell.productCommentsNumber
                                        andAdvisesNumber:currentCell.productAdviceNumber
                                             andImageURL:currentCell.productBigImageURL
                                      andDescriptionText:currentCell.productDesctiptionText
                                         andNumberInList:currentCell.productNumberInList
                                              andBrandId:self.tempBrandId
                                           andCategoryId:self.tempCategoryId];
        
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
        self.productsCounter = [[self arrayOfProducts] count];
        self.brandDictionaryIfWeComeFromBrandsSegment = [dictionary valueForKey:@"brand"];
    }
    [[self productsTableView] reloadData];
}
@end
