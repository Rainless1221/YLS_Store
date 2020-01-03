//
//  YLSCommodityAttriController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AttriAndDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)AddlAttri:(NSString *)lableString and:(NSString *)category_id and:(NSMutableArray * )Array;

@end

@interface YLSCommodityAttriController : BaseViewController
/** 数据 **/
@property (strong,nonatomic)NSMutableArray * Data;
/*代理*/
@property(nonatomic,weak)id<AttriAndDelegate>delagate;
@end

NS_ASSUME_NONNULL_END
