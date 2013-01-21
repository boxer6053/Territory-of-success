//
//  MSTabBarController.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 08.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSAPI.h"

@interface MSTabBarController ()

@property (strong, nonatomic) MSAPI *api;

@end

@implementation MSTabBarController

@synthesize myTabBarController = _myTabBarController;
@synthesize receivedData = _receivedData;
@synthesize api = _api;

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
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
//    NSURL *url = [NSURL URLWithString:@"http://id-bonus.com/api/app/news"];
//    
//    //створюемо запыт
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
//    
//    //вказуэм протокол доступу
//    [request setHTTPMethod:@"POST"];
//    
//    //вказуэм параметри POST запиту
//    NSString *params = @"news_id=3";
//    
//    //вказуэм тіло запиту
//    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //створюєм з'єднання і начинаєм загрузку
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//    //перевірка з'єднання
//    if (connection) {
//        NSLog(@"З'єднання почалось");
//        self.receivedData = [[NSMutableData alloc] init];
//    }
//    else
//    {
//        NSLog(@"Помилка з'єднання");
//    }
    
    self.api = [[MSAPI alloc] init];
    
    [self.api setDelegate:self];
    
//    [self.api getNewsWithId:@"3"];
//    [self.api getAllNews];
        
}

- (void)finished
{
    self.receivedData = [self.api receivedData];
    NSString *receiveText = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    //отримано відповідь від сервера
//    [self.receivedData setLength:0];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    //бобавляєм отримані дані
//    [self.receivedData appendData:data];
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSString *errorString = [[NSString alloc] initWithFormat:@"Connection failed! Error - %@ %@ %@",
//                             [error localizedDescription],
//                             [error description],
//                             [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
//    NSLog(@"%@", errorString);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    NSLog(@"Довжина отриманих даних: %u", [self.receivedData length]);
//    
//    NSString *text = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", text);
//    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
