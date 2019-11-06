//
//  ColorConfig.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#ifndef ColorConfig_h
#define ColorConfig_h

//颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define RGBCOLOR(r,g,b) RGBACOLOR(r,g,b,1)

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue,1)

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/*
 项目用色 ：#47d2ff #4b95ff
 主题色：#3d8aff     辅助色：#f7ae2a
 字体色：#222222（黑色） #999999（灰色）#ffffff（白色）
 背景主色：#F6F6F6

 标题字体大小：20  #222222（黑色）
 按钮字体大小：18     #ffffff（白色） 按钮圆角：10pt    按钮背景色：  #3D89FF - #45A6FF -#43C1FF
 
 */

/*
 *  项目主色调
 */
#define MainColor UIColorFromRGB(0x3d8aff)
#define MainTextColor UIColorFromRGB(0x222222)
#define MainbackgroundColor UIColorFromRGB(0xF6F6F6)
#define BtnTextcolor UIColorFromRGB(0xffffff)
#define Btnbackgroundcolor UIColorFromRGB(0x3D89FF)

#define ContentTextColor UIColorFromRGB(0x838383)
#define DetailTextColor UIColorFromRGB(0x9c9c9c)
#define LineColor UIColorFromRGB(0xececec)
#define BgViewColor UIColorFromRGB(0xf5f5f5)
#define BorderColor UIColorFromRGB(0xdedede)

#define COLOR_THEME kUIColorFromRGB(0x37acff)
#define COLOR_LINE kUIColorFromRGB(0xececec)
#define COLOR_ORANGE kUIColorFromRGB(0xF48D00)
#define COLOR_GREEN kUIColorFromRGB(0x14B344)
#define COLOR_BG UIColorFromRGB(0xF5F5F5)
#define COLOR_SHADOW UIColorFromRGBA(0x000000, 0.15)
#define COLOR_RANDOM UIColorFromRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define COLOR_LIGHTGRAYTXT kUIColorFromRGB(0x333333)
#define COLOR_MIDDLEGRAYTXT kUIColorFromRGB(0x666666)
#define COLOR_DARKTXT kUIColorFromRGB(0x999999)
#endif /* ColorConfig_h */
