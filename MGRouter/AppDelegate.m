//
//  AppDelegate.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "AppDelegate.h"
#import "MGRouterHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MGRouter registerMySelfScheme:@"MGRouter"];
    [MGRouter registerViewControllers:@[
                                        [MGRouterVCConfig configWithClass:NSClassFromString(@"ViewController") viewControllerType:MGRouterVCTypeStoryboard fileName:@"Main" identifier:@"ViewController" bundle:nil],
                                        [MGRouterVCConfig configWithClass:NSClassFromString(@"XibViewController") viewControllerType:MGRouterVCTypeXib fileName:@"XibViewController" identifier:nil bundle:nil]
                                        ]];
    NSURL *url = launchOptions[UIApplicationLaunchOptionsURLKey];
    if (url) {
        [MGRouter outSideOpenMySelfHandle:url waitUntilViewLoaded:YES callback:^{
            id vc = [MGRouter openURL:url callback:nil];
            if (vc) {
                UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
                [nav presentViewController:vc animated:YES completion:nil];
            }
        }];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"url:%@", url);
    [MGRouter outSideOpenMySelfHandle:url waitUntilViewLoaded:YES callback:^{
        id vc = [MGRouter openURL:url callback:nil];
        if (vc) {
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav presentViewController:vc animated:YES completion:nil];
        }
    }];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"url:%@\nsourceApplication:%@\nannotaion:%@", url, sourceApplication, annotation);
    [MGRouter outSideOpenMySelfHandle:url waitUntilViewLoaded:YES callback:^{
        id vc = [MGRouter openURL:url callback:nil];
        if (vc) {
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav presentViewController:vc animated:YES completion:nil];
        }
    }];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"url:%@\noptions:%@", url, options);
    [MGRouter outSideOpenMySelfHandle:url waitUntilViewLoaded:YES callback:^{
        id vc = [MGRouter openURL:url callback:nil];
        if (vc) {
            UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
            [nav presentViewController:vc animated:YES completion:nil];
        }
    }];
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
