//
//  CHTableViewCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  已下架商品

#import <UIKit/UIKit.h>

@interface CHTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodname;//名称
@property (weak, nonatomic) IBOutlet UIButton *DeleteButtom;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;//价格
@property (weak, nonatomic) IBOutlet UILabel *goods_count;
@property (weak, nonatomic) IBOutlet UILabel *goods_desc;
@property (weak, nonatomic) IBOutlet UIImageView *goods_pic;
@property (weak, nonatomic) IBOutlet UIButton *bianjiButton;
@property (weak, nonatomic) IBOutlet UIButton *shangjiaButton;
@property (weak, nonatomic) IBOutlet UILabel *discount_price;


@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^onlineBlock)(void);
@property (nonatomic, copy) void(^DeleteBlock)(void);
@property (nonatomic, copy) void(^BianjiBlock)(void);

@end
