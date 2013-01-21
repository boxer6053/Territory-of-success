//
//  MSAPI.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 21.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WsCompleteDelegate

- (void)finished;

@end

@interface MSAPI : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) id<WsCompleteDelegate> delegate;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSMutableURLRequest *request;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableString *params;
@property (strong, nonatomic) NSMutableData *receivedData;

- (void)getAllNews;
- (void)getNewsWithId:(NSString *)newsId;

@end
