//
//  UIViewController+MGRouter.h
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MGRouter)

- (void)router_presentURL:(NSURL *)URL animated:(BOOL)flag completion:(void (^)(void))completion;

@end
