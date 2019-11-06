//
//  TheLabeView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "TheLabeView.h"

@implementation TheLabeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
- (void)setTagArray:(NSMutableArray *)tagArray{
    _tagArray = tagArray;
//    [self createUI];

    /** 下拉按钮 */
    [self addSubview:self.pull_down];
    [self.pull_down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_offset(0);
        make.width.mas_offset(40);
    }];
    /** 滚动区域 */
    UIScrollView *Scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width-40, self.height)];
    Scroll.showsVerticalScrollIndicator = FALSE; //垂直滚动条
    Scroll.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    Scroll.contentSize = CGSizeMake(SCREEN_WIDTH, self.height);
    [self addSubview:Scroll];
    
    /** 循环按钮 */
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部",nil];
        for (NSDictionary *dict in tagArray) {
            [array addObject:dict[@"category_name"]];
        }
        [array addObject:@"其他"];

    UIButton *recordBtn = nil;
    
    for (int i = 0; i<array.count; i++) {
        NSString *tabstring = [NSString stringWithFormat:@"%@",array[i]];
        //        static UIButton *recordBtn = nil;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = [tabstring boundingRectWithSize:CGSizeMake(Scroll.width -20, 36) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        
        
        
        CGFloat BtnW = rect.size.width + 20;
        
        
        btn.frame = CGRectMake( recordBtn.frame.origin.x + recordBtn.frame.size.width, 0, BtnW, 36);
        
        
        [btn setTitle:tabstring forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x76ACFF) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0){
            btn.selected =YES;
        }
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width, 0, -10)];
        
        [Scroll addSubview:btn];
        recordBtn = btn;
        Scroll.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+10, self.height);
        
        
    }
}
#pragma mark - UI
-(void)createUI {
    /** 下拉按钮 */
    [self addSubview:self.pull_down];
    [self.pull_down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_offset(0);
        make.width.mas_offset(40);
    }];
    /** 滚动区域 */
    UIScrollView *Scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width-40, self.height)];
    Scroll.showsVerticalScrollIndicator = FALSE; //垂直滚动条
    Scroll.showsHorizontalScrollIndicator = FALSE;//水平滚动条
    Scroll.contentSize = CGSizeMake(SCREEN_WIDTH, self.height);
    [self addSubview:Scroll];
    
    /** 循环按钮 */
//    NSArray *array = @[@"主食",@"推荐菜",@"汤类",@"锅煲",@"特色小食",@"时蔬",@"酒水",@"酒水酒水酒水酒水酒水"];
//    for (NSDictionary *dict in array) {
//        [self.tagArray addObject:dict];
//    }
    
    UIButton *recordBtn = nil;

    for (int i = 0; i<self.tagArray.count; i++) {
        NSString *tabstring = [NSString stringWithFormat:@"%@",self.tagArray[i]];
//        static UIButton *recordBtn = nil;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = [tabstring boundingRectWithSize:CGSizeMake(Scroll.width -20, 36) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        
        
        
        CGFloat BtnW = rect.size.width + 20;
        
        
        btn.frame = CGRectMake( recordBtn.frame.origin.x + recordBtn.frame.size.width, 0, BtnW, 36);

        
        [btn setTitle:tabstring forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x76ACFF) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0){
            btn.selected =YES;
        }
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width, 0, -10)];
        
        [Scroll addSubview:btn];
        recordBtn = btn;
        Scroll.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+10, self.height);

        
    }
    
    
}
#pragma mark - 选中
-(void) BtnClick:(UIButton *)sender{
    for (int i = 0; i<self.tagArray.count+2; i++) {
        if (sender.tag == i+1) {
            sender.selected = YES;
            if (self.delagate && [self.delagate respondsToSelector:@selector(pulllabelcell:)]) {
                [self.delagate pulllabelcell:i];
            }
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+1];
        but.selected = NO;
    }
}

#pragma mark - 懒加载
-(UIButton *)pull_down{
    if (!_pull_down) {
        _pull_down = [UIButton buttonWithType:UIButtonTypeCustom];
        _pull_down.backgroundColor = UIColorFromRGB(0xD6EEFF);
        [_pull_down setImage:[UIImage imageNamed:@"goodsxiala"] forState:UIControlStateNormal];

    }
    return _pull_down;
}
@end
