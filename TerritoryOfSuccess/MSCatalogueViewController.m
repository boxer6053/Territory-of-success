#import "MSCatalogueViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MSSubCatalogueViewController.h"

@interface MSCatalogueViewController ()

@property (strong, nonatomic) NSArray *arrayOfCategories;
@property (strong, nonatomic) NSArray *arrayOfBrands;
@property (strong, nonatomic) MSAPI *api;
@property (strong, nonatomic) NSMutableData *receivedData;
@property int rowsCounter, brandsCounter;
@end

@implementation MSCatalogueViewController
@synthesize tableView = _tableView;
@synthesize api = _api;
@synthesize arrayOfBrands = _arrayOfBrands;
@synthesize arrayOfCategories = _arrayOfCategories;
@synthesize rowsCounter,brandsCounter;

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
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    _tableView.layer.cornerRadius = 10;
    [_tableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_tableView.layer setBorderWidth:1.0f];
    [_tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor];
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

- (IBAction)segmentPressed:(id)sender {
    self.rowsCounter = 0;
    self.brandsCounter = 0;
    [self makeWrightSegmentColor];
    [_tableView reloadData];
    if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
            [self.api getCategories];
    }else{
            [self.api getFiveBrandsWithOffset:3];
    }
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.productAndBonusesControl.selectedSegmentIndex == 0)
         return self.rowsCounter;
    else return self.brandsCounter;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString* myIdentifier = @"cellIdentifier";
    cell = [_tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    
//Проверка на СегментКонтрол и подгрузка соответствующего контента в ячейки
    if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = [[_arrayOfCategories objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.imageView.image = [UIImage imageNamed:@"bag.png"];
        cell.tag = [[[_arrayOfCategories objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }
    
    if (self.productAndBonusesControl.selectedSegmentIndex == 1) {
        cell.textLabel.text = [[_arrayOfBrands objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.imageView.image = nil;
        cell.tag = [[[_arrayOfBrands objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * currentCell = [_tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"toSubCatalogue" sender:currentCell];
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
        _api.delegate = self;
    }
    return _api;
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
    if (type == kCategories){
        _arrayOfCategories = [dictionary valueForKey:@"list"];
        for (int i = 0; i < _arrayOfCategories.count; i++){
            NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.rowsCounter inSection:0]];
            self.rowsCounter++;
            [_tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:NO];
        }
    }
    
    if (type == kBrands){
        _arrayOfBrands = [dictionary valueForKey:@"list"];
        for (int i = 0; i < _arrayOfBrands.count; i++){
            NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.brandsCounter inSection:0]];
            self.brandsCounter++;
            [_tableView insertRowsAtIndexPaths:insertIndexPath withRowAnimation:NO];
        }
    
    }
}
@end
