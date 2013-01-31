#import "MSCatalogueViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MSSubCatalogueViewController.h"
#import "MSBrandsAndCategoryCell.h"

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
    [self.api getCategories];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        NSLog(@"568");
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        NSLog(@"480");
    }
    [self.tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self makeWrightSegmentColor];
}

#pragma mark SegmentControl
-(void) makeWrightSegmentColor{
// Изменение цвета СегментКонтролa
    if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
       [[self.productAndBonusesControl.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[self.productAndBonusesControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }else{
        [[self.productAndBonusesControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0]];
        [[self.productAndBonusesControl.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    }
}

- (IBAction)segmentPressed:(id)sender
{
    [self makeWrightSegmentColor];
    [self.productAndBonusesControl setUserInteractionEnabled:NO];
    if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
        [[self api] getCategories];
    }else{
        [[self api] getFiveBrandsWithOffset:0];
    }
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfRows];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSBrandsAndCategoryCell *cell;
    static NSString* myIdentifier = @"cellIdentifier";
    cell = [[self tableView] dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[MSBrandsAndCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    }
    
//Проверка на СегментКонтрол и подгрузка соответствующего контента в ячейки
    if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
        cell.categoryOrBrandName.text = [[_arrayOfCategories objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.categoryOrBrandImage.image = [UIImage imageNamed:@"bag.png"];
        
        cell.tag = [[[[self arrayOfCategories] objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }
    
    if (self.productAndBonusesControl.selectedSegmentIndex == 1) {
        cell.categoryOrBrandName.text = [[_arrayOfBrands objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.categoryOrBrandImage.image = [UIImage imageNamed:@"brandLogoExample.png"];
        
        cell.tag = [[[[self arrayOfBrands] objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * currentCell = [[self tableView] cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toSubCatalogue" sender:currentCell];
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toSubCatalogue"])
    {
        UITableViewCell *currentCell = sender;
        if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
            [segue.destinationViewController sentWithBrandId:0 withCategoryId:currentCell.tag];
        } else {
            [segue.destinationViewController sentWithBrandId:currentCell.tag withCategoryId:0];
        }
    }
}

#pragma mark Web-delegate
- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        [_api setDelegate:self];
    }
    return _api;
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
    if (type == kCategories){
        self.arrayOfCategories = [dictionary valueForKey:@"list"];
        self.numberOfRows = [[self arrayOfCategories] count];
    }
    
    if (type == kBrands){
        self.arrayOfBrands = [dictionary valueForKey:@"list"];
        self.numberOfRows = [[self arrayOfBrands] count];
    }
    [[self tableView] reloadData];
    [self.productAndBonusesControl setUserInteractionEnabled:YES];

}
@end
