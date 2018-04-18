//
//  NSURL+MGRouter.m
//  MGRouter
//
//  Created by Mingle on 2018/4/18.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "NSURL+MGRouter.h"

@implementation NSURL (MGRouter)

+ (NSURL *)router_URLWithScheme:(NSString *)scheme target:(Class  _Nullable __unsafe_unretained)targetClass params:(NSDictionary * _Nullable)params {
    NSURLComponents *componment = [[NSURLComponents alloc] init];
    componment.scheme = scheme;
    componment.host = targetClass ? NSStringFromClass(targetClass) : nil;
    
    if (params.count) {
        NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray arrayWithCapacity:params.count];
        [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
        }];
        componment.queryItems = queryItems;
    }
    return componment.URL;
}

+ (void)router_parseURL:(NSURL *)URL callback:(nullable void (^)(NSString * _Nullable scheme, NSString * _Nullable, NSDictionary * _Nullable))block {
    if (block) {
        NSString *scheme = URL.scheme;
        NSString *host = URL.host;
        NSString *paramStr = URL.query;
        NSArray *paramArr = [[paramStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] componentsSeparatedByString:@"&"];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        for (NSString *temp in paramArr) {
            NSArray *keyValue = [temp componentsSeparatedByString:@"="];
            if (keyValue.count == 2) {
                NSString *key = keyValue[0];
                NSString *value = keyValue[1];
                [params setObject:value forKey:key];
            }
        }
        block(scheme, host, params);
    }
}

@end
