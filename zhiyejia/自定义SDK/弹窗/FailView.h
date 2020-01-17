//
//  FailView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FailViewBlock)(NSString *str);

@interface FailView : UIView

@property (nonatomic, copy) FailViewBlock failViewBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UITextView *reasonTV;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIButton *backBtn;

@end
