//
//  FBHinformDetailViewController.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHinformDetailViewController : BaseViewController
@property (strong,nonatomic)NSString * news_id;
@property (strong,nonatomic)NSString * navigationItemText;
/** 标题 */
@property (strong,nonatomic)UILabel * news_title;
/** 内容 */
@property (strong,nonatomic)UILabel * news_content;
/** 时间 */
@property (strong,nonatomic)UILabel * add_time;
/* 图片 */
@property (strong,nonatomic)UIImageView * news_pic;

@property (strong,nonatomic)NSDictionary * Data;
@end
