//
//  MSAPI.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 21.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONParserForDataEntenties.h"

typedef enum {kAuth = 1, kRegist = 2, kNews = 3, kNewsWithId = 4, kCode = 5, kBrands = 6, kCategories = 7, kCatalog = 8, kQuest = 9} requestTypes;

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

- (void)getFiveNewsWithOffset:(int)offset;
- (void)getNewsWithId:(NSString *)newsId;
- (void)checkCode:(NSString *)code;

- (void)getFiveBrandsWithOffset:(int)offset;
- (void)getCategories;
- (void)getProductsWithOffset:(int)offset withBrandId:(int)brandId withCategoryId:(int)categoryId;
-(void)getQuestionsWithParentID:(int)parentId;
@end
