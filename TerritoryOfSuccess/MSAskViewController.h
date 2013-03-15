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
-(void)saveTitleView:(NSString *)string;
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
@property (strong, nonatomic) NSString *upperTitle;
@property (nonatomic) NSInteger upperID;
@property (nonatomic) int finalID;
@property (nonatomic) BOOL gottedFromPrevious;
@property (strong, nonatomic) NSMutableString *requestItemsString;
@property (nonatomic) BOOL isAuthorized;
@property (strong, nonatomic) NSMutableArray *backIds;
@property (strong, nonatomic) NSMutableArray *backTitles;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) NSString *viewTitle;

- (IBAction)cancel:(id)sender;

@property  BOOL upButtonShows;
@end
