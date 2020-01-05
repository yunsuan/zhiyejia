//
//  RightBtnColorHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RightBtnColorHeaderMoreBlock)(void);

@interface RightBtnColorHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) RightBtnColorHeaderMoreBlock rightBtnColorHeaderMoreBlock;

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
