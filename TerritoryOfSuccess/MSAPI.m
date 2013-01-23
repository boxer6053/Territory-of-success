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
@synthesize checkRequest = _checkRequest;
@synthesize connectionToInfoMapping = _connectionToInfoMapping;
@synthesize connectionInfo = _connectionInfo;

- (CFMutableDictionaryRef)connectionToInfoMapping
{
    if (!_connectionToInfoMapping) {
        _connectionToInfoMapping = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    
    return _connectionToInfoMapping;
}

- (void)checkCode:(NSString *)code
{
    self.url = [NSURL URLWithString:@"http://id-bonus.com/api/app/code"];
    
    //створюемо запит
    self.request = [NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    
    //вказуэм протокол доступу
    [self.request setHTTPMethod:@"POST"];
    
    //вказуэм параметри POST запиту
    self.params = [NSMutableString stringWithFormat:@"code=%@", code];
    
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

- (void)getFiveNewsWithOffset:(int)offset
{
    self.url = [NSURL URLWithString:@"http://id-bonus.com/api/app/news"];
    
    self.checkRequest = news;
    
    //створюемо запит
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
                        
            CFDictionaryAddValue(self.connectionToInfoMapping, CFBridgingRetain(connection), CFBridgingRetain([NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:self.checkRequest] forKey:@"requestType"]));            
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
    
    self.checkRequest = newsWithId;
    
    //створюемо запит
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
                        
            CFDictionaryAddValue(self.connectionToInfoMapping, CFBridgingRetain(connection), CFBridgingRetain([NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInt:self.checkRequest] forKey:@"requestType"]));
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

//-(void) getFiveBrandsWithOffset:(int)offset{
//    self.url = [NSURL URLWithString:@"http://id-bonus.com/api/app/brands"];
//    self.request  = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
//    self.params = [NSString stringWithFormat:@"offset=%d",offset];
//    [self.request setHTTPBody:[self.params dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    if (checkConnection.hasConnectivity) {
//        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
//        
//        if(connection){
//            self.receivedData = [[NSMutableData alloc]init];
//        }else{
//            UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"URL Connection" message:@"Not seccess URL Connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//            [failmessage show];
//        }
//    }else{
//        UIAlertView *failmessage = [[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"Not seccess Internet Connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [failmessage show];
//    }
//}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //отримано відповідь від сервера
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //добавляєм отримані дані
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
    
    self.connectionInfo = CFBridgingRelease(CFDictionaryGetValue(self.connectionToInfoMapping, CFBridgingRetain(connection)));
//    [[self.connectionInfo objectForKey:@"receivedData"] appendData:data];
    
    NSDictionary *receivedDictionary = [JSONParserForDataEntenties parseJSONDataWithData:self.receivedData];
    
    [self.delegate finishedWithDictionary:receivedDictionary withTypeRequest:[[self.connectionInfo objectForKey:@"requestType"] intValue]];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
