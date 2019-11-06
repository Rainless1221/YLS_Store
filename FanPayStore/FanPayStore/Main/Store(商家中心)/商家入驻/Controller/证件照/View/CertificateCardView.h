//
//  CertificateCardView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/17.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCollectionCell.h"
@protocol sampleDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现

-(void)sampleAction:(NSInteger)sampTag;
@end

@interface CertificateCardView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,ZXCollectionCellDelegate>
@property(nonatomic,weak)id<sampleDelegate>delagate;

@property (assign,nonatomic)BOOL BIanji;
/**
 分割线
 */
@property (strong,nonatomic)UIView * line1;
@property (strong,nonatomic)UIView * line2;
@property (strong,nonatomic)UIView * line3;
/**
 图层
 */
@property (strong,nonatomic)UIView * CardView1;
@property (strong,nonatomic)UIView * CardView2;
@property (strong,nonatomic)UIView * CardView3;


@property (nonatomic,strong)UICollectionView *collectionView1;
@property (nonatomic,strong)UICollectionView *collectionView2;
@property (nonatomic,strong)UICollectionView *collectionView3;
/** 展示的图片数组*/

@property(nonatomic,strong)NSMutableArray * UrlimageArr1;
@property(nonatomic,strong)NSMutableArray * UrlimageArr2;
@property(nonatomic,strong)NSMutableArray * UrlimageArr3;

@property (nonatomic, copy) void(^didSelectBlock)(NSInteger collviewInt);

@end
