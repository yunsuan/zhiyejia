//
//  PlaceImgDropDownBtn.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/14.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlaceImgDropDownBtn : UIButton{

@public
    
    NSString *str;
}

@property (nonatomic , strong) UIImageView *placeImg;

@property (nonatomic , strong) UILabel *content;

@property (nonatomic , strong) UIImageView *dropimg;

@end

NS_ASSUME_NONNULL_END
