//
//  MSTabBarController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 08.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MSAPI.h"

@interface MSTabBarController : UITabBarController<NSURLConnectionDelegate, NSURLConnectionDataDelegate, WsCompleteDelegate>

@property (weak, nonatomic) IBOutlet UITabBar *myTabBarController;

@property (strong, nonatomic) NSMutableData *receivedData;

@end
