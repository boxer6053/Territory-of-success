#import "MSCommentsViewController.h"
#import "MSCommentCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MSAddCommentView.h"

@interface MSCommentsViewController ()
@property (nonatomic, strong) MSAddCommentView *addCommentView;
@property (nonatomic) int prodId;
@end

@implementation MSCommentsViewController
@synthesize commentsArray = _commentsArray;
@synthesize commentNew = _commentNew;
@synthesize addCommentView = _addCommentView;
@synthesize prodId = _prodId;

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
    [[self commentTableView] setBackgroundView:[[UIImageView alloc]
                                 initWithImage:[UIImage imageNamed:@"bg.png"]]];
    NSArray *firstComment = [NSArray arrayWithObjects:@"Pavel",@"Кльовий продукт. Рекомендую",[NSNumber numberWithInteger:5], nil];
    NSArray *secondComment = [NSArray arrayWithObjects:@"Lyohaness",@"+++",[NSNumber numberWithInteger:4], nil];
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
    cell.commentatorName.text =[name stringByAppendingString:@":"];
    [cell.commentText setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    cell.commentText.text = [[_commentsArray objectAtIndex:indexPath.row] objectAtIndex:1];
    
    return cell;
}

-(void)sentProductId:(int)sentProductId
{
    self.prodId = sentProductId;
}

- (IBAction)addComment:(id)sender
{
    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"authorization_Token"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Ошибка", nil) message:NSLocalizedString(@"NeedToAuthorizedKey", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else if(!self.addCommentView)
    {
        self.commentTableView.scrollEnabled = NO;
        self.addCommentView = [[MSAddCommentView alloc] initCommentAdder];
        [self.view addSubview:self.addCommentView];
        [self.addCommentView setProductId:self.prodId];
        [[self addCommentView] attachPopUpAnimationForView:self.addCommentView.containerView];
        self.addCommentView.delegate = self;
    }
}

- (void)closeAddingCommentSubviewWithAdditionalActions
{
    self.commentTableView.scrollEnabled = YES;
    self.addCommentView = nil;
}
@end
