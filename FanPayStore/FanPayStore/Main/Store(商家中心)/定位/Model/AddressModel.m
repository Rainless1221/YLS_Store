//
//  AddressModel.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#define KUserDataFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"AddressData.plist"]

#import "AddressModel.h"

@implementation AddressModel
- (NSString *)detailAddress{
    if (_detailAddress) {
        return _detailAddress;
    }
    
    NSString *adresss = @"";
    if(self.province){
        adresss = [adresss stringByAppendingString:self.province];
    }
    if (self.city) {
        adresss = [adresss stringByAppendingString:self.city];
    }
    if (self.district) {
        adresss = [adresss stringByAppendingString:self.district];
    }
    if (self.street) {
        adresss = [adresss stringByAppendingString:self.street];
    }
    if (self.streetNumber) {
        adresss = [adresss stringByAppendingString:self.streetNumber];
    }
    //    if (self.locationDescribe){
    //        adresss = [adresss stringByAppendingString:self.locationDescribe];
    //    }
    return adresss;
}

#pragma mark - 保存
-(void)saveUserData{
    //归档路径
    [NSKeyedArchiver archiveRootObject:self toFile:KUserDataFilePath];
    
}
#pragma mark - 清理
+(instancetype)clearUserData{
    //runtime设置所有值为空
    AddressModel *userInfo =[[AddressModel alloc]init];
    [NSKeyedArchiver archiveRootObject:userInfo toFile:KUserDataFilePath];
    return userInfo;
    
}
#pragma mark - 解档
+(instancetype)getUseData{
    
    @try {
        AddressModel *userInfo =[NSKeyedUnarchiver unarchiveObjectWithFile:KUserDataFilePath];
        return userInfo;
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
    
}

//解档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        //获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([AddressModel class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:strName];
            //利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}

//归档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([AddressModel class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}
@end
