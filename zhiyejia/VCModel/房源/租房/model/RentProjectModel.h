//
//  RentProjectModel.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentProjectModel : BaseModel

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *average_price;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSString *on_rent;

@property (nonatomic, strong) NSString *project_code;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *project_name;

@property (nonatomic, strong) NSString *subs_num;

@property (nonatomic, strong) NSString *total_float_url;

@property (nonatomic, strong) NSString *total_float_url_phone;

@property (nonatomic, strong) NSString *total_float_url_panorama;

@end

NS_ASSUME_NONNULL_END
