//
//  NSURL+MGRouter.h
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (MGRouter)

/**
 获取一个URL
 
 @param scheme scheme
 @param targetClass 目标类
 @param params 参数
 @return URL
 */
+ (NSURL * _Nullable)router_URLWithScheme:(NSString * _Nullable)scheme target:(Class _Nullable)targetClass params:(NSDictionary * _Nullable)params;

/**
 解析一个URL
 
 @param URL URL
 @param block 回调
 */
+ (void)router_parseURL:(NSURL *)URL callback:(nullable void(^)(NSString * _Nullable scheme, NSString * _Nullable target, NSDictionary * _Nullable params))block;

@end
