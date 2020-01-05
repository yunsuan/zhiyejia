//
//  TitleContentRightBtnCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TitleContentRightBtnCellMoreBlock)(void);

@interface TitleContentRightBtnCell : UITableViewCell

@property (nonatomic, copy) TitleContentRightBtnCellMoreBlock titleContentRightBtnCellMoreBlock;

@property (nonatomic , strong) UILabel *titleL;

@property (nonatomic , strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
