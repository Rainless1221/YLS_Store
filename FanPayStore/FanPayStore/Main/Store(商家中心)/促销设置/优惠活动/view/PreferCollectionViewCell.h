//
//  PreferCollectionViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PreferCollectionViewCell : UICollectionViewCell
@property (strong,nonatomic)UIImageView * addButton;
@property (strong,nonatomic)UIImageView * pic_Image;
@property (strong,nonatomic)UILabel * Goodname;
@property (strong,nonatomic)UILabel * Goodprice;
@property (strong,nonatomic)UILabel * Goodprice_1;
@property (strong,nonatomic)YCShadowView * icon;
@property (strong,nonatomic)UILabel * icon_text;

@property (strong,nonatomic)UIButton * sedeimage;
@property (assign,nonatomic)BOOL isguan;

@property (strong,nonatomic)NSDictionary * Data;
- (void)setCellWithModel:(PhotoModel *)model;

@end

NS_ASSUME_NONNULL_END
