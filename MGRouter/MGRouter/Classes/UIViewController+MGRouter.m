//
//  UIViewController+MGRouter.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "UIViewController+MGRouter.h"
#import "MGRouter.h"

@implementation UIViewController (MGRouter)

- (void)router_presentURL:(NSURL *)URL animated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController *vc = [MGRouter targetWithURL:URL];
    if (vc) {
        [self presentViewController:vc animated:flag completion:completion];
    } else {
#if DEBUG
        NSLog(@"%s\nFail:%@", __FUNCTION__, URL);
#endif
    }
}

@end
