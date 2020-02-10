//
//  NewRoomProjectAgentVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "NewRoomProjectAgentVC.h"

//#import "NewRoomProjectAgentCollCell.h"
#import "NewRoomProjectAgentCollCell.h"
#import "NewRoomProjectAgentMoreView.h"

@interface NewRoomProjectAgentVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSArray *_dataArr;
}
@property (nonatomic, strong) GZQFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *coll;

@end

@implementation NewRoomProjectAgentVC

- (instancetype)initWithDataArr:(NSArray *)dataArr
{
    self = [super init];
    if (self) {
        
        _dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)PraiseRequest:(NSString *)rank_id is_awesome:(NSString *)is_awesome{
    
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":rank_id}];
    if ([is_awesome integerValue] == 1) {
        
        [dic setValue:@"0" forKey:@"is_awesome"];
    }else{
        
        [dic setValue:@"1" forKey:@"is_awesome"];
    }
    [BaseRequest GET:GetAwesomeOperate_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
       
        [self showContent:@"网络错误"];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewRoomProjectAgentCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewRoomProjectAgentCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[NewRoomProjectAgentCollCell alloc] initWithFrame:CGRectMake(0, 0, 100 *SIZE, 130 *SIZE)];
    }
    
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_dataArr[indexPath.item][@"head_img"]]] placeholderImage:[UIImage imageNamed:@"def_head"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            cell.headImg.image = [UIImage imageNamed:@"def_head"];
        }
    }];
    cell.nameL.text = _dataArr[indexPath.item][@"name"];
    cell.newRoomProjectAgentCollCellPhoneBlock = ^{
        
        if ([self->_dataArr[indexPath.item][@"tel"] length]) {
            
            //获取目标号码字符串,转换成URL
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self->_dataArr[indexPath.item][@"tel"]]];
            //调用系统方法拨号
            [[UIApplication sharedApplication] openURL:url];
        }else{
            
            [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
        }
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"agent_id":self->_dataArr[indexPath.item][@"agent_id"]}];
    [BaseRequest GET:GetAgentRankDetail_URL parameters:dic success:^(id  _Nonnull resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
            
            NewRoomProjectAgentMoreView *view = [[NewRoomProjectAgentMoreView alloc] initWithFrame:self.view.bounds];
            view.dataDic = resposeObject[@"data"];
            view.nameL.text = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.item][@"name"]];
            view.serverL.text = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.item][@"visit_num"]];
            view.dealL.text = [NSString stringWithFormat:@"%@",self->_dataArr[indexPath.item][@"deal_num"]];
            view.newRoomProjectAgentMoreViewPraiseBlock = ^{
                
                if ([UserModel defaultModel].agent_id.length) {
                    
                    [self PraiseRequest:self->_dataArr[indexPath.item][@"agent_id"] is_awesome:[NSString stringWithFormat:@"%@",self->_dataArr[indexPath.item][@"is_awesome"]]];
                }else{

                    [self GotoLogin];
                }
            };
            view.newRoomProjectAgentMoreViewPhoneBlock = ^{
                
                if ([self->_dataArr[indexPath.item][@"tel"] length]) {
                    
                    //获取目标号码字符串,转换成URL
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self->_dataArr[indexPath.item][@"tel"]]];
                    //调用系统方法拨号
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    
                    [self alertControllerWithNsstring:@"温馨提示" And:@"暂时未获取到联系电话"];
                }
            };
            [self.view addSubview:view];
        }else{
            
            [self showContent:resposeObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
    
        [self showContent:@"获取信息失败"];
    }];
}


- (void)initUI{
    
    self.titleLabel.text = @"置业顾问";
    
    _layout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:30 *SIZE];
    _layout.itemSize = CGSizeMake(100 *SIZE, 130 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) collectionViewLayout:_layout];
    _coll.backgroundColor = CLWhiteColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[NewRoomProjectAgentCollCell class] forCellWithReuseIdentifier:@"NewRoomProjectAgentCollCell"];
    [self.view addSubview:_coll];
}

@end
