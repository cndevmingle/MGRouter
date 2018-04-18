//
//  UINavigationController+MGRouter.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "UINavigationController+MGRouter.h"
#import "MGRouter.h"

@implementation UINavigationController (MGRouter)

- (void)router_pushURL:(NSURL *)URL animated:(BOOL)animated {
    UIViewController *vc = [MGRouter targetWithURL:URL];
    if (vc) {
        [self pushViewController:vc animated:animated];
    } else {
#if DEBUG
        NSLog(@"%s\nFail:%@", __FUNCTION__, URL);
#endif
    }
}

@end
