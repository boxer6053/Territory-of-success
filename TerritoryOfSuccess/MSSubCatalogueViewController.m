#import "MSSubCatalogueViewController.h"

@interface MSSubCatalogueViewController ()

@end

@implementation MSSubCatalogueViewController

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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"subCatalogueCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Название товара";
    cell.detailTextLabel.text = @"Короткое описание";
    cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    
    return cell;
 
    return cell;
}
-(void) writeANumber:(int)trololo{
    NSLog(@"DGHFDGHDGHFGHFGHFGHFGH %d",trololo);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailView" sender:self];
}

#pragma mark - Web mathods
//- (MSAPI *) api{
//    if(!_api){
//        _api = [[MSAPI alloc]init];
//        _api.delegate = self;
//    }
//    return _api;
//}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
    
}
@end
