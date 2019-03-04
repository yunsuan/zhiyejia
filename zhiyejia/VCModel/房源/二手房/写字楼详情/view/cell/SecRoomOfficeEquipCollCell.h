//
//  SecRoomOfficeEquipCollCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomOfficeEquipCollCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *grayImg;

@property (nonatomic, strong) UIImageView *typeImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

- (UIImage*)grayscaleImageForImage:(UIImage*)image;

@end

NS_ASSUME_NONNULL_END
