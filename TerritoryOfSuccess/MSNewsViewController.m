//
//  MSNewsViewController.m
//  TerritoryOfSuccess
//
//  Created by Alex on 1/14/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSNewsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MSNewsViewController ()


@end

@implementation MSNewsViewController

@synthesize newsTableView = _newsTableView;
@synthesize articleScrollView = _articleScrollView;
@synthesize imageScrollView = _imageScrollView;
@synthesize articleTextView = _articleTextView;
@synthesize articleTitleLabel = _articleTitleLabel;
@synthesize beckButton = _beckButton;

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_image.png"]];
    self.newsTableView.layer.cornerRadius = 10;
    self.articleScrollView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
    self.articleScrollView.layer.cornerRadius = 10;
    self.imageScrollView.layer.cornerRadius = 10;
    [self.newsTableView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.newsTableView.layer setBorderWidth:1.0f];
    [self.articleScrollView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0].CGColor];
    [self.articleScrollView.layer setBorderWidth:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* myIdentifier = @"newsCellIdentifier";
    UITableViewCell *cell = [self.newsTableView dequeueReusableCellWithIdentifier:myIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myIdentifier];
    }
    cell.imageView.image = [UIImage imageNamed:@"photo_camera_1.png"];
    cell.textLabel.text = @"Заголовок новости";
    cell.textLabel.alpha = 1.0;
    cell.detailTextLabel.text = @"Описание";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *contentArray = [NSArray arrayWithObjects:[UIColor grayColor], [UIColor orangeColor], [UIColor darkGrayColor], [UIColor purpleColor], nil];
    for (int i = 0; i <contentArray.count; i++)
    {
        CGRect frame;
        frame.origin.x = i * self.imageScrollView.frame.size.width;
        frame.origin.y = 0;
        frame.size = self.imageScrollView.frame.size;
        UIView *subView = [[UIView alloc]initWithFrame:frame];
        subView.backgroundColor = [contentArray objectAtIndex:i];
        [self.imageScrollView addSubview:subView];
    }
    self.imageScrollView.contentSize = CGSizeMake(contentArray.count * self.imageScrollView.frame.size.width, self.imageScrollView.frame.size.height);
    
    self.articleTitleLabel.text = @"Заголовок новости";
    
    self.articleTextView.text = @"Представители Программы проверки подлинности товаров принимают участие в обсуждении проблем, связанных с распространением контрафактной продукции в Российской Федерации в рамках I Международного Форума \"Антиконтрафакт-2012\", который проходит в Москве с 22 по 24 октября в Международном выставочном центре «Крокус Экспо».    \nМероприятие проводится при поддержке Правительства РФ. Организатором форума выступает Министерство промышленности и торговли РФ и НП «Антиконтрафакт».\nВ работе форума запланировано участие первых лиц государства, глав крупнейших мировых компаний, ведущих российских и международных экспертов в области защиты прав интеллектуальной собственности.\nКонференция форума станет крупнейшей международной площадкой для диалога по проблемам создания цивилизованного рынка, защите прав и здоровья потребителей, стимулированию производителей инновационной продукции и предотвращения техногенных катастроф.\nВ рамках Международного форума «АНТИКОНТРАФАКТ-2012» состоится секционное мероприятие \"Инновационные технологии против контрафакта и подделок\".\nЦелью этой секции является поиск эффективных путей противодействия распространению контрафактной продукции в Российской Федерации в современных условиях, основанных на внедрении технологий и применении технических средств защиты продукции.";
    
    [UIView animateWithDuration:0.5 animations:^{self.newsTableView.frame = CGRectMake(-300, self.newsTableView.frame.origin.y, self.newsTableView.frame.size.width, self.newsTableView.frame.size.height);
        
        self.articleScrollView.frame = CGRectMake(30, self.articleScrollView.frame.origin.y, self.articleScrollView.frame.size.width, self.articleScrollView.frame.size.height);
        
        self.beckButton.frame = CGRectMake(0, self.beckButton.frame.origin.y
                                           , self.beckButton.frame.size.width, self.beckButton.frame.size.height);
        }];
}

- (IBAction)beckButtonClick:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{self.newsTableView.frame = CGRectMake(20, self.newsTableView.frame.origin.y, self.newsTableView.frame.size.width, self.newsTableView.frame.size.height);
        
        self.articleScrollView.frame = CGRectMake(340, self.articleScrollView.frame.origin.y, self.articleScrollView.frame.size.width, self.articleScrollView.frame.size.height);
        
        self.beckButton.frame = CGRectMake(320, self.beckButton.frame.origin.y
                                           , self.beckButton.frame.size.width, self.beckButton.frame.size.height);
    }];
}
@end