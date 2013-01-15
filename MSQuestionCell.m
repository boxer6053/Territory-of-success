//
//  MSQuestionCell.m
//  TerritoryOfSuccess
//
//  Created by Matrix Soft on 1/14/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import "MSQuestionCell.h"

@implementation MSQuestionCell
@synthesize gradeButton;

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

- (IBAction)increaseGrade:(id)sender {
    
    self.gradeLabel.text =[NSString stringWithFormat:@"%i", [self.gradeLabel.text integerValue]+1];
    self.gradeButton.enabled = NO;
    
}
@end
