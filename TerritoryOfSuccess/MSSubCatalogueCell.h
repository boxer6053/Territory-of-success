//
//  MSSubCatalogueCell.h
//  TerritoryOfSuccess
//
//  Created by matrixsoft on 28.01.13.
//  Copyright (c) 2013 Matrix Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSSubCatalogueCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UIImageView *productRatingImage;
@property (nonatomic) int productAdviceNumber;
@property (nonatomic) int productCommentsNumber;
@property (nonatomic) int productRatingNumber;
@property (strong, nonatomic) NSString *productImageURL;
@end
