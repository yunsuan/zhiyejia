//
//  DropDownBtn.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropDownBtn : UIButton{
@public
    NSString *str;
}

@property (nonatomic , strong) UILabel *content;
@property (nonatomic , strong) UIImageView *dropimg;

@end

NS_ASSUME_NONNULL_END
