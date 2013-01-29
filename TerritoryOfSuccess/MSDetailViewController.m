#import "MSDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MSDetailViewController ()
{
    BOOL shareIsPressed;
    BOOL accessToContinue;
}
//@property (nonatomic) MSAPI *api;
@property (nonatomic) int commentsDetail, advisesDetail, ratingDetail;
@property (strong, nonatomic) NSString* productImageURL;
@property (strong, nonatomic) NSString* productSentName;
@end

@implementation MSDetailViewController
@synthesize commentsDetail, advisesDetail, ratingDetail;

@synthesize productName;
//@synthesize api;

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
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
        self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + 85, self.imageView.frame.size.width, self.imageView.frame.size.height);
        self.productDescriptionTextView.frame = CGRectMake(self.productDescriptionTextView.frame.origin.x, self.productDescriptionTextView.frame.origin.y + 85, self.productDescriptionTextView.frame.size.width, self.productDescriptionTextView.frame.size.height);
        self.detailScrollView.frame = CGRectMake(self.detailScrollView.frame.origin.x, self.detailScrollView.frame.origin.y, self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height);
        self.questionsButton.frame = CGRectMake(self.questionsButton.frame.origin.x, 314, self.questionsButton.frame.size.width, self.questionsButton.frame.size.height);
        self.commentsButton.frame = CGRectMake(self.commentsButton.frame.origin.x, 314, self.commentsButton.frame.size.width, self.commentsButton.frame.size.height);
        self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, self.mainView.frame.size.width, self.mainView.frame.size.height - 85);
    }
    
    self.likeView.layer.cornerRadius = 10;
    [self.likeView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    self.starView.layer.cornerRadius = 10;
    [self.starView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    [self.mainView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    self.productDescriptionTextView.text = @"Конопля посевная описана в 19-ом и 20-ом томах «Естественной истории» Плиния Старшего, который упоминает её использование как прядильного, пищевого и лекарственного растения. Упоминается что конопляные семена — хорошее средство для лечения запора у домашних животных, сок травы помогает от отита, а корень можно использовать в качестве припарок от боли в суставах, подагры и ожогов.Конопля имеет богатую историю использования человечеством в качестве: пищи (семена), материала для изготовления бумаги, одежды, обуви, верёвок, канатов, тросов и ниток (стебли растения состоят из весьма прочных волокон), а также в качестве психотропного средства.Конопля впервые описана в Китае около 2800 года до н. э., на территорию будущей России занесена скифами не позднее V века н. э. Имела большое промышленное значение с XV по начало XX веков, в настоящее время посевы значительно сокращены. Единая Конвенция ООН 1961 года включает коноплю в список наркосодержащих растений и обязывает правительства стран-участников строго контролировать её выращивание.";
    CGRect frame = self.productDescriptionTextView.frame;
    frame.size.height = self.productDescriptionTextView.contentSize.height;
    self.productDescriptionTextView.frame = frame;
    
    [self.productDescriptionTextView setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.0]];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
            [self.detailScrollView setContentSize:CGSizeMake(self.detailScrollView .frame.size.width, self.imageView.frame.size.height + self.productDescriptionTextView.frame.size.height + 30)];
    }
    else
    {
            [self.detailScrollView setContentSize:CGSizeMake(self.detailScrollView .frame.size.width, self.imageView.frame.size.height + self.productDescriptionTextView.frame.size.height + 115)];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.commentsLabel.text = [NSString stringWithFormat:@"%d",self.commentsDetail];
    self.advisesLabel.text = [NSString stringWithFormat:@"%d",self.advisesDetail];
    self.productName.text = self.productSentName;
    self.ratingImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dstar",self.ratingDetail]];
    [self.detailImage setImageWithURL:[NSURL URLWithString:self.productImageURL]];
}

-(void)sentProductName:(NSString *)name andRating:(int)rating andCommentsNumber:(int)comments andAdvisesNumber:(int)advises andImageURL:(NSString *)imageURL
{
    self.productSentName = name;
    self.productImageURL = imageURL;
    self.ratingDetail = rating;
    self.commentsDetail = comments;
    self.advisesDetail = advises;
}

#pragma mark Web Methods
//- (MSAPI *) api{
//    if(!self.api){
//        self.api = [[MSAPI alloc]init];
//        self.api.delegate = self;
//    }
//    return self.api;
//}
//
//- (void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type{
//    
//}


#pragma mark Share Methods
- (IBAction)fbButtonPressed:(id)sender {
}
- (IBAction)twButtonPressed:(id)sender {
}
- (IBAction)vkButtonPressed:(id)sender {
}

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
