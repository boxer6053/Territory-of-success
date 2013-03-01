//
//  MSCreateQuestionViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSCreateQuestionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "SVProgressHUD.h"
#import <QuartzCore/QuartzCore.h>


@interface MSCreateQuestionViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;


@end

@implementation MSCreateQuestionViewController
@synthesize arrayOfViews = _arrayOfViews;
@synthesize arrayOfProducts = _arrayOfProducts;
@synthesize requestString = _requestString;
@synthesize gettedImages = _gettedImages;
@synthesize response = _response;
@synthesize api = _api;
@synthesize receivedData = _receivedData;
@synthesize upperID = _upperID;
@synthesize savedIndex = _savedIndex;
@synthesize askButton = _askButton;
@synthesize cleanButton = _cleanButton;
@synthesize nameLabel = _nameLabel;
@synthesize requestStringArray = _requestStringArray;
- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (void)viewDidLoad
{
    self.requestStringArray = [[NSMutableArray alloc] init];
    NSUserDefaults *userDefults = [NSUserDefaults standardUserDefaults];
    [self.nameLabel setText:NSLocalizedString(@"PickAProductKey", nil)];
    NSString *token = [userDefults valueForKey:@"authorization_Token" ];
    if(!token.length){
        UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Пожалуйста перезайдите в систему!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
        [failmessage show];

    
//        self.isAuthorized = YES;
//        [self.addQuestionButton setEnabled:YES];
    }
   [self.cleanButton setTitle:NSLocalizedString(@"CleanKey",nil) forState:UIControlStateNormal];
    [self.askButton setTitle:NSLocalizedString(@"AskKey",nil) forState:UIControlStateNormal];
    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }
    else
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    }

   // [self performSegueWithIdentifier:@"pickAProduct" sender:self];
    [self.cleanButton setEnabled:NO];
    self.requestString = [[NSMutableString alloc] initWithString:@""];
    
    UIButton *image1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *image2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *image3 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *image4 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *image5 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *image6 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //фреймы для разных экранов (4 и 5 айфон)
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
             [image1 setFrame:CGRectMake(50, 58, 80,80)];
        [image2 setFrame:CGRectMake(190, 58, 80,80)];
        [image3 setFrame:CGRectMake(50, 168, 80,80)];
        [image4 setFrame:CGRectMake(190, 168, 80,80)];
        [image5 setFrame:CGRectMake(50, 278, 80,80)];
        [image6 setFrame:CGRectMake(190, 278, 80,80)];
        
    }
    else
    {
        
        [image1 setFrame:CGRectMake(50, 36, 80,80)];
        [image2 setFrame:CGRectMake(190, 36, 80,80)];
        [image3 setFrame:CGRectMake(50, 126, 80,80)];
        [image4 setFrame:CGRectMake(190, 126, 80,80)];
        [image5 setFrame:CGRectMake(50, 226, 80,80)];
        [image6 setFrame:CGRectMake(190, 226, 80,80)];
    }

    self.arrayOfViews = [[NSArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6, nil];
    for(int i=0;i<self.arrayOfViews.count;i++)
    {
        //UIImage *plus = [UIImage imageNamed:@"plus_icon.png"];
        [[self.arrayOfViews objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [[self.arrayOfViews objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"addButton1.png"] forState:UIControlStateNormal];
        UIButton *current = [self.arrayOfViews objectAtIndex:i];
        [current addTarget:self action:@selector(assignAPicture:)forControlEvents:UIControlEventTouchUpInside ];
            current.layer.cornerRadius  = 10.0f;
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
         CGColorRef borderColor = [color CGColor];
        current.layer.borderColor = borderColor;
        current.layer.borderWidth = 1.0;
        [current setTag:i];
        //[current setAlpha:0.7];
        current.clipsToBounds= YES;
        [self.view addSubview:current];
    }
    for(int i=1;i<self.arrayOfViews.count;i++){
        [[self.arrayOfViews objectAtIndex:i] setHidden:YES];
    }
    
    
    self.gettedImages = [[NSMutableArray alloc] init];

    
    
//    self.arrayOfProducts = [[NSArray alloc] initWithObjects:self.productView1,self.productView2,self.productView3,self.productView4,self.productView5,self.productView6, nil];
//    for(int i=0;i<self.arrayOfProducts.count;i++)
//    {
//        // [[self.arrayOfProducts objectAtIndex:i] addGestureRecognizer:tap];
//        [[self.arrayOfProducts objectAtIndex:i] setUserInteractionEnabled:YES];
//        [[self.arrayOfProducts objectAtIndex:i] setImage:[UIImage imageNamed:@"bag.png"]];
//    }
//    
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        self.askButton.frame = CGRectMake(20, 400, 120, 35);
        self.cleanButton.frame = CGRectMake(180, 400, 120, 35);
    }

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)assignAPicture:(id)sender
{
   
    NSLog(@"TAP %d", [sender tag]);
    self.savedIndex = [sender tag];
    NSLog(@"Saved index =%d", self.savedIndex);
//    if(self.requestStringArray.count !=0){
//        [self.requestStringArray setObject:@"" atIndexedSubscript:self.savedIndex];
//    }
    [self performSegueWithIdentifier:@"pickAProduct" sender:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MSAskViewController *avc = [segue destinationViewController];
    avc.delegate = self;
    NSLog(@"id %d", self.upperID);
    
    if([segue.identifier isEqualToString:@"pickAProduct"]){
        MSAskViewController *controller = (MSAskViewController *)segue.destinationViewController;
        controller.defaultID = self.upperID;
        NSLog(@"gonna be id %d", self.upperID   );
    }
}
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"tap");
}
-(void)addProduct:(NSString *)string withURL:(NSString *)ulr
{
    int access;
    NSLog(@"SSTRing %d",self.savedIndex);
    for(int i=0;i<self.requestStringArray.count;i++)
    {
        if([string isEqualToString:[self.requestStringArray objectAtIndex:i]])
            access = 1;
        else
            access = 0;
    }
    if(access ==1){
        UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Такой продукт уже внесен в опрос!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
        [failmessage show];
    }
    else{
   [self.requestStringArray setObject:string atIndexedSubscript:self.savedIndex];
    NSLog(@"At Index! %@",[self.requestStringArray objectAtIndex:self.savedIndex]);
    for (id obj in self.requestStringArray)
        NSLog(@"obj: %@", obj);
     [self.gettedImages addObject:ulr];
    //[self.requestStringArray addObject:string];
    NSLog(@"request String %@", self.requestString);
    
    NSLog(@"firstObject %@", [self.gettedImages objectAtIndex:0]);
//    for(int i=0;i<self.gettedImages.count;i++)
//    {
//        [[self.arrayOfProducts objectAtIndex:i] setUserInteractionEnabled:YES];
//        [[self.arrayOfProducts objectAtIndex:i] setImageWithURL:[self.gettedImages objectAtIndex:i]];
//    }
    
    NSURL *urll = [NSURL URLWithString:[ulr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[self.arrayOfViews objectAtIndex:self.savedIndex] setBackgroundImageWithURL:urll forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder_415*415.png"]];
    if(self.savedIndex <5){
    [[self.arrayOfViews objectAtIndex:(self.savedIndex +1)]setHidden:NO];
    }
    
   // [[self.arrayOfViews objectAtIndex:self.savedIndex] setUserInteractionEnabled:NO];

    [self.cleanButton setEnabled:YES];
    }
    
}
-(void)setUpperId:(int)upperId
{
    self.upperID = upperId;
}
-(void)addImageURL:(NSString *)string
{
    [self.gettedImages addObject:string];
    NSLog(@"firstObject %@", [self.gettedImages objectAtIndex:0]);
}

- (IBAction)startButton:(id)sender {
    for(int i=0;i<self.requestStringArray.count;i++){
    [self.requestString appendString:@"&items[]="];
    [self.requestString appendString:[self.requestStringArray objectAtIndex:i]];
    }

    NSLog(@"Request %@", self.requestString);
    if(![self.requestString isEqualToString:@""]){
    [SVProgressHUD showWithStatus:NSLocalizedString(@"SendingInquirerKey",nil)];
        [self.api createQuestionWithItems:self.requestString];}
    else{
        UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Выберите не меньше 1 продукта!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
        [failmessage show];
    }
}

-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    if (type ==kCreateQuest)
    {
        self.response = [dictionary valueForKey:@"message"];
        NSString *wantedString = @"!-- question-created --!";
        NSLog(@"Result is %@", self.response);
        if([self.response isEqualToString:wantedString])
        {
            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Успех" message:@"Опрос успешно создан!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
            [failmessage show];
            [self.navigationController popViewControllerAnimated:YES];

        }
        else{
        NSString *response = [[dictionary valueForKey:@"message"] valueForKey:@"text"];
        if([response isEqualToString:@"To get access to this page please log in to the system."]){
            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Пожалуйста перезайдите в систему!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
            [failmessage show];}
        }
//    else
//        {
//            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Произошла ошибка!" delegate:self cancelButtonTitle:@"Ок" otherButtonTitles:nil];
//            [failmessage show];
//        }
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"DownloadIsCompletedKey",nil)];

        [self.navigationController popViewControllerAnimated:YES];
    }
        
    

}
- (IBAction)cleanButton:(id)sender {
    [self.requestString setString:@""];
      self.upperID = 0;
    for(int i=0;i<self.arrayOfViews.count;i++){
        [[self.arrayOfViews objectAtIndex:i] setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
        [[self.arrayOfViews objectAtIndex:i] setBackgroundImage:[UIImage imageNamed:@"addButton1.png"] forState:UIControlStateNormal];
        [[self.arrayOfViews objectAtIndex:i] setUserInteractionEnabled:YES];
        UIButton *current = [self.arrayOfViews objectAtIndex:i];
        current.layer.cornerRadius  = 10.0f;
        UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        CGColorRef borderColor = [color CGColor];
        current.layer.borderColor = borderColor;
        current.layer.borderWidth = 1.0;
        [current setTag:i];
        //[current setAlpha:0.7];
        current.clipsToBounds= YES;
    }
    
    [self.cleanButton setEnabled:NO];
    
}
@end
