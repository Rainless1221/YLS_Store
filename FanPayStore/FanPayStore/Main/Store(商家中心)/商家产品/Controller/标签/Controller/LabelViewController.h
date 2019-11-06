//
//  LabelViewController.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/16.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"
@protocol EditDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)EditDele;

@end

@interface LabelViewController : BaseViewController
@property (strong,nonatomic)UITextField * labelField;

@property (strong,nonatomic)NSString * labelStr;
@property (strong,nonatomic)NSString * category_id;

@property(nonatomic,weak)id<EditDelegate>delagate;

@end
