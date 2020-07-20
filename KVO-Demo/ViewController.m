//
//  ViewController.m
//  KVO-Demo
//
//  Created by HuangLibo on 2020/7/19.
//  Copyright © 2020 HuangLibo. All rights reserved.
//

#import "ViewController.h"
#import "LBPerson.h"
#import <objc/runtime.h>

@interface ViewController ()

@property (nonatomic, strong) LBPerson *person1;
@property (nonatomic, strong) LBPerson *person2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person1 = [[LBPerson alloc] init];
    self.person1.age = 1;
    
    self.person2 = [[LBPerson alloc] init];
    self.person2.age = 2;
    
    NSLog(@"object_getClass(self.person1) %@", NSStringFromClass(object_getClass(self.person1)));
    NSLog(@"object_getClass(self.person2) %@", NSStringFromClass(object_getClass(self.person2)));
    
    NSLog(@"-- ↓ self.person1 add KVO ↓ --");
    
    // 只给 self.person1 添加 KVO
    [self.person1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    // [self.person1 class] 获取到的还是 LBPerson, 可能是 `class` 方法里做了特殊处理, 使获取到的类还是之前的类对象
    NSLog(@"[self.person1 class] %@", NSStringFromClass([self.person1 class]));
    NSLog(@"[self.person2 class] %@", NSStringFromClass([self.person2 class]));
    // object_getClass(self.person1) 能获取到当前 self.person1 实例的 isa 指向的是系统生成的中间类 NSKVONotifying_LBPerson 类
    // 这里使用了 isa-swizzling 技术, 使 person1 实例的 isa 指向 NSKVONotifying_LBPerson 类对象(它是 LBPerson 的子类)
    NSLog(@"object_getClass(self.person1) %@", NSStringFromClass(object_getClass(self.person1)));
    NSLog(@"object_getClass(self.person2) %@", NSStringFromClass(object_getClass(self.person2)));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //
    self.person1.age++;
    self.person2.age++;
    
//    // 在不改变观测值的情况下, 手动触发 KVO
//    [self.person1 willChangeValueForKey:@"age"];
//    [self.person1 didChangeValueForKey:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"KVO: %@ 的 %@ 属性发生了变化 %@", object, keyPath, change);
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

@end
