//
//  MSStatisticViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 2/19/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSStatisticViewController : UIViewController <WsCompleteDelegate>
@property (nonatomic) NSInteger interfaceIndex;
@property (nonatomic) NSInteger questionID;
@property (strong, nonatomic) NSArray *receivedArray;

@end
