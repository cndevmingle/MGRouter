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
            if ([obj isKindOfClass:[NSArray  class]] || [obj isKindOfClass:[NSDictionary class]]) {
                NSError *error = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                if (jsonString) {
                    [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:jsonString]];
                }
            } else {
                [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:obj]];
            }
        }];
        componment.queryItems = queryItems;
    }
    return componment.URL;
}

+ (void)router_parseURL:(NSURL *)URL callback:(nullable void (^)(NSString * _Nullable scheme, NSString * _Nullable, NSDictionary * _Nullable))block {
    if (block) {
        NSString *scheme = URL.scheme;
        NSString *host = URL.host;
        
        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:URL resolvingAgainstBaseURL:NO];
        NSMutableDictionary *queryItemDict = [NSMutableDictionary dictionary];
        NSArray *queryItems = urlComponents.queryItems;
        for (NSURLQueryItem *item in queryItems) {
            [queryItemDict setObject:item.value forKey:item.name];
        }
        block(scheme, host, queryItemDict);
    }
}

@end
