#import "MSCommentsViewController.h"
#import "MSCommentCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MSCommentsViewController ()
@end

@implementation MSCommentsViewController
@synthesize commentsArray = _commentsArray;
@synthesize commentNew = _commentNew;

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
    NSArray *firstComment = [NSArray arrayWithObjects:@"Pavel",@"Мне не понравился данный продукт",[NSNumber numberWithInteger:1], nil];
    NSArray *secondComment = [NSArray arrayWithObjects:@"Lyohaness",@"фу-фу-фу",[NSNumber numberWithInteger:1], nil];
    NSArray *thirdComment =[NSArray arrayWithObjects:@"Andrew",@"Нормальный продукт, на твердую 3!",[NSNumber numberWithInteger:3], nil];
    self.commentsArray = [NSMutableArray arrayWithObjects:firstComment,secondComment,thirdComment, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self commentsArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"commentsIdentifier";
    MSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MSCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSMutableString *name = [NSString stringWithFormat:@"%@",[[_commentsArray objectAtIndex:indexPath.row] objectAtIndex:0]];
    cell.commentatorName.text =[name stringByAppendingString:@" написал:"];
    
    cell.commentText.text = [[_commentsArray objectAtIndex:indexPath.row] objectAtIndex:1];
    
    NSString *imageName = [NSString stringWithFormat:@"%@star.png",[[_commentsArray objectAtIndex:indexPath.row] objectAtIndex:2]];
    cell.starsImage.image = [UIImage imageNamed:imageName];
    
    cell.starView.layer.cornerRadius = 10;
    [cell.starView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    return cell;
}


#pragma mark - Table view delegate
- (IBAction)addComment:(id)sender {
    [self performSegueWithIdentifier:@"toAddingCommentView" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        MSAddingCommentViewController *acvc = [segue destinationViewController];
        acvc.delegate = self;
}

-(void) addNewComment:(NSArray *)array{
    [[self commentsArray] addObject:array];
    [[self commentTableView] reloadData];
}
@end
