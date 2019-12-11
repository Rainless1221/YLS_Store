//
//  YLSAddProductController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddProductController.h"
#import "YLSAddProductView.h"
#define  image_H 0

@interface YLSAddProductController ()<ThelabelDelegate,AddProductDelegate>
@property (strong,nonatomic)UIScrollView * ProductScrollView;
@property (strong,nonatomic)YLSAddProductView *  ProductView;
/*标签ID*/
@property (strong,nonatomic)NSString * category_id;

@end

@implementation YLSAddProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";
    /**
     UI
     */
    [self createUI];
    
}
#pragma mark - UI
-(void)createUI{
     [self.view addSubview:self.ProductScrollView];
    self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1200+image_H);
    [self.ProductScrollView addSubview:self.ProductView];
  
   
    
}
#pragma mark - 添加标签
-(void)andTheLabel{
    TheLabelController *VC = [TheLabelController new];
    VC.delagate = self;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)Addlabel:(NSString *)lableString and:(NSString *)category_id{
    
    if ([[MethodCommon judgeStringIsNull:lableString] isEqualToString:@""]) {
        self.category_id = @"0";
        return;
    }
    
    self.category_id = category_id;
    CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat BtnW = rect.size.width + 20;
    CGFloat BtnH = rect.size.height + 12;
    self.ProductView.TheLabelButton.size = CGSizeMake(BtnW+25, 32);// CGRectMake(94, 9, BtnW+25, BtnH);
    [self.ProductView.TheLabelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(BtnW+25, BtnH));
    }];
    [self.ProductView.TheLabelButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [self.ProductView.TheLabelButton setTitle:[NSString stringWithFormat:@"%@",lableString] forState:UIControlStateNormal];
    [self.ProductView.TheLabelButton setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateSelected];
    [self.ProductView.TheLabelButton setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+15, 0, -10)];
    [self.ProductView.TheLabelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];
    
    self.ProductView.TheLabelButton.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    self.ProductView.TheLabelButton.backgroundColor = UIColorFromRGB(0xFCF6DE);
    self.ProductView.TheLabelButton.layer.borderWidth = 1;
    self.ProductView.TheLabelButton.layer.cornerRadius = self.ProductView.TheLabelButton.height/2;
    self.ProductView.TheLabelButton.selected = YES;
    [self.ProductView.TheLabelButton addTarget:self action:@selector(deleteLa) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.ProductView.AttributelButton setTitle:@"编辑属性" forState:UIControlStateNormal];
    [self.ProductView.AttributelButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    self.ProductView.AttributelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
  
    
}
#pragma mark - 删除标签
-(void)deleteLa{
    self.category_id = @"0";

    NSString *lableString  =@"请选择商品标签" ;
    CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat BtnW = rect.size.width + 20;
    CGFloat BtnH = rect.size.height + 12;
    [self.ProductView.TheLabelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(BtnW+25, BtnH));
    }];
    [self.ProductView.TheLabelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];

    [self.ProductView.TheLabelButton setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    [self.ProductView.TheLabelButton setTitle:lableString forState:UIControlStateNormal];
    self.ProductView.TheLabelButton.layer.borderWidth = 0;
    self.ProductView.TheLabelButton.selected = NO;
    self.ProductView.TheLabelButton.backgroundColor = [UIColor whiteColor];
    
    
}
#pragma mark - 添加商品属性
-(void)andAttribute{
    YLSCommodityAttriController *VC = [YLSCommodityAttriController new];
//    VC.delagate = self;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 懒加载
-(UIScrollView *)ProductScrollView{
    if (!_ProductScrollView) {
        _ProductScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ProductScrollView.backgroundColor = MainbackgroundColor;
        _ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1200+image_H);
    }
    return _ProductScrollView;
}
-(YLSAddProductView *)ProductView{
    if (!_ProductView) {
        _ProductView = [[YLSAddProductView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH*1.3)];
        _ProductView.delagate = self;
    }
    return _ProductView;
}
@end
