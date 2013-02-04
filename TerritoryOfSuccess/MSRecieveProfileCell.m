//
//  MSRecieveProfileCell.m
//  TerritoryOfSuccess
//
//  Created by Alex on 1/31/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSReceiveProfileCell.h"

@implementation MSReceiveProfileCell

@synthesize receiveNews = _receiveNews;
@synthesize receiveNotice = _recieveNotice;
@synthesize receiveNewsButton = _receiveNewsButton;
@synthesize receiveNewsLabel = _receiveNewsLabel;
@synthesize receiveNoticeButton = _receiveNoticeButton;
@synthesize receiveNoticeLabel = _recieveNoticeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)recieveNewsButtonPressed:(id)sender
{
    if (self.receiveNews)
    {
        self.receiveNews = NO;
        [self.receiveNewsButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.receiveNews = YES;
        [self.receiveNewsButton setBackgroundImage:[UIImage imageNamed:@"checkbox_full.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)recieveNoticeButtonPressed:(id)sender
{
    if (self.receiveNotice)
    {
        self.receiveNotice = NO;
        [self.receiveNoticeButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.receiveNotice = YES;
        [self.receiveNoticeButton setBackgroundImage:[UIImage imageNamed:@"checkbox_full.png"] forState:UIControlStateNormal];
    }
}
@end
