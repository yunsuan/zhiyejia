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

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *city_name;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *district_name;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *info_id;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *project_name;

@property (nonatomic, strong) NSMutableArray *project_tags;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *province_name;

@property (nonatomic, strong) NSString *sale_state;

@end

NS_ASSUME_NONNULL_END
