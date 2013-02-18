//
//  MSInquirerDetailViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/28/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSInquirerDetailViewController : UIViewController <WsCompleteDelegate>
@property (weak, nonatomic) IBOutlet UILabel *inquirerTitle;
@property (nonatomic) NSInteger inquirerType;
@property   (strong, nonatomic) NSString *test;
@property (nonatomic) NSString * itemID;
@property (strong, nonatomic) NSArray *arrayOfProducts;
@property (nonatomic) int count;

-(void)selectAProductWithID:(int)tag;
@end

