#import "MSSubCatalogueViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.productsTableView.delegate = self;
    self.productsTableView.dataSource = self;
    [self.productsTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    //[self.productsTableView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productsCounter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"subCatalogueCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"title"];
    [cell.imageView setImageWithURL:[[self.arrayOfProducts objectAtIndex:indexPath.row] valueForKey:@"image"] placeholderImage:[UIImage imageNamed:@"photo_camera_1.png"]];
    
    return cell;
}

-(void) sentWithBrandId:(int)brandId withCategoryId:(int)categoryId{
    [self.api getProductsWithOffset:0 withBrandId:brandId withCategoryId:categoryId];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailView" sender:self];
}

#pragma mark - Web methods
- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
    if (type == kCatalog){
        self.arrayOfProducts = [dictionary valueForKey:@"list"];
        for(int i = 0; i < self.arrayOfProducts.count; i++){
            NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.productsCounter inSection:0]];
            self.productsCounter++;
            [self.productsTableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:NO];
        }
    }
}
@end
