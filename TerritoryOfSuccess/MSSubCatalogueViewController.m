#import "MSSubCatalogueViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSSubCatalogueCell.h"
#import "MSDetailViewController.h"
#import "SVProgressHUD.h"

@interface MSSubCatalogueViewController ()
{
    BOOL _isFromBonusCatalog;
}
@property (strong, nonatomic) MSAPI *api;
@property NSMutableArray *arrayOfProducts;
@property NSArray *lastloadedProductsArray;
@property NSDictionary *brandDictionaryIfWeComeFromBrandsSegment;
@property int productsCounter;
@property int tempBrandId;
@property int tempCategoryId;
@property int tempBonusCategoryId;
@property int tempProductsCounter;
@property (strong, nonatomic)  UIButton *footerButton;
@property BOOL isFirstTime;
@property BOOL insertedOperationFinishedTheyWork;

@end

@implementation MSSubCatalogueViewController
@synthesize arrayOfProducts;
@synthesize productsCounter = _productsCounter;
@synthesize productsTableView;
@synthesize brandDictionaryIfWeComeFromBrandsSegment = _brandDictionaryIfWeComeFromBrandsSegment;
@synthesize tempBrandId = _tempBrandId;
@synthesize tempCategoryId = _tempCategoryId;
@synthesize footerButton = _footerButton;
@synthesize lastloadedProductsArray = _lastloadedProductsArray;
@synthesize insertedOperationFinishedTheyWork = _insertedOperationFinishedTheyWork;

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
    self.isFirstTime = YES;
    self.productsTableView.delegate = self;
    self.productsTableView.dataSource = self;
    [self.productsTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]]];
    
    self.footerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.productsTableView.frame.size.width, 35)];
    [self.footerButton setTitle:NSLocalizedString(@"DownloadMoreKey", nil) forState:UIControlStateNormal];
    [self.footerButton addTarget:self action:@selector(moreProducts) forControlEvents:UIControlEventTouchDown];
    self.footerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    [self.footerButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4] forState:UIControlStateNormal];
    
    self.productsTableView.tableFooterView = self.footerButton;
    [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadProductsKey",nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Методы вызываемый при переходе на этот контроллер
-(void) sentWithBrandId:(int)brandId withCategoryId:(int)categoryId
{
    _isFromBonusCatalog = NO;
    self.tempBrandId = brandId;
    self.tempCategoryId = categoryId;
    [self.api getProductsWithOffset:0 withBrandId:self.tempBrandId withCategoryId:self.tempCategoryId];
}
- (void) sentWithBonusCategoryId:(int)categoryId
{
    _isFromBonusCatalog = YES;
    self.tempBonusCategoryId = categoryId;
    [self.api getBonusSubCategories:categoryId];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self tempProductsCounter];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"subCatalogueCellIdentifier";
    MSSubCatalogueCell *cell = [[self productsTableView] dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MSSubCatalogueCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.productName.text = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    if(_isFromBonusCatalog)
    {
        [cell.productSmallImage setImageWithURL:[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] placeholderImage:[UIImage imageNamed:@"placeholder_622*415.png"]];
    }
    else
    {
        [cell.productSmallImage setImageWithURL:[[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] valueForKey:@"small"] placeholderImage:[UIImage imageNamed:@"placeholder_622*415.png"]];
    }
    cell.productRatingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dstar.png",[[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"rating"]integerValue]]];
    NSString *price = [[NSString alloc]initWithString:[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"price"]];
    if (price.length == 0)
    {
        if([[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"brand"])
        {
            cell.productBrandName.text = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"brand"] valueForKey:@"title"];
        }
        else
        {
            cell.productBrandName.text = [self.brandDictionaryIfWeComeFromBrandsSegment valueForKey:@"title"];
        }
    }
    else
    {
        cell.prodactBrandLabel.text = @"Price:";
        cell.productBrandName.text = price;
    }
    
    //на экспорт в MSDetailViewController
    cell.productAdviceNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"advises"] integerValue];
    cell.productCommentsNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"comments"] integerValue];
    cell.productRatingNumber = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"rating"] integerValue];
    if (!_isFromBonusCatalog)
        cell.productBigImageURL = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] valueForKey:@"big"];
    else
    {
        cell.productBigImageURL = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"];
        cell.productPrice = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"price"] integerValue];
    }
    cell.productDesctiptionText = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"content"];
    cell.productId = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"id"]integerValue];
    cell.productNumberInList = indexPath.row;
    
    cell.tag = [[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    
    return cell;
}

- (void)moreProducts
{
    if (self.arrayOfProducts.count < self.productsCounter)
    {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadProductsKey",nil)];
        [self.api getProductsWithOffset:self.arrayOfProducts.count withBrandId:self.tempBrandId withCategoryId:self.tempCategoryId];
    }
    else
    {
        [self.footerButton setTitle:NSLocalizedString(@"AllProductsDownloadedKey",nil) forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.insertedOperationFinishedTheyWork)
    {
        if (self.productsTableView.contentOffset.y + 455 > self.productsTableView.contentSize.height)
        {
            [self moreProducts];
            self.insertedOperationFinishedTheyWork = NO;
        }
    }
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
        int offset;
        if (self.arrayOfProducts.count <= 5) offset = 0;
        else offset = (self.arrayOfProducts.count - self.lastloadedProductsArray.count);
        [segue.destinationViewController sentProductName:currentCell.productName.text
                                                   andId:currentCell.productId
                                               andRating:currentCell.productRatingNumber
                                       andCommentsNumber:currentCell.productCommentsNumber
                                        andAdvisesNumber:currentCell.productAdviceNumber
                                             andImageURL:currentCell.productBigImageURL
                                      andDescriptionText:currentCell.productDesctiptionText
                                         andNumberInList:currentCell.productNumberInList
                                              andBrandId:self.tempBrandId
                                           andCategoryId:self.tempCategoryId
                                            andOffset:offset];
        
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
    if (type == kCatalog || type == kBonusSubCategories)
    {
        if (self.isFirstTime)
        {
            self.arrayOfProducts = [[dictionary valueForKey:@"list"] mutableCopy];
            self.tempProductsCounter = [[self arrayOfProducts] count];
            self.productsCounter = [[dictionary valueForKey:@"count"] integerValue];
            if (self.productsCounter <= 20)
            {
                [[self productsTableView].tableFooterView setHidden:YES];
                [[self productsTableView].tableFooterView setUserInteractionEnabled:NO];
            }
            
            [[self productsTableView] reloadData];
            self.brandDictionaryIfWeComeFromBrandsSegment = [dictionary valueForKey:@"brand"];
            
            self.isFirstTime = NO;
        }
        else
        {
            [self.arrayOfProducts addObjectsFromArray:[dictionary valueForKey:@"list"]];
            self.lastloadedProductsArray = [dictionary valueForKey:@"list"];
            for (int i  = 0; i < self.lastloadedProductsArray.count; i++)
            {
                NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.tempProductsCounter++  inSection:0]];
                [self.productsTableView insertRowsAtIndexPaths: insertIndexPath withRowAnimation:NO];
            }
        }
        
        self.insertedOperationFinishedTheyWork = YES;
    }
}
@end
