//
//  MSBonusSubCatalogViewController.m
//  TerritoryOfSuccess
//
//  Created by Alex on 2/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSBonusSubCatalogViewController.h"
#import "MSBrandsAndCategoryCell.h"

@interface MSBonusSubCatalogViewController ()

@property (strong, nonatomic) NSArray *subCategoriesList;
@property (strong, nonatomic) MSAPI *api;
@end

@implementation MSBonusSubCatalogViewController

@synthesize subCategoriesList = _subCategoriesList;
@synthesize subCatalogTableView = _subCatalogTableView;
@synthesize api = _api;

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
    [self.subCatalogTableView setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - setter for subCategories array
- (void)setSubCategoriesList:(NSArray *)subCategoriesList
{
    _subCategoriesList = subCategoriesList;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.subCategoriesList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"bonusSubCategoryCell";
    MSBrandsAndCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.categoryOrBrandName.text = [[self.subCategoriesList objectAtIndex:indexPath.row] valueForKey:@"title"];
    cell.categoryOrBrandNumber.text = [[self.subCategoriesList objectAtIndex:indexPath.row] valueForKey:@"cnt"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.api getBonusSubCategories:[[[self.subCategoriesList objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue]];
}

- (void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    
}

@end
