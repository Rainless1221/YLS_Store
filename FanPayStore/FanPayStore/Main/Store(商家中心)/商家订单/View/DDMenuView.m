//
//  DDMenuView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "DDMenuView.h"

@implementation DDMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    NSArray *SArray = @[@"全部",@"待支付",@"已支付",@"已评价",@"退单",@"退款"];
    self.SArrayTag = @[@"0",@"1",@"2",@"4",@"6",@"9"];
    CGFloat Bwidth = (ScreenW-45)/SArray.count;

    for (int i =0; i<SArray.count; i++) {
        UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(i*(Bwidth+5)+15, 10, Bwidth, 40);
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",SArray[i]] forState:UIControlStateNormal];
        // 设置阴影偏移量
//        thirdBtn.layer.shadowOffset = CGSizeMake(0,0.5);
        // 设置阴影透明度
//        thirdBtn.layer.shadowOpacity = 0.2;
        // 设置阴影半径
//        thirdBtn.layer.shadowRadius = 0.2;
//        thirdBtn.layer.cornerRadius = 5;
//        thirdBtn.clipsToBounds = NO;
        [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
//        [thirdBtn setBackgroundColor:[UIColor whiteColor]];
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        NSString *tagint = [NSString stringWithFormat:@"%@",self.SArrayTag[i]];
        thirdBtn.tag = [tagint integerValue]+10;
        
        if (i==0) {
//            [thirdBtn setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
            thirdBtn.selected = YES;
            
            UIView *view_line = [[UIView alloc] init];
            view_line.frame = CGRectMake(thirdBtn.left,thirdBtn.bottom,20,2);
            view_line.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
            view_line.layer.shadowColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:0.4].CGColor;
            view_line.layer.shadowOffset = CGSizeMake(0,1);
            view_line.layer.shadowOpacity = 1;
            view_line.layer.shadowRadius = 3;
            view_line.layer.cornerRadius = 1;
            view_line.centerX = thirdBtn.centerX;
            self.view_line = view_line;
            [self addSubview:view_line];
        }else if (i == 4){
            
            CGFloat badgeW   = 12;
            CGSize imageSize = thirdBtn.frame.size;
            CGFloat imageY   = thirdBtn.frame.origin.y;
            
            UILabel *badgeLable = [[UILabel alloc]init];
//            badgeLable.text = [NSString stringWithFormat:@"%ld",2];
            badgeLable.textAlignment = NSTextAlignmentCenter;
            badgeLable.textColor = [UIColor whiteColor];
            badgeLable.font = [UIFont systemFontOfSize:12];
            badgeLable.layer.cornerRadius = badgeW*0.5;
            badgeLable.clipsToBounds = YES;
            badgeLable.backgroundColor = [UIColor redColor];
            badgeLable.layer.borderWidth = 1;
            badgeLable.layer.borderColor = [UIColor redColor].CGColor;
            [badgeLable sizeToFit];
            
            CGFloat badgeX =   imageSize.width - badgeW*2.1;
            CGFloat badgeY = imageY - badgeW*0.5;
            badgeLable.frame = CGRectMake(badgeX, badgeY, badgeW, badgeW);
            [thirdBtn addSubview:badgeLable];
            self.badgeLable = badgeLable;
            [badgeLable setHidden:YES];
        }
        
        
    }
    
    
}

- (void)setIsSelete:(NSInteger)isSelete{

    for (int i = 0; i<self.SArrayTag.count; i++) {
        NSString *tagstr = [NSString stringWithFormat:@"%@",self.SArrayTag[i]];

        if ([tagstr integerValue] == isSelete) {
            UIButton *but = (UIButton *)[self viewWithTag:isSelete+10];
            but.selected = YES;
            self.view_line.centerX = but.centerX;
//            [but setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:[tagstr integerValue]+10];
        but.selected = NO;
//        [but setBackgroundColor:[UIColor whiteColor]];
    }

}

-(void)MerchantButton:(UIButton *)sender{
    for (int i = 0; i<self.SArrayTag.count; i++) {
        NSString *tagstr = [NSString stringWithFormat:@"%@",self.SArrayTag[i]];

        if (sender.tag == [tagstr integerValue]+10) {
            sender.selected = YES;
            self.view_line.centerX = sender.centerX;

//            [sender setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:[tagstr integerValue]+10];
        but.selected = NO;
//        [but setBackgroundColor:[UIColor whiteColor]];
    }
    NSString *tagstr = [NSString stringWithFormat:@"%ld",(long)sender.tag-10];
    if (self.Menublock) {
        self.Menublock(tagstr);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
