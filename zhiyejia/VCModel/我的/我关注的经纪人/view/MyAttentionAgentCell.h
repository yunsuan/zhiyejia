//
//  MyAttentionAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyAttentionAgentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *comprehensiveGradeL;

@property (nonatomic, strong) UILabel *professionalGradeL;

@property (nonatomic, strong) UILabel *serviceGradeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UICollectionViewFlowLayout *tagFlowLayout;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UILabel *serviceDistrictL;

@property (nonatomic, strong) UIImageView *phoneImg;

@property (nonatomic, strong) UILabel *distanceL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
