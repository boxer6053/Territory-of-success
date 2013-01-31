#import "MSDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSShare.h"
#import <Social/Social.h>

@interface MSDetailViewController ()
{
    BOOL shareIsPressed;
    BOOL accessToContinue;
}

@property (nonatomic) int commentsDetail, advisesDetail, ratingDetail;
@property (strong, nonatomic) NSString *productImageURL;
@property (strong, nonatomic) NSString *productSentName;
@property (strong, atomic) MSShare *share;

@end

@implementation MSDetailViewController

@synthesize commentsDetail = _commentsDetail;
@synthesize advisesDetail = _advisesDetail;
@synthesize ratingDetail = _ratingDetail;
@synthesize productName = _productName;
@synthesize share = _share;

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
    shareIsPressed = NO;
    accessToContinue = YES;
    
    // вью с лайками и количеством комментариев
    self.likeView.layer.cornerRadius = 10;
    [self.likeView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    //вью со звездочками
    self.starView.layer.cornerRadius = 10;
    [self.starView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    [self.mainView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    self.productDescriptionTextView.text = @"iPod Classic (продается как «iPod classic», раньше был известен под именем iPod) — портативный медиа плеер, созданный Apple, Inc.К сегодняшнему дню появилось шесть поколений iPod Classic, а также один спин-офф (iPod Photo) который постепенно воссоединился с линией Classic. Все поколения используют 1.8- дюймовый жёсткий диск для хранения информации. Текущее поколение на сегодняшний день является самым емким iPod,с 160 ГБ дискового пространства. Ретроним «Classic» появился вместе с шестым поколением iPod Classic 5-ого сентября 2007; до этого, iPod Classic назывался просто iPod.Недавнее изучение, проведённое Consumers Digest foundation при cотрудничестве Книги рекордов Гиннеса и департамент продаж Apple, Inc. отметил, что пользователи iPod покупали аксессуары и обновления каждые 6.2 месяцев, высшая цифра находится в регионе, где семья Монтмерль-Беренц из Парижа, Франция приобретала их каждые 6.3 дней с 2000 по 2007 гг.";
    CGRect frame = self.productDescriptionTextView.frame;
    frame.size.height = self.productDescriptionTextView.contentSize.height;
    self.productDescriptionTextView.frame = frame;
    
    [self.productDescriptionTextView setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.0]];
    
  // проверка на развер экрана
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        [self.detailScrollView setContentSize:CGSizeMake(self.detailScrollView .frame.size.width, self.imageView.frame.size.height + self.productDescriptionTextView.frame.size.height + 50)];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + 85, self.imageView.frame.size.width, self.imageView.frame.size.height);
        self.productDescriptionTextView.frame = CGRectMake(self.productDescriptionTextView.frame.origin.x, self.productDescriptionTextView.frame.origin.y + 85, self.productDescriptionTextView.frame.size.width, self.productDescriptionTextView.frame.size.height);
        self.detailScrollView.frame = CGRectMake(self.detailScrollView.frame.origin.x, self.detailScrollView.frame.origin.y, self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
        self.commentsButton.frame = CGRectMake(self.commentsButton.frame.origin.x, 325, self.commentsButton.frame.size.width, self.commentsButton.frame.size.height);
        self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, self.mainView.frame.size.width, self.mainView.frame.size.height - 85);
        self.productName.frame = CGRectMake(self.productName.frame.origin.x , self.productName.frame.origin.y + 85, self.productName.frame.size.width, self.productName.frame.size.height);
        self.fbButton.frame = CGRectMake(self.fbButton.frame.origin.x, self.fbButton.frame.origin.y + 85, self.fbButton.frame.size.width, self.fbButton.frame.size.height);
        self.vkButton.frame = CGRectMake(self.vkButton.frame.origin.x, self.vkButton.frame.origin.y + 85, self.vkButton.frame.size.width, self.vkButton.frame.size.height);
        self.twButton.frame = CGRectMake(self.twButton.frame.origin.x, self.twButton.frame.origin.y + 85, self.twButton.frame.size.width, self.twButton.frame.size.height);
        [self.detailScrollView setContentSize:CGSizeMake(self.detailScrollView .frame.size.width, self.imageView.frame.size.height + self.productDescriptionTextView.frame.size.height + 135)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.commentsLabel.text = [NSString stringWithFormat:@"%d",self.commentsDetail];
    self.advisesLabel.text = [NSString stringWithFormat:@"%d",self.advisesDetail];
    self.productName.text = self.productSentName;
    self.ratingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dstar",self.ratingDetail]];
    [self.detailImage setImageWithURL:[NSURL URLWithString:self.productImageURL]];
}
//необходим рефакторинг
//метод получения информации о продукте от сигвея
- (void)sentProductName:(NSString *)name
              andRating:(int)rating
      andCommentsNumber:(int)comments
       andAdvisesNumber:(int)advises
            andImageURL:(NSString *)imageURL
{
    self.productSentName = name;
    self.productImageURL = imageURL;
    self.ratingDetail = rating;
    self.commentsDetail = comments;
    self.advisesDetail = advises;
}

#pragma mark Share Methods
- (MSShare *) share
{
    if (!_share) {
        _share = [[MSShare alloc] init];
    }
    return _share;
}

- (void)setShare:(MSShare *)share
{
    _share = share;
}

- (IBAction)fbButtonPressed:(id)sender
{
    [[self share] shareOnFacebookWithText:[self productSentName]
                                withImage:[UIImage imageNamed:@"fbButton.png"]
                    currentViewController:self];
    
}
- (IBAction)twButtonPressed:(id)sender
{
    [[self share] shareOnTwitterWithText:[self productSentName]
                               withImage:[UIImage imageNamed:@"twButton.png"]
                   currentViewController:self];
}
- (IBAction)vkButtonPressed:(id)sender {
}
//необходим рефакторинг
- (IBAction)shareButtonPressed:(id)sender {
    if (shareIsPressed == NO && accessToContinue == YES) {
        [UIView animateWithDuration:1 animations:^{
            accessToContinue = NO;
            self.vkButton.alpha = 1;
            self.fbButton.alpha = 1;
            self.twButton.alpha = 1;
            shareIsPressed = YES;
        } completion:^(BOOL finished) {
            accessToContinue = YES;
        }];
    }else if(shareIsPressed == YES && accessToContinue == YES){
        [UIView animateWithDuration:1 animations:^{
            accessToContinue = NO;
            self.vkButton.alpha = 0;
            self.fbButton.alpha = 0;
            self.twButton.alpha = 0;
            shareIsPressed = NO;
        } completion:^(BOOL finished) {
            accessToContinue = YES;
        }];
    }

}

@end
