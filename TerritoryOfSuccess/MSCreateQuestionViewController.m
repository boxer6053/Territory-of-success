//
//  MSCreateQuestionViewController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSCreateQuestionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MSCreateQuestionViewController ()
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) MSAPI *api;

@end

@implementation MSCreateQuestionViewController
@synthesize productView1 = _productView1;
@synthesize productView2 = _productView2;
@synthesize productView3 = _productView3;
@synthesize productView4 = _productView4;
@synthesize productView5 = _productView5;
@synthesize productView6 = _productView6;
@synthesize arrayOfProducts = _arrayOfProducts;
@synthesize requestString = _requestString;
@synthesize gettedImages = _gettedImages;
@synthesize api = _api;
@synthesize receivedData = _receivedData;

- (MSAPI *) api{
    if(!_api){
        _api = [[MSAPI alloc]init];
        _api.delegate = self;
    }
    return _api;
}

- (void)viewDidLoad
{
    [self performSegueWithIdentifier:@"pickAProduct" sender:self];
    self.requestString = [[NSMutableString alloc] initWithString:@""];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [tap setNumberOfTapsRequired:1];
    
    self.gettedImages = [[NSMutableArray alloc] init];
    [self.productView1 addGestureRecognizer:tap];
    [self.productView2 addGestureRecognizer:tap];
    [self.productView3 addGestureRecognizer:tap];
    [self.productView4 addGestureRecognizer:tap];
    [self.productView5 addGestureRecognizer:tap];
    [self.productView6 addGestureRecognizer:tap];
    
    
    self.arrayOfProducts = [[NSArray alloc] initWithObjects:self.productView1,self.productView2,self.productView3,self.productView4,self.productView5,self.productView6, nil];
    for(int i=0;i<self.arrayOfProducts.count;i++)
    {
        // [[self.arrayOfProducts objectAtIndex:i] addGestureRecognizer:tap];
        [[self.arrayOfProducts objectAtIndex:i] setUserInteractionEnabled:YES];
        [[self.arrayOfProducts objectAtIndex:i] setImage:[UIImage imageNamed:@"bag.png"]];
    }
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
}
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"tap");
}
-(void)addProduct:(NSString *)string withURL:(NSString *)ulr
{
    [self.requestString appendString:@"&items[]="];
    [self.requestString appendString:string];
    [self.gettedImages addObject:ulr];
    NSLog(@"request String %@", self.requestString);
    
    NSLog(@"firstObject %@", [self.gettedImages objectAtIndex:0]);
    for(int i=0;i<self.gettedImages.count;i++)
    {
        [[self.arrayOfProducts objectAtIndex:i] setUserInteractionEnabled:YES];
        [[self.arrayOfProducts objectAtIndex:i] setImageWithURL:[self.gettedImages objectAtIndex:i]];
    }
    
}

-(void)addImageURL:(NSString *)string
{
    [self.gettedImages addObject:string];
    NSLog(@"firstObject %@", [self.gettedImages objectAtIndex:0]);
}
- (IBAction)addMoreProduct:(id)sender {
    [self performSegueWithIdentifier:@"pickAProduct" sender:self];
}
- (IBAction)startButton:(id)sender {
    
    [self.api createQuestionWithItems:self.requestString];
}
-(void)finishedWithDictionary:(NSDictionary *)dictionary withTypeRequest:(requestTypes)type
{
    
}
@end
