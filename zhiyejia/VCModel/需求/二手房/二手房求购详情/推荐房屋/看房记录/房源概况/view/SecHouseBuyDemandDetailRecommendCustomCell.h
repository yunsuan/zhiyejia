//
//  SecHouseBuyDemandDetailRecommendCustomCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseBuyDemandDetailRecommendCustomCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *scoreL;

@property (nonatomic, strong) UILabel *scoreL1;

@property (nonatomic, strong) UIProgressView *scoreP;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UIButton *praiseBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
