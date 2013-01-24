//
//  MSNewsDetailsViewController.h
//  TerritoryOfSuccess
//
//  Created by Alex on 1/21/13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAPI.h"

@interface MSNewsDetailsViewController : UIViewController <WsCompleteDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *articleTextView;

-(void)setContentOfArticleWithId:(NSString *)articleId;

@end
