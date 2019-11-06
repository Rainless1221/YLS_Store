//
//  GYZCityHeaderView.m
//  GYZChooseCityDemo
//
//  Created by wito on 15/12/29.
//  Copyright © 2015年 gouyz. All rights reserved.
//

#import "GYZCityHeaderView.h"

@implementation GYZCityHeaderView
- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(15, 0, ScreenW-25 , self.frame.size.height)];
}
#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_titleLabel setTextColor:[UIColor blackColor]];
    }
    return _titleLabel;
}
@end
