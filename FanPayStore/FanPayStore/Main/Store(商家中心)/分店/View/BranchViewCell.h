//
//  BranchViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BranchViewCell : UICollectionViewCell
@property (strong,nonatomic)UIButton * branchButton;
@property (strong,nonatomic)UIButton * addButton;

@property (strong,nonatomic)UIImageView * branchicon;
@property (strong,nonatomic)UILabel * StoreName;
@property (strong,nonatomic)UIImageView * branchimage;

@property (strong,nonatomic)NSDictionary * Data;


@property (nonatomic, copy) void(^conversionBlock)(void);

@end

NS_ASSUME_NONNULL_END
