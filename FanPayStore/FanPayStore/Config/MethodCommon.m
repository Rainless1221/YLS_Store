//
//  MethodCommon.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "MethodCommon.h"

@implementation MethodCommon
+ (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW text:(NSString *)text
{
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    
    if (ISIPHONE5) {
        
        return  textSize;
    }
    
    return textSize;
}

+ (NSString *)judgeStringIsNull:(NSString *)text;
{
    if (text == nil || text == NULL) {
        text = @"";
    }
    if ([text isKindOfClass:[NSNull class]]) {
        text = @"";
    }
    if ([[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        text = @"";
    }
    if ([text isEqualToString:@"(null)"]) {
        text = @"";
    }
    if ([text isEqualToString:@"<null>"]) {
        text = @"";
    }
    if (text.length == 0) {
        text = @"";
    }
    return text;
}
@end
