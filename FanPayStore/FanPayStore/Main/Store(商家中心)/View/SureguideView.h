//
//  SureguideView.h
//  app
//
//  Created by mocoo_ios on 2019/4/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SureguideView : UIView
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) NSInteger imageCount;

+ (instancetype)sureGuideViewWithImageName:(NSString*)imageName
                                imageCount:(NSInteger)imageCount;

- (void)hide;
@end
