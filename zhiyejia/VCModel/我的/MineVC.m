//
//  MineVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MineVC.h"

#import "LoginVC.h"

@interface MineVC ()

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController pushViewController:[[LoginVC alloc] init] animated:YES];
}

@end
