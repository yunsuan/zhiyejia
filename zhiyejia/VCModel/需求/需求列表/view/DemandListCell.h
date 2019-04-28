//
//  DemandListCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemandListCell : UITableViewCell

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
