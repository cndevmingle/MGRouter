//
//  MGRouter.h
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>


@class MGRouterVCConfig;

NS_ASSUME_NONNULL_BEGIN
@interface MGRouter : NSObject

/**
 注册自己APP的Scheme
 
 @param scheme scheme
 */
+ (void)registerMySelfScheme:(NSString *)scheme;

/**
 注意特别的视图控制器
 */
+ (void)registerViewControllers:(NSArray<MGRouterVCConfig *> *)registerInfo;

/**
 从字符串获取一个目标并赋值

 @param string 字符串
 @return 目标
 */
+ (nullable id)targetWithString:(NSString *)string;

/**
 从URL获取一个目标并赋值
 
 @param URL URL
 @return 目标
 */
+ (nullable id)targetWithURL:(NSURL *)URL;

/**
 打开一个外部地址

 @param URL 外部URL
 @param block 回调
 */
+ (void)openOutSideURL:(NSURL *)URL callback:(nullable void (^)(NSURL *URL, BOOL success))block;

/**
 打开一个URL，如果是外部的会自动打开外部地址，如果是内部的则会返回目标并赋值

 @param URL URL
 @param block 回调
 @return 目标（外部为nil）
 */
+ (nullable id)openURL:(NSURL *)URL callback:(nullable void (^)(NSURL *URL, BOOL success))block;

/**
 外部打开本APP，请在delegate中回调

 @param URL 外部传进来的URL
 @return 返回是否是自己处理的
 */
+ (BOOL)outSideOpenMySelfHandle:(NSURL *)URL waitUntilViewLoaded:(BOOL)wait callback:(nullable void (^)(void))block;

@end
NS_ASSUME_NONNULL_END
