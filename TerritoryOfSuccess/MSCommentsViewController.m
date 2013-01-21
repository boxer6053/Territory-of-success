#import "MSCommentsViewController.h"
#import "MSCommentCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MSCommentsViewController ()

@end

@implementation MSCommentsViewController
@synthesize commentsArray = _commentsArray;

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
    NSArray *firstComment = [NSArray arrayWithObjects:@"Pavel",@"Продукт - полное ***", nil];
    NSArray *secondComment = [NSArray arrayWithObjects:@"Lehaness",@"Real shit, dudes! Otveechaju", nil];
    NSArray *thirdComment =[NSArray arrayWithObjects:@"Andrew",@"This is bullshit, but i like it!", nil];
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
@end
