//
//  RoomsViewone.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RoomsOneDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)BedAtion:(UIButton *)sender;


@end


@interface RoomsViewone : UIView<PPNumberButtonDelegate>
@property (strong,nonatomic)UIView * BaseView_1;
@property (strong,nonatomic)UIView * BaseView_2;
@property (strong,nonatomic)UIView * BaseView_3;

@property (strong,nonatomic)UITextField * Name;
@property (strong,nonatomic)UITextField * area;
@property (strong,nonatomic)UIButton * Bedtype;
@property (nonatomic, strong) PPNumberButton *numberButton_1;
@property (nonatomic, strong) PPNumberButton *numberButton_2;

@property (strong,nonatomic)XMTextView * textv;

/*代理*/
@property(nonatomic,weak)id<RoomsOneDelegate>delagate;
@end

NS_ASSUME_NONNULL_END
