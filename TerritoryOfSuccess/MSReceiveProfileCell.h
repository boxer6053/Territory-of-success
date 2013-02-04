//
//  MSRecieveProfileCell.h
//  TerritoryOfSuccess
//
//  Created by Alex on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSReceiveProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *receiveNewsButton;
@property (weak, nonatomic) IBOutlet UILabel *receiveNewsLabel;
@property (weak, nonatomic) IBOutlet UIButton *receiveNoticeButton;
@property (weak, nonatomic) IBOutlet UILabel *receiveNoticeLabel;

- (IBAction)recieveNewsButtonPressed:(id)sender;
- (IBAction)recieveNoticeButtonPressed:(id)sender;

@property (nonatomic) BOOL receiveNews;
@property (nonatomic) BOOL receiveNotice;
@end
