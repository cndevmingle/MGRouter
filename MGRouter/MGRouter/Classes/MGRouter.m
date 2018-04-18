//
//  MGRouter.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "MGRouter.h"
#import "MGRouterVCConfig.h"
#import "NSURL+MGRouter.h"

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSString *mySelfScheme;
static NSMutableDictionary<NSString *, MGRouterVCConfig *> *viewControllerInfo;

@implementation MGRouter

+ (void)registerMySelfScheme:(NSString *)scheme {
    mySelfScheme = scheme;
}

+ (void)registerViewControllers:(NSArray<MGRouterVCConfig *> *)registerInfo {
    if (!viewControllerInfo) {
        viewControllerInfo = [NSMutableDictionary dictionary];
    }
    [registerInfo enumerateObjectsUsingBlock:^(MGRouterVCConfig * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [viewControllerInfo setObject:obj forKey:NSStringFromClass(obj.classObj)];
    }];
}

+ (id)targetWithURL:(NSURL *)URL {
    __block id target = nil;
    [NSURL router_parseURL:URL callback:^(NSString * _Nullable scheme, NSString * _Nullable host, NSDictionary * _Nullable params) {
        Class classObj = nil;
        if (host) {
            classObj = NSClassFromString(host);
        }
        NSArray *properties = nil;
        if (classObj) {
            properties = [self getProperties:classObj];
            
            if ([viewControllerInfo.allKeys containsObject:host]) {
                // 已经注册了这个类型的视图控制器
                MGRouterVCConfig *config = [viewControllerInfo objectForKey:host];
                switch (config.vcType) {
                    case MGRouterVCTypeStoryboard:
                        target = [[UIStoryboard storyboardWithName:config.fileName bundle:config.bundle] instantiateViewControllerWithIdentifier:config.identifier];
                        break;
                    case MGRouterVCTypeXib:
                        target = [[classObj alloc] initWithNibName:config.fileName bundle:config.bundle];
                        break;
                    default:
                        target = [[classObj alloc] init];
                        break;
                }
            } else {
                target = [[classObj alloc] init];
            }
        }
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([properties containsObject:key]) {
                NSString *propertyName = [NSString stringWithFormat:@"_%@", key];
                [target setValue:obj forKey:propertyName];
            }
        }];
    }];
    return target;
}

+ (id)targetWithString:(NSString *)string {
    return [self targetWithURL:[NSURL URLWithString:string]];
}

+ (void)openOutSideURL:(NSURL *)URL callback:(nullable void (^)(NSURL * _Nonnull, BOOL))block {
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@(NO)} completionHandler:^(BOOL success) {
                if (block) {
                    block(URL, success);
                }
#if DEBUG
                if (!success) {
                    NSLog(@"Open fail:%@", URL);
                }
#endif
            }];
        } else {
            if ([[UIApplication sharedApplication] openURL:URL]) {
                if (block) {
                    block(URL, YES);
                }
            } else {
                if (block) {
                    block(URL, NO);
                }
#if DEBUG
                NSLog(@"Open fail:%@", URL);
#endif
            }
        }
    }
}

+ (id)openURL:(NSURL *)URL callback:(nullable void (^)(NSURL * _Nonnull, BOOL))block {
    if ([URL.scheme.lowercaseString isEqualToString:mySelfScheme.lowercaseString]) {
        // 内部跳转
        id target = [self targetWithURL:URL];
        if (block) {
            block(URL, target?YES:NO);
        }
        return target;
    } else {
        // 外部跳转
        [self openOutSideURL:URL callback:block];
        return nil;
    }
}

+ (BOOL)outSideOpenMySelfHandle:(NSURL *)URL waitUntilViewLoaded:(BOOL)wait callback:(nullable void (^)(void))block {
    if ([mySelfScheme.lowercaseString isEqualToString:URL.scheme.lowercaseString]) {
        if (block) {
            
            if (wait) {// 需要等待界面加载出来才开始任务
                // 打开内部功能模块，避免处理到支付宝微信等打开的回调
                UIViewController *rootVC = [[[UIApplication sharedApplication].windows firstObject] rootViewController];
                if (rootVC.isViewLoaded) {
                    // 界面已经加载，可以进行处理相关工作
                    block();
                } else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self outSideOpenMySelfHandle:URL waitUntilViewLoaded:wait callback:block];
                    });
                }
            } else {
                block();
            }
        }
        return YES;
    }
    return NO;
}

#pragma mark - 返回当前类的所有属性
+ (NSArray<NSString *> * _Nullable)getProperties:(Class)cls {
    
    // 获取当前类的所有属性
    unsigned int count;// 记录属性个数
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
    
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
    }
    
    return mArray.copy;
}

@end
