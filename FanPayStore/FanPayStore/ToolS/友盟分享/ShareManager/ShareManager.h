//
//  ShareManager.h
//  HaveAFlaw
//
//  Created by apple on 2018/12/17.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareManager : NSObject
//单例
SINGLETON_FOR_HEADER(ShareManager)
/*图片*/
-(void)showShare:(UMSocialPlatformType)platformType andtThumbImage:(id)ImageURl;
/*链接*/
-(void)showShare:(UMSocialPlatformType)platformType andwebpageUrl:(NSString *)WebURl;
/*文本*/

/**/
-(void)showShare:(UMSocialPlatformType)platformType andObjectWithTitle:(NSString *)WithTitle descr:(NSString *)titie;

@end

NS_ASSUME_NONNULL_END
