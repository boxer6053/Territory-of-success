#import "MSCommentsViewController.h"
#import "MSCommentCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MSAddCommentView.h"
#import "SVProgressHUD.h"

@interface MSCommentsViewController ()
@property (nonatomic, strong) MSAddCommentView *addCommentView;
@property (nonatomic) int prodId;
@property (nonatomic) MSAPI *api;
@property (strong, nonatomic) NSMutableArray *commentsArray;
@property (strong, nonatomic) NSArray *lastloadedCommentsArray;
@property (nonatomic) int commentsCounter;
@property (nonatomic) int tempCommentsCounter;
@property (nonatomic, strong) UIButton *footerButton;
@property (nonatomic) BOOL isFirstTime;
@end

@implementation MSCommentsViewController
@synthesize commentsArray = _commentsArray;
@synthesize commentNew = _commentNew;
@synthesize addCommentView = _addCommentView;
@synthesize prodId = _prodId;
@synthesize api = _api;
@synthesize footerButton = _footerButton;
@synthesize lastloadedCommentsArray = _lastloadedCommentsArray;
@synthesize isFirstTime = _isFirstTime;
@synthesize tempCommentsCounter = _tempCommentsCounter;

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
    
    self.footerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.commentTableView.frame.size.width, 35)];
    [self.footerButton setTitle:NSLocalizedString(@"DownloadMoreKey",nil) forState:UIControlStateNormal];
    self.footerButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    [self.footerButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4] forState:UIControlStateNormal];
    [self.footerButton addTarget:self action:@selector(moreComments) forControlEvents:UIControlEventTouchDown];
    
    [self commentTableView].tableFooterView = self.footerButton;
    [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadCommentsKey",nil)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) moreComments
{
    if (self.commentsArray.count < self.commentsCounter)
    {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"DownloadCommentsKey",nil)];
        [self.api getCommentsWithProductId:self.prodId andOffset:self.commentsArray.count];
    }
    else
    {
        [self.footerButton setTitle:NSLocalizedString(@"AllCommentsDownloadedKey",nil) forState:UIControlStateNormal];
    }
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellText = [NSString stringWithString:[[[self commentsArray] objectAtIndex:indexPath.row] valueForKey:@"text"]];
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(320, CGFLOAT_MAX);
    CGSize textViewSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize];
    
    return textViewSize.height + 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self tempCommentsCounter];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"commentsIdentifier";
    MSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[MSCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *value = [[[self commentsArray] objectAtIndex:indexPath.row] valueForKey:@"name"];
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if ([[value stringByTrimmingCharactersInSet:set] length] == 0)
    {
        cell.commentatorName.text = @"Noname";
    }
    else cell.commentatorName.text = [[[self commentsArray] objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    [cell.commentText setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
    cell.commentText.text = [[[self commentsArray] objectAtIndex:indexPath.row] valueForKey:@"text"];
    
    cell.commentdate.text = [[[self commentsArray] objectAtIndex:indexPath.row] valueForKey:@"date"];
    
    return cell;
}

-(void)sentProductId:(int)sentProductId
{
    self.prodId = sentProductId;
    self.isFirstTime = YES;
    [self.api getCommentsWithProductId:self.prodId andOffset:0];
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
        [self.view.window addSubview:self.addCommentView];
        [self.addCommentView setProductId:self.prodId];
        [[self addCommentView] attachPopUpAnimationForView:self.addCommentView.containerView];
        self.addCommentView.delegate = self;
    }
}

- (void)closeAddingCommentSubviewWithAdditionalActions
{
    self.commentTableView.scrollEnabled = YES;
    self.addCommentView = nil;
    [self.commentTableView reloadData];
}

#pragma mark Web Methods
- (MSAPI *) api
{
    if(!_api)
    {
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if (type == kComments)
    {
        if (self.isFirstTime)
        {
            self.commentsArray = [[dictionary valueForKey:@"list"] mutableCopy];
            self.tempCommentsCounter = self.commentsArray.count;
            self.commentsCounter = [[dictionary valueForKey:@"count"]integerValue];
            [[self commentTableView] reloadData];
            self.isFirstTime = NO;
        }
        else
        {
            [self.commentsArray addObjectsFromArray:[dictionary valueForKey:@"list"]];
            self.lastloadedCommentsArray = [dictionary valueForKey:@"list"];
            for (int i  = 0; i < self.lastloadedCommentsArray.count; i++)
            {
                NSArray *insertIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.tempCommentsCounter++  inSection:0]];
                [self.commentTableView insertRowsAtIndexPaths: insertIndexPath withRowAnimation:NO];
            }
        }
    }
}
@end
