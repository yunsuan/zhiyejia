//
//  SecHouseModel.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseModel : BaseModel

@property (nonatomic, strong) NSString *describe;

@property (nonatomic, strong) NSString *hide;

@property (nonatomic, strong) NSString *house_id;

@property (nonatomic, strong) NSMutableArray *house_tags;

@property (nonatomic, strong) NSString *img_url;

@property (nonatomic, strong) NSString *level;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *price_change;

@property (nonatomic, strong) NSMutableArray *project_tags;

@property (nonatomic, strong) NSString *property_type;

@property (nonatomic, strong) NSString *store_name;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *unit_price;
@end

NS_ASSUME_NONNULL_END
