//
//  CHTableViewCellT.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//      上架中的商品

#import <UIKit/UIKit.h>

@interface CHTableViewCellT : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodname;
@property (weak, nonatomic) IBOutlet UIButton *DeleteButton;
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
@property (weak, nonatomic) IBOutlet UILabel *goods_count;
@property (weak, nonatomic) IBOutlet UILabel *goods_desc;
@property (weak, nonatomic) IBOutlet UIImageView *goods_pic;
@property (weak, nonatomic) IBOutlet UIButton *bianjiButton;
@property (weak, nonatomic) IBOutlet UILabel *discount_price;

@property (strong,nonatomic)NSDictionary * Data;
@property (nonatomic, copy) void(^saleBlock)(void);
@property (nonatomic, copy) void(^editorBlock)(void);

@end
