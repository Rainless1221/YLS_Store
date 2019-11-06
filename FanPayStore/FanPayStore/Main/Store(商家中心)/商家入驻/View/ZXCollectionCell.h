//
//  ZXCollectionCell.h
//
//

#import <UIKit/UIKit.h>

@class ZXCollectionCell;

@protocol ZXCollectionCellDelegate <NSObject>

-(void)moveImageBtnClick:(ZXCollectionCell *)aCell;

@end

@interface ZXCollectionCell : UICollectionViewCell
@property(nonatomic ,strong)UIImageView *imgView;
@property(nonatomic ,strong)UILabel *text;
@property(nonatomic ,strong)UIButton *btn;
@property(nonatomic,strong)UIButton * close;
@property(nonatomic,assign)id<ZXCollectionCellDelegate>delegate;

@property (nonatomic, copy) void(^didSelectBlock)(NSInteger collviewInt);

@end
