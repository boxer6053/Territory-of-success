//
//  MSAPI.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 21.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSAPI.h"
#import "checkConnection.h"

@implementation MSAPI

@synthesize url = _url;
@synthesize request =_request;
@synthesize connection = _connection;
@synthesize params = _params;
@synthesize receivedData = _receivedData;
@synthesize delegate = _delegate;

- (void)getFiveNewsWithOffset:(int)offset
{
    self.url = [NSURL URLWithString:@"http://id-bonus.com/api/app/news"];
    
    //створюемо запыт
    self.request = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //вказуэм протокол доступу
    [self.request setHTTPMethod:@"POST"];
    
    self.params = [NSMutableString stringWithFormat:@"offset=%d", offset];
    
    //перевірка наявності інету
    if (checkConnection.hasConnectivity) {
        //створюєм з'єднання і начинаєм загрузку
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
        //перевірка з'єднання
        if (connection) {
            NSLog(@"З'єднання почалось");
            self.receivedData = [[NSMutableData alloc] init];
        }
        else
        {
            //якщо з'єднання нема
            // Inform the user that the connection failed.
            NSLog(@"Помилка з'єднання");
            UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"URL Connection"
                                                                         message:@"Not success URL connection"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Ok"
                                                               otherButtonTitles:nil];
            [connectFailMessage show];
        }
    }
    else
    {
        //якщо інету нема
        UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"Internet Connection"
                                                                     message:@"Not success Internet connection"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Ok"
                                                           otherButtonTitles:nil];
        [connectFailMessage show];
    }
}

- (void)getNewsWithId:(NSString *)newsId
{
    self.url = [NSURL URLWithString:@"http://id-bonus.com/api/app/news"];
    
    //створюемо запыт
    self.request = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //вказуэм протокол доступу
    [self.request setHTTPMethod:@"POST"];
    
    //вказуэм параметри POST запиту
    self.params = [NSMutableString stringWithFormat:@"news_id=%@", newsId];
    
    //вказуэм тіло запиту
    [self.request setHTTPBody:[self.params dataUsingEncoding:NSUTF8StringEncoding]];
    
    //перевірка наявності інету
    if (checkConnection.hasConnectivity) {
        //створюєм з'єднання і начинаєм загрузку
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
                
        //перевірка з'єднання
        if (connection) {
            NSLog(@"З'єднання почалось");
            self.receivedData = [[NSMutableData alloc] init];
        }
        else
        {
            //якщо з'єднання нема
            // Inform the user that the connection failed.
            NSLog(@"Помилка з'єднання");
            UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"URL Connection"
                                                                         message:@"Not success URL connection"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Ok"
                                                               otherButtonTitles:nil];
            [connectFailMessage show];
        }
    }
    else
    {
        //якщо інету нема
        UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"Internet Connection"
                                                                     message:@"Not success Internet connection"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Ok"
                                                           otherButtonTitles:nil];
        [connectFailMessage show];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //отримано відповідь від сервера
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //бобавляєм отримані дані
    [self.receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString *errorString = [[NSString alloc] initWithFormat:@"Connection failed! Error - %@ %@ %@",
                             [error localizedDescription],
                             [error description],
                             [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    NSLog(@"%@", errorString);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"Довжина отриманих даних: %u", [self.receivedData length]);
    
    NSString *text = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", text);
    
    [self.delegate finished];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
