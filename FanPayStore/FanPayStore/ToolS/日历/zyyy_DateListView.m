//
//  zyyy_DateListView.m
//  日历
//
//  Created by yurong on 2017/7/26.
//  Copyright © 2017年 1. All rights reserved.
//

#import "zyyy_DateListView.h"
#import "zyyy_DateView.h"
#import "DateModel.h"
#import "animationLabel.h"
#define IPHONEHIGHT(b) [UIScreen mainScreen].bounds.size.height*((b)/1334.0)
#define IPHONEWIDTH(a) [UIScreen mainScreen].bounds.size.width*((a)/750.0)


#define contentHeight IPHONEHIGHT(644)

#define dateViewTop IPHONEWIDTH(140)
#define dateViewHeight IPHONEHIGHT(480)

@interface zyyy_DateListView ()<UIScrollViewDelegate,zyyy_DateViewDelegate>
{
    CGFloat width;
    CGFloat height;
    
    CGFloat contentWidth;
    zyyy_DateView *dateViewCurrent;
    zyyy_DateView *dateViewLast;
    zyyy_DateView *dateViewNext;
    
    animationLabel *visibleDateLabel;
}
@end
@implementation zyyy_DateListView
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isEqual:dateViewCurrent]&&[keyPath isEqualToString:@"selectedMonth"]) {
        visibleDateLabel.changeStr = [NSString stringWithFormat:@"%ld年%ld月",dateViewCurrent.selectedYear,dateViewCurrent.selectedMonth];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        width = self.frame.size.width;
        height = self.frame.size.height;
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
        
        contentWidth = [NSString stringWithFormat:@"%0.0f",IPHONEWIDTH(90)*7+IPHONEWIDTH(15)*6+IPHONEWIDTH(5)*2].floatValue;
        //底层视图
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight+80)];
        contentView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
        contentView.center = self.center;
        [self addSubview:contentView];
        
        CGFloat Topheight = IPHONEHIGHT(80);
        CGFloat visibleDateLabelWidth = IPHONEWIDTH(200);
        //年月月份
        visibleDateLabel = [[animationLabel alloc]initWithFrame:CGRectMake(0, 0, visibleDateLabelWidth, Topheight) labelStr:[NSString stringWithFormat:@"%ld年%ld月",[DateModel shareDateModel].year,[DateModel shareDateModel].month]];
        
        visibleDateLabel.center = CGPointMake(contentWidth/2, Topheight/2);
        
        [contentView addSubview:visibleDateLabel];
        //按钮
        
        CGFloat weekBtnBorderInset = IPHONEWIDTH(5);
        CGFloat weekBtnHorizentalInset = IPHONEWIDTH(15);
        CGFloat weekBtnSize = IPHONEWIDTH(90);
        //星期
        NSArray *weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        for (int index = 0; index<7; index++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(weekBtnBorderInset+index*(weekBtnHorizentalInset+weekBtnSize), Topheight, weekBtnSize, weekBtnSize)];
            btn.adjustsImageWhenHighlighted = NO;
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(34)];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:weekArray[index] forState:UIControlStateNormal];
            [contentView addSubview:btn];
        }
        
        //日历的范围
        _dateScroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, dateViewTop, contentWidth, dateViewHeight)];
        _dateScroView.showsHorizontalScrollIndicator = NO;
        _dateScroView.pagingEnabled = YES;
        _dateScroView.contentSize = CGSizeMake(contentWidth*3, 0);
        _dateScroView.bounces = NO;
        _dateScroView.delegate = self;
        _dateScroView.contentOffset = CGPointMake(contentWidth, 0);
        [contentView addSubview:_dateScroView];
        
        dateViewLast = [[zyyy_DateView alloc]initWithFrame:CGRectMake(0, 0, contentWidth, dateViewHeight)];
        dateViewLast.selectedMonth = [DateModel shareDateModel].lastMonth;
        
        dateViewLast.isSelected = NO;
        [_dateScroView addSubview:dateViewLast];
        
        dateViewCurrent = [[zyyy_DateView alloc]initWithFrame:CGRectMake(contentWidth, 0, contentWidth, dateViewHeight)];
        dateViewCurrent.isSelected = YES;
        [dateViewCurrent addObserver:self forKeyPath:@"selectedMonth" options:NSKeyValueObservingOptionNew context:nil];
        dateViewCurrent.delegate = self;
        [_dateScroView addSubview:dateViewCurrent];
        
        dateViewNext = [[zyyy_DateView alloc]initWithFrame:CGRectMake(contentWidth*2, 0, contentWidth, dateViewHeight)];
        dateViewNext.isSelected = NO;
        dateViewNext.selectedMonth = [DateModel shareDateModel].nextMonth;
        [_dateScroView addSubview:dateViewNext];
        
        
        //选择按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(22, _dateScroView.bottom + 20, contentView.width -40, 44)];
        btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(34)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"确定选择" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"bg_withdraw_account_amount"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(QuedingAction) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:btn];
        
    }
    return self;
}
//确定选择
-(void)QuedingAction
{
    [self removeFromSuperview];
}

#pragma mark -UIScroviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (!scrollView.dragging) {
        return;
    }
    
        //手动执行
        if (scrollView.contentOffset.x<contentWidth&&dateViewCurrent.selectedMonth==[DateModel shareDateModel].month&&dateViewCurrent.selectedYear==[DateModel shareDateModel].year) {
            
            scrollView.scrollEnabled = NO;
            
            
        }else{
            NSLog(@"%f  %f ",scrollView.contentOffset.x,contentWidth);
            if (scrollView.contentOffset.x == 2*contentWidth) {
                //下月
                dateViewCurrent.selectedMonth+=1;
                dateViewLast.selectedMonth+=1;
                dateViewNext.selectedMonth+=1;
                
                [scrollView setContentOffset:CGPointMake(contentWidth, 0) animated:NO];
            }else if(scrollView.contentOffset.x == 0){
                //上月
                dateViewCurrent.selectedMonth-=1;
                dateViewLast.selectedMonth-=1;
                dateViewNext.selectedMonth-=1;
                [scrollView setContentOffset:CGPointMake(contentWidth, 0) animated:NO];
            }

        }
  
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    scrollView.scrollEnabled = YES;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    scrollView.scrollEnabled = YES;
}
#pragma mark -zyyy_DateViewDelegate
-(void)selectedDic:(NSDictionary *)dic{
    NSLog(@"选择的：%@",dic);
    if (_delegate && [_delegate respondsToSelector:@selector(moveImageBtnClick:andData:)]) {
        [_delegate moveImageBtnClick:self andData:dic];
    }
}
@end
