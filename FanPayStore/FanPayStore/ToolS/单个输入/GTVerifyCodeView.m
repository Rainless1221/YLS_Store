//
//  GTVerifyCodeView.m
//  codeView
//
//  Created by Thinkive on 2017/11/19.
//  Copyright © 2017年 Thinkive. All rights reserved.
//

#import "GTVerifyCodeView.h"

#import "UIView+MBLayout.h"
#import "UIColor+Extend.h"
#import "UITextField+GTExtend.h"

@interface GTVerifyCodeView ()<UITextFieldDelegate,GTTextFieldDelegate>
/** */
@property (nonatomic, weak) UITextField *codeTextField;
@property (nonatomic, weak) UILabel *label1;
@property (nonatomic, weak) UILabel *label2;
@property (nonatomic, weak) UILabel *label3;
@property (nonatomic, weak) UILabel *label4;
@property (nonatomic, weak) UILabel *label5;
@property (nonatomic, weak) UILabel *label6;

@property (nonatomic, weak) UILabel *label7;
@property (nonatomic, weak) UILabel *label8;
@property (nonatomic, weak) UILabel *label9;
@property (nonatomic, weak) UILabel *label10;
@property (nonatomic, weak) UILabel *label11;
@property (nonatomic, weak) UILabel *label12;

/** */
@property (nonatomic, copy) OnFinishedEnterCode onFinishedEnterCode;
@end

@implementation GTVerifyCodeView

- (instancetype)initWithFrame:(CGRect)frame onFinishedEnterCode:(OnFinishedEnterCode)onFinishedEnterCode {
    if (self = [super initWithFrame:frame]) {
        CGFloat labWidth = 50;
        CGFloat labHeight = 50;
        CGFloat spacing = 9;
        CGFloat margin = (self.width-labWidth*6-spacing*5)/2.;
        
        if (onFinishedEnterCode) {
            _onFinishedEnterCode = [onFinishedEnterCode copy];
        }
        
        
        for (NSInteger i = 0; i<12; i++) {
            NSInteger index = i % 6;
            NSInteger page = i / 6;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(margin+(labWidth+spacing)*index, page*(labHeight+20), labWidth, labHeight)];
            label.tag = 100+i;
            label.backgroundColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:autoScaleW(38)];
            [label setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
            [self addSubview:label];
            if (i == 0) {
                _label1 = label;
            }else if (i == 1) {
                _label2 = label;
            }else if (i == 2) {
                _label3 = label;
            }else if (i == 3){
                _label4 = label;
            }else if (i == 4){
                _label5 = label;
            }else if (i == 5){
                _label6 = label;
            }else if (i == 6) {
                _label7 = label;
            }else if (i == 7) {
                _label8 = label;
            }else if (i == 8){
                _label9 = label;
            }else if (i == 9){
                _label10 = label;
            }else if (i == 10){
                _label11 = label;
            }else if (i == 11){
                _label12 = label;
            }
            
        }
        
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, labWidth, labHeight)];
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentCenter;
        [textField setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        textField.keyboardType = UIKeyboardTypeDecimalPad;
//        textField.font = [UIFont systemFontOfSize:autoScaleW(38)];
        [self addSubview:textField];
        _codeTextField = textField;
        
        [textField becomeFirstResponder];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!self.label1.text.length) {
        self.label1.text = string;
        [self.label1 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label2.left;
        _codeTextField.centerY = _label2.centerY;
    }else if (!self.label2.text.length) {
        self.label2.text = string;
        [self.label2 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label3.left;
        _codeTextField.centerY = _label3.centerY;
    }else if (!self.label3.text.length) {
        self.label3.text = string;
        [self.label3 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label4.left;
        _codeTextField.centerY = _label4.centerY;
    }else if (!self.label4.text.length) {
        self.label4.text = string;
        [self.label4 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label5.left;
        _codeTextField.centerY = _label5.centerY;
    }else if (!self.label5.text.length) {
        self.label5.text = string;
        [self.label5 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label6.left;
        _codeTextField.centerY = _label6.centerY;
    }else if (!self.label6.text.length) {
        self.label6.text = string;
        [self.label6 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label7.left;
        _codeTextField.centerY = _label7.centerY;
    }else if (!self.label7.text.length) {
        self.label7.text = string;
        [self.label7 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label8.left;
        _codeTextField.centerY = _label8.centerY;
    }else if (!self.label8.text.length) {
        self.label8.text = string;
        [self.label8 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label9.left;
        _codeTextField.centerY = _label9.centerY;
    }else if (!self.label9.text.length) {
        self.label9.text = string;
        [self.label9 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label10.left;
        _codeTextField.centerY = _label10.centerY;
    }else if (!self.label10.text.length) {
        self.label10.text = string;
        [self.label10 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label11.left;
        _codeTextField.centerY = _label11.centerY;
    }else if (!self.label11.text.length) {
        self.label11.text = string;
        [self.label11 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label12.left;
        _codeTextField.centerY = _label12.centerY;
    }
    else if (!self.label12.text.length) {
        self.label12.text = string;
        [self.label12 setCornerWithRadius:5.f borderWidth:2 borderColor:[UIColor appBaseColor]];
        _codeTextField.left = _label12.left;
        
//        [_codeTextField resignFirstResponder];
        
        if (_onFinishedEnterCode) {
            NSString *code = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@%@%@",_label1.text,_label2.text,_label3.text,_label4.text,_label5.text,_label6.text,_label7.text,_label8.text,_label9.text,_label10.text,_label11.text,_label12.text];
            _onFinishedEnterCode(code);
        }
        
    }
    return NO;
}
#pragma mark -回删
- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    if (self.label12.text.length) {
        self.label12.text = @"";
        [self.label12 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label12.left;
        _codeTextField.centerY = _label12.centerY;
    }else if (self.label11.text.length) {
        self.label11.text = @"";
        [self.label11 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label11.left;
        _codeTextField.centerY = _label11.centerY;
    }else if (self.label10.text.length) {
        self.label10.text = @"";
        [self.label10 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label10.left;
        _codeTextField.centerY = _label10.centerY;
    }else if (self.label9.text.length) {
        self.label9.text = @"";
        [self.label9 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label9.left;
        _codeTextField.centerY = _label9.centerY;
    }else if (self.label8.text.length) {
        self.label8.text = @"";
        [self.label8 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label8.left;
        _codeTextField.centerY = _label8.centerY;
    }else if (self.label7.text.length) {
        self.label7.text = @"";
        [self.label7 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label7.left;
        _codeTextField.centerY = _label7.centerY;
    }else if (self.label6.text.length) {
        self.label6.text = @"";
        [self.label6 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label6.left;
        _codeTextField.centerY = _label6.centerY;
    }else if (self.label5.text.length) {
        self.label5.text = @"";
        [self.label5 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label5.left;
        _codeTextField.centerY = _label5.centerY;
    }else if (self.label4.text.length) {
        self.label4.text = @"";
        [self.label4 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label4.left;
        _codeTextField.centerY = _label4.centerY;
    }else if (self.label3.text.length) {
        self.label3.text = @"";
        [self.label3 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label3.left;
        _codeTextField.centerY = _label3.centerY;
    }else if (self.label2.text.length) {
        self.label2.text = @"";
        [self.label2 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor disabledColor]];
        self.codeTextField.left = self.label2.left;
        _codeTextField.centerY = _label2.centerY;
    }else if (self.label1.text.length) {
        self.label1.text = @"";
        [self.label1 setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        [self.codeTextField setCornerWithRadius:5. borderWidth:2 borderColor:[UIColor appBaseColor]];
        self.codeTextField.left = self.label1.left;
        _codeTextField.centerY = _label1.centerY;
    }
}

- (void)resetDefaultStatus {
    self.label1.text = self.label2.text = self.label3.text = self.label4.text = self.label5.text = self.label6.text = self.label7.text = self.label8.text = self.label9.text = self.label10.text = self.label11.text = self.label12.text = @"";
    [self.label1 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor appBaseColor]];
    [self.label2 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label3 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label4 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label5 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label6 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label7 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor appBaseColor]];
    [self.label8 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label9 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label10 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label11 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.label12 setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor disabledColor]];
    [self.codeTextField setCornerWithRadius:5. borderWidth:.5 borderColor:[UIColor appBaseColor]];
    self.codeTextField.left = self.label1.left;
    [self codeBecomeFirstResponder];
}

- (void)codeBecomeFirstResponder {
    [self.codeTextField becomeFirstResponder];
}

@end
