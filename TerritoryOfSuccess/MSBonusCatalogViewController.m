//
//  MSBonusCatalogViewController.m
//  TerritoryOfSuccess
//
//  Created by Alex on 2/27/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSBonusCatalogViewController.h"
#import "MSBrandsAndCategoryCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MSBonusSubCatalogViewController.h"

@interface MSBonusCatalogViewController ()
{
}

@property (strong, nonatomic) MSAPI *api;
@property (strong, nonatomic) NSArray *categoriesList;
@property (strong, nonatomic) NSArray *subCategoriesList;
@property int selectedCategoryId;

@end

@implementation MSBonusCatalogViewController

@synthesize api = _api;
@synthesize categoriesList = _categoriesList;
@synthesize subCategoriesList = _subCategoriesList;
@synthesize selectedCategoryId = _selectedCategoryId;

- (MSAPI *)api
{
    if(!_api)
    {
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

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
    //[self.api getBonusCategories];
    [self.bonusCatalog setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]]];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bonusCatalog.frame.size.width, 1)];
    self.bonusCatalog.tableFooterView = footerView;
    self.bonusCatalog.tableFooterView.hidden = YES;
    self.bonusCatalog.tableFooterView.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCategoriesList:(NSArray *)categoriesList
{
    _categoriesList = categoriesList;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toBonusSubCatalog"])
    {
        [segue.destinationViewController setSubCategories:self.subCategoriesList andCategoryId:self.selectedCategoryId];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoriesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"bonusCatalogCell";
    MSBrandsAndCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.categoryOrBrandName.text = [[self.categoriesList objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.categoryOrBrandNumber.text = [[self.categoriesList objectAtIndex:indexPath.row] valueForKey:@"cnt"];
    cell.categoryOrBrandImage.image = [UIImage imageNamed:@"bag.png"];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSBrandsAndCategoryCell *cell = (MSBrandsAndCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(![cell.categoryOrBrandNumber.text isEqualToString:@"0"])
    {
        self.selectedCategoryId = [[[self.categoriesList objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
        [self.api getBonusSubCategories:self.selectedCategoryId withOffset:0];
    }
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if(type == kBonusSubCategories)
    {
        if([[dictionary valueForKey:@"status"] isEqualToString:@"ok"])
        {
            self.subCategoriesList = [dictionary objectForKey:@"list"];
            [self performSegueWithIdentifier:@"toBonusSubCatalog" sender:self];
        }
    }
}

@end
