//
//  BaseViewController.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialBaseViewInterface];
}

#pragma mark - init
- (void)initialBaseViewInterface {
    
    self.view.backgroundColor = CLBackColor;
    [self.view addSubview:self.navBackgroundView];
    
    [self.navBackgroundView addSubview:self.titleLabel];
//    [self.navBackgroundView addSubview:self.leftButton];
}

@end
