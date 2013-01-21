#import "MSCatalogueViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSCatalogueViewController ()

@end

@implementation MSCatalogueViewController
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
        NSLog(@"568");
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
        NSLog(@"480");
    }
    _tableView.layer.cornerRadius = 10;
    [_tableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [_tableView.layer setBorderWidth:1.0f];
    [_tableView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7].CGColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[self.productAndBonusesControl.subviews objectAtIndex:1] setTintColor:[UIColor colorWithRed:255.0/255.0 green:140/255.0 blue:0 alpha:1]];
    [[self.productAndBonusesControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)segmentPressed:(id)sender {
// Изменение цвета при переключении СегментКонтрола
    for (int i=0; i<[self.productAndBonusesControl.subviews count]; i++){
        
        if ([[self.productAndBonusesControl.subviews objectAtIndex:i]isSelected] ){
            
            UIColor *tintcolor=[UIColor colorWithRed:255.0/255.0 green:140.0/255.0 blue:0 alpha:1.0];
            [[self.productAndBonusesControl.subviews objectAtIndex:i] setTintColor:tintcolor];
                    } else {
                        UIColor *tintcolor=[UIColor blackColor]; // default color
                        [[self.productAndBonusesControl.subviews objectAtIndex:i] setTintColor:tintcolor];
                        }
           }
    
    if (self.productAndBonusesControl.selectedSegmentIndex == 0){
        [_tableView reloadData];
    } else {
        [_tableView reloadData];
    }
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    static NSString* myIdentifier = @"cellIdentifier";
    cell = [_tableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    
//Првоерка на СегментКонтрол и подгрузка соответствующего контента в ячейки
    if (self.productAndBonusesControl.selectedSegmentIndex == 0) {
        cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
        cell.textLabel.text = @"Название категории";
        cell.detailTextLabel.text = @"Описание";
    }
    
    if (self.productAndBonusesControl.selectedSegmentIndex == 1) {

        cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
        cell.textLabel.text = @"Название бренда";
        cell.detailTextLabel.text = @"Описание";
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toSubCatalogue" sender:self];
}
@end
