//
//  MGRouterVCConfig.h
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, MGRouterVCType) {
    MGRouterVCTypeClass,        // vc是普通类
    MGRouterVCTypeXib,          // vc是xib
    MGRouterVCTypeStoryboard    // vc在sb中
};

NS_ASSUME_NONNULL_BEGIN
@interface MGRouterVCConfig : NSObject

/**类*/
@property (nonatomic, strong) Class classObj;
/**类型*/
@property (nonatomic, assign) MGRouterVCType vcType;
/**文件名称*/
@property (nonatomic, copy, nullable) NSString *fileName;
/**标记*/
@property (nonatomic, copy, nullable) NSString *identifier;
/**bundle*/
@property (nonatomic, strong, nullable) NSBundle *bundle;

+ (instancetype)configWithClass:(Class)classObj viewControllerType:(MGRouterVCType)type fileName:(NSString * _Nullable)fileName identifier:(NSString * _Nullable)identifier bundle:(NSBundle * _Nullable)bundle;

@end
NS_ASSUME_NONNULL_END
