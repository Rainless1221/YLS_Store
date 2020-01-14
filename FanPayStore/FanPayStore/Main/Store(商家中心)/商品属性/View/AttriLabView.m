//
//  AttriLabView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/30.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "AttriLabView.h"

@implementation AttriLabView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
-(void)setTagArray:(NSMutableArray *)tagArray {
    [self.tagButtons removeAllObjects];
    for (NSString *tagStr in tagArray) {
        [self addTag:tagStr];
    }
    
}
#pragma mark - 点击
- (void)clickTag:(UIButton *)button
{
    
    // 获取对应的标题按钮
    //    UIButton *SeleButton = self.tagButtons[button.tag];
    NSLog(@"%ld",button.tag);
    for (int i = 1; i< self.tagButtons.count+1; i++) {

        if (button.tag == i) {
            [self.tagButtons removeObjectAtIndex:button.tag-1];

            // 设置按钮的位置
//            [self updateTagButtonFrame:button.tag extreMargin:YES];

            [self updateLaterTagButtonFrame:button.tag-1];
            /* 选中的标签 */
            if (self.delagate && [self.delagate respondsToSelector:@selector(Addlabelcell: and:)]) {
                [self.delagate Addlabelcell:button.titleLabel.text and:button.tag-1];
            }

        }
        


    }




    // 更新自己的高度
    CGRect frame = self.frame;
    frame.size.height = self.tagListH+10;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
}







// 添加标签
- (void)addTag:(NSString *)tagStr{
    
    NSString *strUrl = [tagStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([[MethodCommon judgeStringIsNull:strUrl] isEqualToString:@""]) {
        return;
    }
    
    // 创建标签按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tagButton.layer.cornerRadius = 15;
    tagButton.layer.borderWidth = 1;
    tagButton.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
    tagButton.clipsToBounds = YES;
    tagButton.tag = self.tagButtons.count+1;
    [tagButton setImage:[UIImage imageNamed:@"icn_delete_key_gray"] forState:UIControlStateSelected];
//    [tagButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_pressed"] forState:UIControlStateDisabled];
    

    
    
    [tagButton setTitle:strUrl forState:UIControlStateNormal];
    [tagButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    tagButton.backgroundColor = UIColorFromRGB(0xF9F9F9);
    tagButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [tagButton addTarget:self action:@selector(clickTag:) forControlEvents:UIControlEventTouchUpInside];
    tagButton.selected = YES;
    [self addSubview:tagButton];
    
    // 保存到数组
    [self.tagButtons addObject:tagButton];
    
    // 设置按钮的位置
//    [self updateTagButtonFrame:tagButton.tag extreMargin:YES];
    
    // 设置按钮的位置
    [self updateTagButtonFrame:tagButton.tag extreMargin:YES];
    
    // 更新自己的高度
    
    CGRect frame = self.frame;
    frame.size.height = self.tagListH+10;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
    
    self.LabelButton = tagButton;
    
}


- (void)updateLaterTagButtonFrame:(NSInteger)laterI
{
    NSInteger count = self.tagButtons.count;
    
    for (NSInteger i = laterI; i < count+1; i++) {
        
        // 获取上一个按钮
        NSInteger preI = i -2;
        
        // 定义上一个按钮
        UIButton *preButton;
        
        // 过滤上一个角标
        if (preI >= 0) {
            preButton = self.tagButtons[preI];
        }
        // 获取当前按钮
        if (i==0) {
            i++;
        }else{
            UIButton *tagButton = self.tagButtons[i-1];
            
            [self setupTagButtonCustomFrame:tagButton preButton:preButton extreMargin:YES];
        }
       
    }
}
- (void)updateTagButtonFrame:(NSInteger)i extreMargin:(BOOL)extreMargin
{
    // 获取上一个按钮
    NSInteger preI = i-2;
    
    // 定义上一个按钮
    UIButton *preButton;
    
    // 过滤上一个角标
    if (preI >= 0) {
        preButton = self.tagButtons[preI];
    }
    
    
    // 获取当前按钮
    UIButton *tagButton = self.tagButtons[i-1];
    
    
    [self setupTagButtonCustomFrame:tagButton preButton:preButton extreMargin:extreMargin];
    
}

// 设置标签按钮frame（自适应）
- (void)setupTagButtonCustomFrame:(UIButton *)tagButton preButton:(UIButton *)preButton extreMargin:(BOOL)extreMargin
{
    // 等于上一个按钮的最大X + 间距
    CGFloat btnX = CGRectGetMaxX(preButton.frame) + 10;
    
    // 等于上一个按钮的Y值,如果没有就是标签间距
    CGFloat btnY = preButton? preButton.frame.origin.y : 10;
    
    // 获取按钮宽度
    CGFloat titleW = [tagButton.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:15]].width;
    CGFloat titleH = [tagButton.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:15]].height;
    
    CGFloat btnW = extreMargin?titleW + 20
    : tagButton.bounds.size.width;
    if (tagButton.selected == YES && extreMargin == YES) {
        btnW += 20;
        //        btnW += 5;
        
        
        
    }
    
    // 获取按钮高度
    CGFloat btnH = extreMargin? titleH + 2 * 5:tagButton.bounds.size.height;
    if (tagButton.selected == YES && extreMargin == YES) {
        //        CGFloat height = 20 > titleH ? 20 : titleH;
        //        btnH = height + 2 * 5;
        
        [tagButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - 10, 0, 10)];
        
        //        CGFloat imageX = btnW - tagButton.imageView.frame.size.width -  5;
        //        tagButton.imageView.frame = CGRectMake(imageX, (btnH - 20) * 0.5, 20, 20);
        [tagButton setImageEdgeInsets:UIEdgeInsetsMake(0, (btnW - 20), 0, -10)];
        
    }else{
        [tagButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [tagButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    
    // 判断当前按钮是否足够显示
    CGFloat rightWidth = self.bounds.size.width - btnX;
    
    if (rightWidth < btnW) {
        // 不够显示，显示到下一行
        btnX = 10;
        btnY = CGRectGetMaxY(preButton.frame) + 10;
    }
    
    
    tagButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    
    
}
- (CGFloat)tagListH
{
    if (self.tagButtons.count <= 0) {
        return 0;
    }else{
        return CGRectGetMaxY([(UIView *)self.tagButtons.lastObject frame]) + 10;
        
    }
}
- (NSMutableArray *)tagButtons
{
    if (_tagButtons == nil) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
@end
