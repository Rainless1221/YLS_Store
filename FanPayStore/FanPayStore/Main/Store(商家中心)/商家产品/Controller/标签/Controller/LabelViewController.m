//
//  LabelViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/16.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "LabelViewController.h"

@interface LabelViewController ()<UITextFieldDelegate>
/** 最大字数 */
@property (nonatomic,assign) NSInteger maxLength;
/** 字数限制文本 */
@property (nonatomic, strong) UILabel * lengthLabel;
@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品标签";
    self.view.backgroundColor = MainbackgroundColor;

    /*UI*/
    [self createUI];
}

#pragma mark - UI
-(void)createUI{
    
    UIView *labelview = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 50)];
    labelview.backgroundColor = [UIColor whiteColor];
    labelview.layer.cornerRadius = 5;
    [self.view addSubview:labelview];
    
    
    /*确认修改*/
    UIButton *affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    affirmBtn.frame = CGRectMake(15, labelview.bottom+40, ScreenW-30, 44);
  
//    affirmBtn.backgroundColor = UIColorFromRGB(0x3D89FF);
//    affirmBtn.layer.cornerRadius = 10;
    [affirmBtn addTarget:self action:@selector(affirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    affirmBtn.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    affirmBtn.layer.shadowOffset = CGSizeMake(0,1);
//    affirmBtn.layer.shadowOpacity = 1;
//    affirmBtn.layer.shadowRadius = 9;
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0, 0, ScreenW-30, 44);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.cornerRadius = 10;
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    
//    [affirmBtn.layer addSublayer:gl];
    affirmBtn.layer.cornerRadius = 10;
    affirmBtn.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [affirmBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [affirmBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [affirmBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [self.view addSubview:affirmBtn];
    
    /*删除按钮*/
    UIButton *DeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    DeleteBtn.frame = CGRectMake(15, affirmBtn.bottom+20, ScreenW-30, 44);
    [DeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [DeleteBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    DeleteBtn.backgroundColor = UIColorFromRGB(0xFF6969);
    DeleteBtn.layer.cornerRadius = 10;
    [DeleteBtn addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:DeleteBtn];
    
    self.labelField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, labelview.width-30, 50)];
    self.labelField.delegate = self;
    self.labelField.text = self.labelStr;
    self.labelField.textColor = UIColorFromRGB(0x222222);
    self.labelField.font = [UIFont systemFontOfSize:15];
    [labelview addSubview:self.labelField];

    self.maxLength = 10;

    [labelview addSubview:self.lengthLabel];
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.width.mas_offset(50);
        make.height.mas_offset(50);
        make.right.mas_offset(-5);
    }];
    self.lengthLabel.text = [NSString stringWithFormat:@"%zd/%zd",self.labelStr.length,self.maxLength];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:self.labelField];
}
#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > 9)
            {
                textField.text = [toBeString substringToIndex:9];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > 9)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:9];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:9];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 9)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
    self.lengthLabel.text = [NSString stringWithFormat:@"%zd/%zd",toBeString.length,self.maxLength];
}
#pragma mark - 确认修改
-(void)affirmBtnAction{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]edit_goods_category:model.merchant_id andstore_id:model.store_id andcategory_id:self.category_id  andcategory_name:self.labelField.text Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            [self.navigationController popViewControllerAnimated:YES];
            if (self.delagate && [self.delagate respondsToSelector:@selector(EditDele)]) {
                [self.delagate EditDele];
            }
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    

}
#pragma mark - 删除
-(void)DeleteAction{
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"确定要删除标签吗？删除该标签后，对应该标签的商品会变为空标签。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [self DeletegoodLabel];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
}
-(void)DeletegoodLabel{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]delete_goods_category:model.merchant_id andstore_id:model.store_id andcategory_id:self.category_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            if (self.delagate && [self.delagate respondsToSelector:@selector(EditDele)]) {
                [self.delagate EditDele];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
#pragma mark - 懒加载
- (UILabel *) lengthLabel{
    if(!_lengthLabel){
        _lengthLabel = [UILabel new];
        _lengthLabel.backgroundColor = [UIColor clearColor];
        _lengthLabel.textColor = UIColorFromRGB(0xD1D1D1);
        _lengthLabel.textAlignment = NSTextAlignmentRight;
        _lengthLabel.font = [UIFont systemFontOfSize:17];
        _lengthLabel.text = [[NSString alloc]initWithFormat:@"0/%ld",(long)self.maxLength];
    }
    return _lengthLabel;
}
@end
