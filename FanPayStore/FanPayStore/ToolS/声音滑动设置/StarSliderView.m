//
//  StarSliderView.m
//  GSYSlider
//
//  Created by apple on 2017/5/6.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "StarSliderView.h"
@interface StarSliderView(){
    NSMutableArray *_imgViewArray;
    NSMutableArray *_imgViewArray1;

}
@end

//设置星星个数
#define kStarsNum 9
//设置星星大小
#define kstarImgWitch (self.frame.size.width-_distance*(kStarsNum+1))/kStarsNum

@implementation StarSliderView

-(instancetype)initWithFrame:(CGRect)frame andWithCurrentStarNum:(int)currentStarNum andUserEnabled:(BOOL)nabled andWithDistance:(float)distance{
    self = [super initWithFrame:frame];
  
    if (self) {
        self.userInteractionEnabled = nabled;
        _distance =distance;
        [self createView];
      
        if (currentStarNum != 0 &&currentStarNum <= kStarsNum) {
            [self highlightStarShow:currentStarNum];
        }
    }
    return self;
}

#pragma mark - - 
-(void)createView{
    _imgViewArray = [NSMutableArray array];
    _imgViewArray1 = [NSMutableArray array];

    //默认状态
    for (int i = 0; i<kStarsNum; i++) {
        //
        self.viewNomal = [[UIView alloc] init];
        self.viewNomal.frame = CGRectMake(_distance+(kstarImgWitch+_distance)*i, 9, 6,  32);
        self.viewNomal.tag = i;
        self.viewNomal.layer.cornerRadius = 3;
        self.viewNomal.backgroundColor = [UIColor colorWithRed:206/255.0 green:225/255.0 blue:253/255.0 alpha:1.0];
        [self addSubview:self.viewNomal];
         [_imgViewArray1 addObject:self.viewNomal];
//        UIImageView *imgViewNomal = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_star_evaluation_normal"]];
//        imgViewNomal.frame = CGRectMake(_distance+(kstarImgWitch+_distance)*i, 0, kstarImgWitch,  kstarImgWitch);
//        imgViewNomal.tag = i;
//        [self addSubview:imgViewNomal];
        
        //
        self.ViewSeleted = [[UIView alloc] init];
        self.ViewSeleted.frame = CGRectMake(_distance+(kstarImgWitch+_distance)*i, 9, 6,  32);
        self.ViewSeleted.tag = i;
        self.ViewSeleted.hidden = YES;
        self.ViewSeleted.layer.cornerRadius = 3;
        self.ViewSeleted.backgroundColor = [UIColor colorWithRed:65/255.0 green:137/255.0 blue:243/255.0 alpha:1.0];
        [self addSubview:self.ViewSeleted];
        [_imgViewArray addObject:self.ViewSeleted];
        
//        UIImageView *imgViewSeleted = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_star_evaluation_press"]];
//        imgViewSeleted.frame = CGRectMake(_distance+(kstarImgWitch+_distance)*i, 0, kstarImgWitch,  kstarImgWitch);
//        imgViewSeleted.hidden = YES;
//        imgViewSeleted.tag = i;
//        [self addSubview:imgViewSeleted];
//        [_imgViewArray addObject:imgViewSeleted];
    }
#pragma mark - 主视图大小
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 50);
}

#pragma mark - -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self showStarSlider:pt.x];
//    [self selectAnimal:pt.x];
}

#pragma mark - -
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self showStarSlider:pt.x];
}

#pragma mark - -
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self showStarSlider:pt.x];
//    [self selectAnimal:pt.x];
}

#pragma mark - - 展示滑杆
-(void)showStarSlider:(float)pt{
    int num;
    
    //0*
    if (pt<_distance) {
        for (int i = 0; i<_imgViewArray.count; i++) {
            UIView *imgView = _imgViewArray[i];
            imgView.hidden = YES;
            
             UIView *imgView1 = _imgViewArray1[i];
            imgView1.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0];
        }
        num = 0;
        
    //5*
    }else if (pt>=(kstarImgWitch*kStarsNum+_distance*kStarsNum)){
        for (int i = 0; i<_imgViewArray.count; i++) {
            UIView *imgView = _imgViewArray[i];
            imgView.hidden = NO;
            UIView *imgView1 = _imgViewArray1[i];
            imgView1.backgroundColor = [UIColor colorWithRed:206/255.0 green:225/255.0 blue:253/255.0 alpha:1.0];
        }
        num = kStarsNum;
        
    //1—5*
    }else{
        int  currentInt = pt/(kstarImgWitch+_distance);
        for (int i =0; i<=currentInt; i++) {
            UIView *imgView = _imgViewArray[i];
            imgView.hidden = NO;
            UIView *imgView1 = _imgViewArray1[i];
            imgView1.backgroundColor = [UIColor colorWithRed:206/255.0 green:225/255.0 blue:253/255.0 alpha:1.0];
        }
        for (int i = currentInt+1; i<=_imgViewArray.count-1; i++) {
            UIView *imgView = _imgViewArray[i];
            imgView.hidden = YES;
            UIView *imgView1 = _imgViewArray1[i];
            imgView1.backgroundColor = [UIColor colorWithRed:206/255.0 green:225/255.0 blue:253/255.0 alpha:1.0];
        }
        num = currentInt +1;
    }
    
    //
    if ( [_delegate respondsToSelector:@selector(starSliderMoveWithCurrentNum:Slider:)]) {
        [_delegate starSliderMoveWithCurrentNum:num Slider:pt];
    }
    
}

#pragma mark - - 简单动画效果
-(void)selectAnimal:(float)pt{
    UIImageView *imgViewanimal = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_star_evaluation_press"]];
    imgViewanimal.frame = CGRectMake(pt,0, 19, 19);
    imgViewanimal.alpha = 0.3;
    [self addSubview:imgViewanimal];
   
    [UIView animateWithDuration:0.5 animations:^{
        imgViewanimal.frame = CGRectMake(pt,-30, 19, 19);
        imgViewanimal.alpha = 0;
    }];
    [self performSelector:@selector(delayMethod:) withObject:imgViewanimal afterDelay:0.5];
}

//个人习惯喜欢延时操作也可以使用动画执行之后的操作
#pragma mark - - 动画延时
-(void)delayMethod:(UIView*)view{
    [view removeFromSuperview];
    view = nil;
}

#pragma mark - -
-(void)highlightStarShow:(int)currentInt{
    for (int i =0; i<=currentInt-1; i++) {
        UIView *imgView = _imgViewArray[i];
        imgView.hidden = NO;
    }
    for (int i = currentInt; i<=_imgViewArray.count-1; i++) {
        UIView *imgView = _imgViewArray[i];
        imgView.hidden = YES;
    }
}
@end
