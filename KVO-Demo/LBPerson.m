//
//  LBPerson.m
//  KVO-Demo
//
//  Created by HuangLibo on 2020/7/19.
//  Copyright © 2020 HuangLibo. All rights reserved.
//

#import "LBPerson.h"

@implementation LBPerson

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey");
}

@end
