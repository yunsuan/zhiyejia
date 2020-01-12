//
//  NewRoomModel.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomModel : BaseModel

@property (nonatomic, strong) NSString *absolute_address;

@property (nonatomic, strong) NSString *average_price;

@property (nonatomic, strong) NSString *developer_name;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *city_name;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *district_name;

@property (nonatomic, strong) NSString *general_layout_plan_url;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *project_name;

@property (nonatomic, strong) NSMutableArray *project_tags;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *province_name;

@property (nonatomic, strong) NSString *sale_state;

@property (nonatomic, strong) NSMutableArray *property_type;

@property (nonatomic, strong) NSString *total_float_url;

@property (nonatomic, strong) NSString *total_float_url_phone;

@property (nonatomic, strong) NSString *yunsuan_id;

@property (nonatomic, strong) NSString *yunsuan_url;

@property (nonatomic , strong) NSString *total_float_url_panorama;

@end

NS_ASSUME_NONNULL_END
