//
//  TheLabelController.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"
#import "ThelabelCell.h"

@protocol ThelabelDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Addlabel:(NSString *)lableString and:(NSString *)category_id;

@end

@interface TheLabelController : BaseViewController
/*代理*/
@property(nonatomic,weak)id<ThelabelDelegate>delagate;

@end
