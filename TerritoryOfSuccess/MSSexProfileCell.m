//
//  MSSexProfileCell.m
//  TerritoryOfSuccess
//
//  Created by Alex on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSSexProfileCell.h"

@implementation MSSexProfileCell

@synthesize maleSelected = _maleSelected;
@synthesize femaleSelected = _femaleSelected;
@synthesize sexMaleButton = _sexMaleButton;
@synthesize sexFemaleButton = _sexFemaleButton;
@synthesize sexFemaleLabel = _sexFemaleLabel;
@synthesize sexMaleLabel = _sexMaleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sexMaleSelected:(id)sender
{
    if (self.femaleSelected)
    {
        self.maleSelected = YES;
        self.femaleSelected = NO;
        [self.sexMaleButton setBackgroundImage:[UIImage imageNamed:@"checkbox_full.png"] forState:UIControlStateNormal];
        [self.sexFemaleButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)sexFemaleSelected:(id)sender
{
    if (self.maleSelected)
    {
        self.femaleSelected = YES;
        self.maleSelected = NO;
        [self.sexMaleButton setBackgroundImage:[UIImage imageNamed:@"checkbox_empty.png"] forState:UIControlStateNormal];
        [self.sexFemaleButton setBackgroundImage:[UIImage imageNamed:@"checkbox_full.png"] forState:UIControlStateNormal];
    }
}
@end
