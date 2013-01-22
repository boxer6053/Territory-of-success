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
    NSArray *firstComment = [NSArray arrayWithObjects:@"Pavel",@"Продукт - полное ***",[NSNumber numberWithInteger:1], nil];
    NSArray *secondComment = [NSArray arrayWithObjects:@"Lyohaness",@"Real shit, dudes! Otveechaju",[NSNumber numberWithInteger:1], nil];
    NSArray *thirdComment =[NSArray arrayWithObjects:@"Andrew",@"This is bullshit, but i like it!",[NSNumber numberWithInteger:3], nil];
    _commentsArray = [NSMutableArray arrayWithObjects:firstComment,secondComment,thirdComment, nil];

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
    return [_commentsArray count];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (IBAction)addComment:(id)sender {
    [self performSegueWithIdentifier:@"toAddingCommentView" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        MSAddingCommentViewController *acvc = [segue destinationViewController];
        acvc.delegate = self;
}

-(void) addNewComment:(NSArray *)array{
    [_commentsArray addObject:array];
    [self.commentTableView reloadData];
}
@end
