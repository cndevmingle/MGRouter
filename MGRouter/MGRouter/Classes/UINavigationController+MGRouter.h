//
//  UINavigationController+MGRouter.h
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (MGRouter)

- (void)router_pushURL:(NSURL *)URL animated:(BOOL)animated;

@end
