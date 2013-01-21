#import "MSDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSDetailViewController ()

@end

@implementation MSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*568.png"]]];
        NSLog(@"568");
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_320*480.png"]]];
        NSLog(@"480");
    }
    
    self.likeView.layer.cornerRadius = 10;
    [self.likeView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    self.starView.layer.cornerRadius = 10;
    [self.starView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    self.detailPageScroll.layer.cornerRadius = 10;
    [self.detailPageScroll.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.detailPageScroll.layer setBorderWidth:1.0f];
    
    self.productDescriptionTextView.text = @"Конопля посевная описана в 19-ом и 20-ом томах «Естественной истории» Плиния Старшего, который упоминает её использование как прядильного, пищевого и лекарственного растения. Упоминается что конопляные семена — хорошее средство для лечения запора у домашних животных, сок травы помогает от отита, а корень можно использовать в качестве припарок от боли в суставах, подагры и ожогов.Конопля имеет богатую историю использования человечеством в качестве: пищи (семена), материала для изготовления бумаги, одежды, обуви, верёвок, канатов, тросов и ниток (стебли растения состоят из весьма прочных волокон), а также в качестве психотропного средства.Конопля впервые описана в Китае около 2800 года до н. э., на территорию будущей России занесена скифами не позднее V века н. э. Имела большое промышленное значение с XV по начало XX веков, в настоящее время посевы значительно сокращены. Единая Конвенция ООН 1961 года включает коноплю в список наркосодержащих растений и обязывает правительства стран-участников строго контролировать её выращивание.";
    [self.productDescriptionTextView setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.6]];
    [self.productDescriptionTextView.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor];
    [self.productDescriptionTextView.layer setBorderWidth:0.5f];
    
    [self.detailPageScroll setContentSize:CGSizeMake(self.detailPageScroll.frame.size.width, self.detailImage.frame.size.height + self.productDescriptionTextView.frame.size.height + 50)];
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
