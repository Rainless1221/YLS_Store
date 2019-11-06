//
//  DeleteView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/15.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DeleteViewDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)delete_card;

@end

@interface DeleteView : UIView
@property (strong,nonatomic)UIView * Baseview;
//图标
@property (strong,nonatomic)UIImageView * deleteIcon;
//标题
@property (strong,nonatomic)UILabel * deleteLabel;
//内容
@property (strong,nonatomic)UILabel * deleteText;
//删除
@property (strong,nonatomic)UIButton * deleteButton;
//取消
@property (strong,nonatomic)UIButton * cancel;

@property(nonatomic,weak)id<DeleteViewDelegate>delagate;

@property (nonatomic, copy) void(^DeleteCardBlock)(void);

@end
