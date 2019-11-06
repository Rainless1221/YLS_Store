//
//  MapViewController.h
//  app
//
//  Created by mocoo_ios on 2019/4/25.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MapControllerDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)Mapaddres:(NSString *)ddres andlot:(NSString*)lon andlat:(NSString*)lat;
@end

@interface MapViewController : BaseViewController
@property(nonatomic,weak)id<MapControllerDelegate>delagate;

@end
