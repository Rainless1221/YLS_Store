//
//  SZCollectionViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goods_pic;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
@property (weak, nonatomic) IBOutlet UILabel *goods_count;
@property (weak, nonatomic) IBOutlet UILabel *discount_price;

@property (strong,nonatomic)UIButton * sedeimage;
//@property (strong,nonatomic)UIImageView * sedeimage;
@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^SelectedBlock)(UIButton * btn);

@end
