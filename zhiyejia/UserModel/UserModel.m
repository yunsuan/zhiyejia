//
//  UserModel.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (UserModel *)defaultModel{
    static UserModel *model;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        model = [UserModelArchiver unarchive];
        if (!model) {
            
            model = [[UserModel alloc]init];
        }
    });
    return model;
}

#pragma mark - NSCoding
//归档
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            
            id value = [aDecoder decodeObjectForKey:key];
            
            if (value) {
                
                [self setValue:value forKey:key];
            }
            
        }
        // 获得c的父类
        c = [c superclass];
        free(ivars);}
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            id value = [self valueForKey:key];
            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
        // 释放内存
        free(ivars);
    }
}

@end
