#import "MSCatalogueViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MSSubCatalogueViewController.h"
#import "MSBrandsAndCategoryCell.h"
#import "SVProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MSCatalogueViewController ()

@property (strong, nonatomic) NSArray *arrayOfCategories;
@property (strong, nonatomic) NSArray *arrayOfBrands;
@property (strong, nonatomic) MSAPI *api;
@property (strong, nonatomic) NSMutableData *receivedData;
@property int numberOfRows;

@end

@implementation MSCatalogueViewController
@synthesize tableView = _tableView;
@synthesize api = _api;
@synthesize arrayOfBrands = _arrayOfBrands;
@synthesize arrayOfCategories = _arrayOfCategories;
@synthesize numberOfRows = _numberOfRows;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    [self.categoryAndBrandsControl setTitle:NSLocalizedString(@"CategoriesKey", nil) forSegmentAtIndex:0];
    [self.categoryAndBrandsControl setTitle:NSLocalizedString(@"BrandsKey", nil) forSegmentAtIndex:1];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadCategoriesKey",nil)];
    [self.api getCategories];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    [self.tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self makeWrightSegmentColor];
}

#pragma marl ScrollView Delegate Methods
- (void)scrollViewWillBeginDragging:(UITableView *)tableView
{
    [[self categoryAndBrandsControl] setUserInteractionEnabled:NO];
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView
{
    [[self categoryAndBrandsControl] setUserInteractionEnabled:YES];
}
#pragma mark SegmentControl
// Изменение цвета СегментКонтролa при нажатии
- (void)makeWrightSegmentColor
{
    // выбраны категории
    if (self.categoryAndBrandsControl.selectedSegmentIndex == 0)
    {
       [[self.categoryAndBrandsControl.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[self.categoryAndBrandsControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }
    // выбраны бренды
    else
    {
        [[self.categoryAndBrandsControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[self.categoryAndBrandsControl.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }
}

- (IBAction)segmentPressed:(id)sender
{
    [self makeWrightSegmentColor];
    // запретить использование сегмент контрола до окончания дозагрузки информации (защита от идиота)
    [self.categoryAndBrandsControl setUserInteractionEnabled:NO];
    if (self.categoryAndBrandsControl.selectedSegmentIndex == 0)
    {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadCategoriesKey",nil)];
        [[self api] getCategories];
    }
    else
    {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadBrandsKey",nil)];
        [[self api] getFiveBrandsWithOffset:0];
    }
}

#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSBrandsAndCategoryCell *cell;
    static NSString *myIdentifier = @"cellIdentifier";
    cell = [[self tableView] dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[MSBrandsAndCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    }
    
//Проверка на СегментКонтрол и подгрузка соответствующего контента в ячейки
    //категории
    if (self.categoryAndBrandsControl.selectedSegmentIndex == 0)
    {
        cell.categoryOrBrandName.text = [[[self arrayOfCategories] objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.categoryOrBrandImage.image = [UIImage imageNamed:@"bag.png"];
        cell.categoryOrBrandNumber.text = [NSString stringWithFormat:@"%d", [[[[self arrayOfCategories] objectAtIndex:indexPath.row] valueForKey:@"count"]integerValue]];
        cell.tag = [[[[self arrayOfCategories] objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }
    //бренды
    else
    {
        cell.categoryOrBrandName.text = [[_arrayOfBrands objectAtIndex:indexPath.row] valueForKey:@"title"];
        [cell.categoryOrBrandImage setImageWithURL:[[[self arrayOfBrands] objectAtIndex:indexPath.row]valueForKey:@"image"]];
        cell.categoryOrBrandNumber.text = [NSString stringWithFormat:@"%d",[[[[self arrayOfBrands] objectAtIndex:indexPath.row] valueForKey:@"count"]integerValue]];
        cell.tag = [[[[self arrayOfBrands] objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toSubCatalogue" sender:[[self tableView] cellForRowAtIndexPath:indexPath]];
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableView *)sender
{
    if([segue.identifier isEqualToString:@"toSubCatalogue"])
    {
        if (self.categoryAndBrandsControl.selectedSegmentIndex == 0)
        {
            [segue.destinationViewController sentWithBrandId:0 withCategoryId:sender.tag];
        }
        else
        {
            [segue.destinationViewController sentWithBrandId:sender.tag withCategoryId:0];
        }
    }
}

#pragma mark Web-delegate
- (MSAPI *) api
{
    if(!_api){
        _api = [[MSAPI alloc]init];
        [_api setDelegate:self];
    }
    return _api;
}

- (void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if (type == kCategories)
    {
        self.arrayOfCategories = [dictionary valueForKey:@"list"];
        self.numberOfRows = [[self arrayOfCategories] count];
    }
    
    if (type == kBrands)
    {
        self.arrayOfBrands = [dictionary valueForKey:@"list"];
        self.numberOfRows = [[self arrayOfBrands] count];
    }
    
    [[self tableView] reloadData];
    [self.categoryAndBrandsControl setUserInteractionEnabled:YES];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];

}

@end
