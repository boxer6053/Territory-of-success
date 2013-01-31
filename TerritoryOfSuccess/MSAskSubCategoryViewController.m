//
//  MSAskSubCategoryViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAskSubCategoryViewController.h"

@interface MSAskSubCategoryViewController ()
@property (strong, nonatomic) NSArray *subCategoryArray;
@property int subCategoryCount;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;
@end

@implementation MSAskSubCategoryViewController
@synthesize askSubCategTable = _askSubCategTable;
@synthesize parentID1 = _parentID1;
@synthesize receivedData = _receivedData;
@synthesize api = _api;
@synthesize subCategoryArray = _subCategoryArray;
@synthesize subCategoryCount = _subCategoryCount;



- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View DID LOAD");
    NSInteger integer = [_parentID1 integerValue];
    NSLog(@"integer %d",integer);
    [self.api getQuestionsWithParentID:integer];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    _askSubCategTable.layer.cornerRadius = 10;
    [_askSubCategTable.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_askSubCategTable.layer setBorderWidth:1.0f];
    [_askSubCategTable.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subCategoryCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString* cellIdentifier = @"questCellID";
    cell = [_askSubCategTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[_subCategoryArray objectAtIndex:indexPath.row] valueForKey:@"title"];            cell.detailTextLabel.text = @"Оценка";
    return cell;
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)typefinished
{
    _askSubCategTable.delegate = self;
    _askSubCategTable.dataSource = self;
    if(typefinished == kQuestCateg)
    {
        NSLog(@"zzzzzzz %u", _subCategoryCount);
        _subCategoryArray = [dictionary valueForKey:@"list"];
        
        for (int i  = 0; i<_subCategoryArray.count; i++)
        {
            NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:_subCategoryCount inSection:0]];
            _subCategoryCount++;
            [_askSubCategTable insertRowsAtIndexPaths: insertIndexPath withRowAnimation:NO];
        }
        
        //  _questionsCount = 0;
        
        
        
    }
    
}


@end
