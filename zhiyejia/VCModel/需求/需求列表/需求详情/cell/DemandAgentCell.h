//
//  DemandAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemandAgentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *comprehensiveGradeL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIImageView *phoneImg;

@property (nonatomic, strong) UIButton *comfirmBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
