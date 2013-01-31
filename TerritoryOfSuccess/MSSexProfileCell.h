//
//  MSSexProfileCell.h
//  TerritoryOfSuccess
//
//  Created by Alex on 1/29/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSSexProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sexMaleButton;
@property (weak, nonatomic) IBOutlet UILabel *sexMaleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexFemaleButton;
@property (weak, nonatomic) IBOutlet UILabel *sexFemaleLabel;

@property (nonatomic) BOOL maleSelected;
@property (nonatomic) BOOL femaleSelected;

- (IBAction)sexMaleSelected:(id)sender;
- (IBAction)sexFemaleSelected:(id)sender;

@end
