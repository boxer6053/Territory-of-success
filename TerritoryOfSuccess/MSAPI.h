//
//  MSAPI.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 21.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParserForDataEntenties.h"

typedef enum {auth = 1, regist = 2, news = 3, newsWithId = 4, code = 5, brands = 6, categories = 7, catalog = 8} requestTypes;

@protocol WsCompleteDelegate

- (void)finishedWithDictionary:(NSDictionary *)dictionary
               withTypeRequest:(requestTypes)type;

@end

@interface MSAPI : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) id<WsCompleteDelegate> delegate;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableString *params;
@property (strong, nonatomic) NSMutableData *receivedData;
@property requestTypes checkRequest;
@property (nonatomic) CFMutableDictionaryRef connectionToInfoMapping;
@property (strong, nonatomic) NSMutableDictionary *connectionInfo;


- (void)getAllNews;
- (void)getNewsWithId:(NSString *)newsId;
- (void)checkCode:(NSString *)code;

//- (void)getFiveBrandsWithOffset:(int)offset;
@end
