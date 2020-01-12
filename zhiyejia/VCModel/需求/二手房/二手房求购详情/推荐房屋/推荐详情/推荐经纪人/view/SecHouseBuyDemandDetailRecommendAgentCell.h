//
//  SecHouseBuyDemandDetailRecommendAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/7.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseBuyDemandDetailRecommendAgentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *yearL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *comprehensiveGradeL;

@property (nonatomic, strong) UILabel *professionalGradeL;

@property (nonatomic, strong) UILabel *serviceGradeL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *regionL;

@property (nonatomic, strong) UICollectionViewFlowLayout *tagFlowLayout;

@property (nonatomic, strong) UICollectionView *tagColl;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
