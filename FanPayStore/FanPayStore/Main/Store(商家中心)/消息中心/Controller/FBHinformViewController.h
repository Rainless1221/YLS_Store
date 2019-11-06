//
//  FBHinformViewController.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHinformViewController : BaseViewController
/** 类型标题 **/
@property (strong,nonatomic)NSString  * navigationItemText;
/** 类型ID **/
@property (strong,nonatomic)NSString * news_type;
/** 类型 **/

/** 未来读个数 **/
@property (assign,nonatomic)NSInteger Num;

@end
