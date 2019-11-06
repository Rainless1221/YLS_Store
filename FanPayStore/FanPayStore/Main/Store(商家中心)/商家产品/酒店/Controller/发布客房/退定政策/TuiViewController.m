//
//  TuiViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "TuiViewController.h"

@interface TuiViewController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;

@property (strong,nonatomic)UIButton * SaveBtn;
@property (strong,nonatomic)UIButton * nextStepBtn;
@end

@implementation TuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"退定政策";

    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.mas_offset(-59);
    }];
    [self.view addSubview:self.SaveBtn];
    [self.view addSubview:self.nextStepBtn];
    
    [self.SaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SJScrollView.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.height.mas_offset(40);
        make.width.mas_offset((ScreenW-40)/2);
    }];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SJScrollView.mas_bottom).offset(10);
        make.right.mas_offset(-15);
        make.height.mas_offset(40);
        make.width.mas_offset((ScreenW-40)/2);
    }];
    
    
    NSArray *Arr = @[
                     @{@"label":@"宽松",@"text":@"入住前1天12:00前退订，可获得100%退款。之后退定不可退款。",@"Color":@"37A94A"},
                     @{@"label":@"适中",@"text":@"入住前5天12:00前退订，可获得100%退款。之后退定不可退款。",@"Color":@"F7AE2A"},
                     @{@"label":@"严格",@"text":@"入住前7天12:00前退订，可获得50%退款。之后退定不可退款。",@"Color":@"EB503C"}
                     ];
    
    
    for (int i = 0; i<Arr.count; i++) {
        
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(15,20+i*100,ScreenW-30,85);
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.cornerRadius = 5;
        [view setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [view setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        view.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [view addTarget:self action:@selector(SetupAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.SJScrollView addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(11,15,60,14.5);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.text = [NSString stringWithFormat:@"%@",Arr[i][@"label"]];
        NSString *colorS = [NSString stringWithFormat:@"%@",Arr[i][@"Color"]];
        label.textColor = [UIColor colorWithHexString:colorS];
        [view addSubview: label];
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(8,38,view.width-70,35);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:12];
        label_1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        label_1.text = [NSString stringWithFormat:@"%@",Arr[i][@"text"]];
        [view addSubview: label_1];
        
    }
    
}
/*选择*/
-(void)SetupAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 710);
    }
    return _SJScrollView;
}
-(UIButton *)SaveBtn{
    if (!_SaveBtn) {
        _SaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _SaveBtn.frame = CGRectMake(15,897,167.5,40);
        _SaveBtn.layer.borderWidth = 1;
        _SaveBtn.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        [_SaveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_SaveBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_SaveBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _SaveBtn.layer.cornerRadius = 20;
        
    }
    return _SaveBtn;
}
-(UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextStepBtn.frame = CGRectMake(15,897,167.5,40);
        _nextStepBtn.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_nextStepBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _nextStepBtn.layer.cornerRadius = 20;
        
    }
    return _nextStepBtn;
}
@end
