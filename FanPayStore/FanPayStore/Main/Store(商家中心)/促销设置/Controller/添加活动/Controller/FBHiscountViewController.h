//
//  FBHiscountViewController.h
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/4/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHiscountViewController : BaseViewController
@property (strong,nonatomic)NSString * discount_id;
@property (strong,nonatomic)NSDictionary * Data_dict;
/** 返回的图片地址 */
@property (strong,nonatomic)NSMutableArray * UrlimageArr;
@end
