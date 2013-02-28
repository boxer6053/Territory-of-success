//
//  MSAskViewController.h
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"
@protocol AddingRequestStringDelegate <NSObject>
-(void)addProduct:(NSString *)string withURL:(NSString *)ulr;
-(void)addImageURL:(NSString *)string;
-(void)setUpperId:(int)upperId;
@end

@interface MSAskViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, WsCompleteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableOfCategories;
- (IBAction)backButtonPressed:(id)sender;
@property (nonatomic) id translatingValue;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic) int defaultID;
@property (weak, nonatomic) NSURL *translatingUrl;
@property (weak, nonatomic) NSString *sendingTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *upButton;
@property (strong, nonatomic) id <AddingRequestStringDelegate> delegate;
@property (nonatomic) NSInteger upperID;
@property (nonatomic) int finalID;
@property (strong, nonatomic) NSMutableString *requestItemsString;
@property (nonatomic) BOOL isAuthorized;
@property (strong, nonatomic) NSMutableArray *backIds;

- (IBAction)cancel:(id)sender;

- (IBAction)upAction:(id)sender;



@property  BOOL upButtonShows;
@end
