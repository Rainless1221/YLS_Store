//
//  SearchBarView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/2.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarView : UIView<UITextFieldDelegate>
@property (strong,nonatomic)UIImageView * icon;
@property (strong,nonatomic)UIButton   * QuXiao;
@property (strong,nonatomic)UITextField   * SearchField;

@end

NS_ASSUME_NONNULL_END
