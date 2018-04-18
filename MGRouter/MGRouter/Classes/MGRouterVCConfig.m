//
//  MGRouterVCConfig.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "MGRouterVCConfig.h"

@implementation MGRouterVCConfig

+ (instancetype)configWithClass:(Class)classObj viewControllerType:(MGRouterVCType)type fileName:(NSString * _Nullable)fileName identifier:(NSString * _Nullable)identifier bundle:(NSBundle * _Nullable)bundle {
    MGRouterVCConfig *config = [[MGRouterVCConfig alloc] init];
    config.classObj = classObj;
    config.vcType = type;
    config.fileName = fileName;
    config.identifier = identifier;
    config.bundle = bundle;
    return config;
}

@end
