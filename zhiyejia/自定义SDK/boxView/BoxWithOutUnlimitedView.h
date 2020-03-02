//
//  BoxWithOutUnlimitedView.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BoxWithOutUnlimitedViewConfirmBtnBlock)(NSString *ID,NSString *str);

typedef void(^BoxWithOutUnlimitedViewCancelBtnBlock)(void);

@interface BoxWithOutUnlimitedView : UIView

@property (nonatomic, copy) BoxWithOutUnlimitedViewConfirmBtnBlock boxWithOutUnlimitedViewConfirmBtnBlock;

@property (nonatomic, copy) BoxWithOutUnlimitedViewCancelBtnBlock boxWithOutUnlimitedViewCancelBtnBlock;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *selectArr;

@property (nonatomic, strong) UITableView *mainTable;

@end

NS_ASSUME_NONNULL_END
