//
//  SearchBarView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/2.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Search:(NSString *)SearchString;

@end
@interface SearchBarView : UIView<UITextFieldDelegate>
@property (strong,nonatomic)UIImageView * icon;
@property (strong,nonatomic)UIButton   * QuXiao;
@property (strong,nonatomic)UITextField   * SearchField;
@property(nonatomic,weak)id<SearchDelegate>delagate;

@end

NS_ASSUME_NONNULL_END
