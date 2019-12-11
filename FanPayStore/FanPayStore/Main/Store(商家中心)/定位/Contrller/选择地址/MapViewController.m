//
//  MapViewController.m
//  app
//
//  Created by mocoo_ios on 2019/4/25.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SeekTableViewCell.h"
#import <Masonry.h>
#import "FL_Button.h"
#import "CityViewController.h"
#import "GYZChooseCityController.h"

@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,cityDelegate,GYZChooseCityDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;

// 地图
@property (nonatomic, strong) MAMapView            *mapView;
// 搜索引擎
@property (nonatomic, strong) AMapSearchAPI        *search;
// 自定义大头针
@property (nonatomic, strong) UIImageView          *centerAnnotationView;
// 定位
@property (nonatomic, strong) UIButton             *locationBtn;
//城市
@property (nonatomic, strong) NSString             *locationcity;

// 是否正在定位
@property (nonatomic, assign) BOOL                  isLocated;
// 防止重复点击
@property (nonatomic, assign) BOOL                  isMapViewRegionChangedFromTableView;


/** 搜索视图 */
@property (strong,nonatomic)UIView * SeekView;
//搜索框
@property (strong,nonatomic)UITextField * SeekField;

/** 列表视图 */
@property (strong,nonatomic)UIView * TableBaseView;
// 坐标数据源
@property (nonatomic, strong) NSMutableArray *searchPoiArray;
/** 地址列表 */
@property (strong, nonatomic)UITableView *DTableView;
/** 城市按钮 */
@property (strong,nonatomic)FL_Button *thirdBtn;
/** 搜索列表 */
@property (strong,nonatomic)UITableView * SeekTableView;
@property (nonatomic ,strong) NSMutableArray *seekdataArry;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"定位";
    [self initSearch];
    [self initMapView];

    
    self.mapView.zoomLevel = 17;              ///缩放级别（默认3-19，有室内地图时为3-20）
    self.mapView.showsUserLocation = YES;    ///是否显示用户位置
    self.mapView.showsCompass =NO;          /// 是否显示指南针
    self.mapView.showsScale = NO;           ///是否显示比例尺
    
    [self initCenterView];
    [self initLocationButton];

    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error) {
            return ;
        }
        [self.thirdBtn setTitle:[NSString stringWithFormat:@"%@",regeocode.city] forState:UIControlStateNormal];
        self.locationcity = [NSString stringWithFormat:@"%@",regeocode.city];
        [self actionSearchAroundAt:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)];

    }];
    
}
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
}
#pragma mark - 主视图
- (void)initMapView
{

    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, autoScaleH(350))];
    self.mapView.delegate = self;
    // 用户定位模式
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.height.mas_offset(autoScaleH(350));
        make.width.mas_offset(ScreenW);
    }];
    /*是否开始定位*/
    self.isLocated = YES;
    
#pragma mark - 换定位图标
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
    r.image = [UIImage imageNamed:@"ico_location_current"]; ///定位图标, 与蓝色原点互斥
    [self.mapView updateUserLocationRepresentation:r];
 
    /**
     取消
     */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button addTarget:self action:@selector(QuXiaoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.right.mas_offset(-15);
        make.size.mas_offset(CGSizeMake(45, 44));
    }];
    /**
     * 搜索
     */
    self.SeekView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, self.view.bounds.size.width-30, 44)];
    self.SeekView.backgroundColor = [UIColor whiteColor];
    self.SeekView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
    self.SeekView.layer.shadowOffset = CGSizeMake(0,2);
    self.SeekView.layer.shadowOpacity = 1;
    self.SeekView.layer.shadowRadius = 5;
    self.SeekView.layer.cornerRadius = 22;
    [self.view addSubview:self.SeekView];
    [self.SeekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.right.mas_offset(-15);
        make.left.mas_offset(15);
        make.height.mas_offset(44);
    }];
    /** 城市按钮 */
    self.thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
    self.thirdBtn.frame = CGRectMake(15, 5, 60, 35);
    [self.thirdBtn setImage:[UIImage imageNamed:@"ico_arrow_down_blue"] forState:UIControlStateNormal];
    [self.thirdBtn setTitle:[NSString stringWithFormat:@"厦门市"] forState:UIControlStateNormal];
    [self.thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //样式
    self.thirdBtn.status = FLAlignmentStatusRight;
    self.thirdBtn.fl_padding = 5;
    self.thirdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.thirdBtn addTarget:self action:@selector(MerchantButton) forControlEvents:UIControlEventTouchUpInside];
    [self.SeekView addSubview:self.thirdBtn];
    
    /** 分割线 */
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 1, 28)];
    line.backgroundColor = UIColorFromRGB(0xf2f2f2f2);
    [self.SeekView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdBtn.mas_right).offset(5);
        make.centerY.mas_offset(0);
        make.size.mas_offset(CGSizeMake(1, self.SeekView.bounds.size.height/2));
    }];
    /** 搜索文本框 */
    self.SeekField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 170, 44)];
    self.SeekField.placeholder = @"请输入您的店铺地址";
    self.SeekField.delegate = self;
    self.SeekField.font = [UIFont systemFontOfSize:15];
    [self.SeekView addSubview:self.SeekField];
    self.SeekField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.SeekField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_offset(0);
        make.right.mas_offset(-5);
        make.left.equalTo(self.thirdBtn.mas_right).offset(15);
    }];
    
    self.TableBaseView = [[UIView alloc]init];
    self.TableBaseView.layer.cornerRadius = 12;
    // 设置阴影偏移量
    self.TableBaseView.layer.shadowOffset = CGSizeMake(5,0);
    // 设置阴影透明度
    self.TableBaseView.layer.shadowOpacity = 0.5;
    // 设置阴影半径
    self.TableBaseView.layer.shadowRadius = 5;
    self.TableBaseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TableBaseView];
    [self.TableBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapView.mas_bottom).offset(-2);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
        //        make.height.mas_offset(autoScaleH(240));
    }];
    /*icon -- ico_map_fold*/
    UIImageView *ico_map_fold = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 8)];
    ico_map_fold.image = [UIImage imageNamed:@"ico_map_fold"];
    [self.TableBaseView addSubview:ico_map_fold];
    [ico_map_fold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(6);
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(20, 8));
    }];
    /** 列表 */
    [self.TableBaseView addSubview:self.DTableView];
    [self.DTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(25);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-1);
    }];
    
    
    
    [self.view addSubview:self.SeekTableView];
    self.SeekTableView.hidden = YES;
    [self.SeekTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.equalTo(self.SeekView.mas_bottom).offset(15);
    }];
    
    
    
    
    
    
}
#pragma mark - 选择城市
-(void)MerchantButton{
//    CityViewController *VC = [CityViewController new];
//    VC.delagate = self;
//    [self.navigationController pushViewController:VC animated:NO];
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    [self.navigationController pushViewController:cityPickerVC animated:NO];
    
}
-(void)MapCitys:(NSString *)city{
    [self.thirdBtn setTitle:[NSString stringWithFormat:@"%@",city] forState:UIControlStateNormal];
    self.locationcity = [NSString stringWithFormat:@"%@",city];
    if (self.SeekField.text.length>0) {
        [self POIKeywordsSearch:self.SeekField.text];

    }

}
#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [self.thirdBtn setTitle:city.cityName forState:UIControlStateNormal];
    self.locationcity = [NSString stringWithFormat:@"%@",city.cityName];
//    [self actionSearchAroundAt:CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)];
    [self POIKeywordsSearch:city.cityName];
    [self.navigationController popViewControllerAnimated:YES];

}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - 取消
-(void)QuXiaoAction{
    self.mapView.hidden = NO;
    self.locationBtn.hidden = NO;
    self.SeekTableView.hidden = YES;
    [self.SeekView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
    }];
    [self.view endEditing:YES];
}
// 自定义用户大头针
- (void)initCenterView
{
    // 自己的坐标
    self.centerAnnotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_location"]];
    self.centerAnnotationView.center = CGPointMake(self.mapView.center.x, self.mapView.center.y - CGRectGetHeight(self.centerAnnotationView.bounds) / 2);
    
    [self.mapView addSubview:self.centerAnnotationView];
}

// 定位自己
- (void)initLocationButton
{

    self.locationBtn = [[UIButton alloc] initWithFrame:CGRectMake( 40, CGRectGetHeight(self.mapView.bounds) - 50, 35, 35)];
    self.locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.locationBtn.backgroundColor = [UIColor clearColor];
    
    self.locationBtn.layer.cornerRadius = 3;
    [self.locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBtn setImage:[UIImage imageNamed:@"ico_location_focus"] forState:UIControlStateNormal];
    [self.mapView addSubview:self.locationBtn];
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.mas_offset(-25);
        make.size.mas_offset(CGSizeMake(35, 35));
    }];
}


#pragma mark - 定位
- (void)actionLocation
{
    if (self.mapView.userTrackingMode == MAUserTrackingModeFollow)
    {
        [self.mapView setUserTrackingMode:MAUserTrackingModeNone animated:YES];
    }
    else
    {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            // 因为下面这句的动画有bug，所以要延迟0.5s执行，动画由上一句产生
            [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        });
    }
}

#pragma mark - userLocation
/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(!updatingLocation)
        return ;

    if (userLocation.location.horizontalAccuracy < 0)
    {
        return ;
    }

    // only the first locate used.
    if (!self.isLocated)
    {
        self.isLocated = YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];

        [self actionSearchAroundAt:userLocation.location.coordinate];
    }
}
#pragma mark - MapViewDelegate
/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    // 防止重复点击
    if (!self.isMapViewRegionChangedFromTableView && self.mapView.userTrackingMode == MAUserTrackingModeNone)
    {
        [self actionSearchAroundAt:self.mapView.centerCoordinate];
    }
    self.isMapViewRegionChangedFromTableView = NO;
}


#pragma mark - Handle Action
- (void)actionSearchAroundAt:(CLLocationCoordinate2D)coordinate
{
    /** 开始搜索和反编译 */
    [self searchReGeocodeWithCoordinate:coordinate];
    [self searchPoiWithCenterCoordinate:coordinate];
    
    /* 动画效果 */
    [self centerAnnotationAnimimate];
}
#pragma mark - 开始搜索
/**
 * @brief 根据中心点坐标来搜周边的POI.
 */
- (void)searchPoiWithCenterCoordinate:(CLLocationCoordinate2D )coord
{
    AMapPOIAroundSearchRequest*request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:coord.latitude  longitude:coord.longitude];
    
//    request.radius   = 500;             /// 搜索范围
//    request.types = self.currentType;   ///搜索类型
    request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    request.sortrule = 0;               ///排序规则
    request.requireExtension = YES;
    request.offset = 50;
    [self.search AMapPOIAroundSearch:request];
    
}

/**
 * @brief 逆地址编码查询接口
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}
/* 移动窗口弹一下的动画 */
- (void)centerAnnotationAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y -= 45;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.centerAnnotationView.center;
                         center.y += 45;
                         [self.centerAnnotationView setCenter:center];}
                     completion:nil];
}

/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
//    [XYQProgressHUD hideHUD];
    
    if(self.SeekField.text.length>0){
        [self.mapView removeAnnotations:self.seekdataArry];
        [self.seekdataArry removeAllObjects];
        
        if (response.pois.count == 0)
        {
            [self.SeekTableView reloadData];
            
            return;
        }
//        for(AMapPOI *poi in response.pois){
//            NSLog(@"%@.%@-%@-%@",poi.name,poi.district,poi.businessArea,poi.address);
//        }
        //解析response获取POI信息，具体解析见 Demo
        //    NSLog(@" >>> %@",response.pois);
        AMapPOI *arry = response.pois[0];
        
        NSLog(@" >>> %@",arry.province);
        self.seekdataArry = [NSMutableArray arrayWithArray:response.pois];
        
        [self.SeekTableView reloadData];
    }else{
        [self.mapView removeAnnotations:self.searchPoiArray];
        [self.searchPoiArray removeAllObjects];
        
        if (response.pois.count == 0)
        {
            [self.DTableView reloadData];
            
            return;
        }
//        for(AMapPOI *poi in response.pois){
//            NSLog(@"%@.%@-%@-%@",poi.name,poi.district,poi.businessArea,poi.address);
//        }
        //解析response获取POI信息，具体解析见 Demo
        //    NSLog(@" >>> %@",response.pois);
//        AMapPOI *arry = response.pois[0];
//
//        NSLog(@" >>> %@",arry.province);
        self.searchPoiArray = [NSMutableArray arrayWithArray:response.pois];
        [self.DTableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
        [self.DTableView reloadData];
    }
    


    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {

    }];

}
#pragma mark - 错误回调
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@" ！！错误回调：%@",error)
}
/**
 * @brief 地理编码查询回调函数
 * @param request  发起的请求，具体字段参考 AMapGeocodeSearchRequest 。
 * @param response 响应结果，具体字段参考 AMapGeocodeSearchResponse 。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    
    
    
}
#pragma mark - 定位相关代理
/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.SeekTableView) {
        return self.seekdataArry.count;
    }
    return self.searchPoiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SeekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SeekTableViewCell"];
    
    if (tableView == self.SeekTableView) {
        cell.Dict = self.seekdataArry[indexPath.row];
        cell.icon.hidden = YES;
    }else{
        cell.Dict = self.searchPoiArray[indexPath.row];
        cell.icon.hidden = NO;

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AMapPOI* Dict = [AMapPOI new];
    if (tableView == self.SeekTableView) {
        Dict = self.seekdataArry[indexPath.row];
        
    }else{
        Dict = self.searchPoiArray[indexPath.row];
        
    }
    
    NSString *adder = [NSString new];
    NSString *province = [NSString stringWithFormat:@"%@",Dict.province];
    NSString *city = [NSString stringWithFormat:@"%@",Dict.city];
    NSString *district = [NSString stringWithFormat:@"%@",Dict.district];
    NSString *address = [NSString stringWithFormat:@"%@",Dict.address];
    
    if ([address isEqualToString:district]) {
        if ([district isEqualToString:city]) {
            adder = [NSString stringWithFormat:@"%@ %@ %@",province,city,Dict.name];
        }else{
            adder = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,district,Dict.name];
        }
    }else if ([district isEqualToString:city]){
        adder = [NSString stringWithFormat:@"%@ %@ %@",province,city,Dict.name];
    }else{
        adder = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,district,address];
    }
    
    AMapGeoPoint * loca = Dict.location;
    NSString *latitude = [NSString stringWithFormat:@"%lf",loca.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%lf",loca.longitude];
    NSLog(@" 选择的地址 %@   %@ %@ ",adder,latitude,longitude);

    [PublicMethods writeToUserD:adder andKey:@"addres"];
    [PublicMethods writeToUserD:longitude andKey:@"lon"];
    [PublicMethods writeToUserD:latitude andKey:@"lat"];
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Mapaddres:andlot:andlat:)]) {
        [self.delagate Mapaddres:adder andlot:longitude andlat:latitude];
        [self.navigationController popViewControllerAnimated:YES];

    }

 
}
#pragma mark -TextField
//进入编辑即给出提示
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    /**
     * 当开始搜索时
     * 1、展示个新的列表视图
     * 2、然后开始进行搜索
     */
    
    //步骤 1
    self.mapView.hidden = YES;
    self.locationBtn.hidden = YES;
    self.SeekTableView.hidden = NO;
//    [self.searchPoiArray randomObject];
    
    [self.SeekView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-65);
    }];
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@" 输入的值。 %@",text);

    [self POIKeywordsSearch:text];

    return YES;
}

-(void)POIKeywordsSearch:(NSString *)keyword{
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = keyword;
    request.city                = self.locationcity;
    request.types               = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    request.offset = 50;

    [self.search AMapPOIKeywordsSearch:request];
}
#pragma mark - GET
- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc]init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
        _locationManager.locationTimeout = 2;
        _locationManager.reGeocodeTimeout = 2;
    }
    return _locationManager;
}
-(UITableView *)DTableView{
    if (!_DTableView) {
        _DTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-210, CGRectGetWidth(self.view.bounds), 210) style:UITableViewStylePlain];
//        _DTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _DTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _DTableView.delegate = self;
        _DTableView.dataSource = self;
        _DTableView.allowsSelectionDuringEditing = YES;
        [_DTableView registerNib:[UINib nibWithNibName:@"SeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"SeekTableViewCell"];
        
    }
    return _DTableView;
}
-(UITableView *)SeekTableView{
    if (!_SeekTableView) {
        _SeekTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, CGRectGetWidth(self.view.bounds), 210) style:UITableViewStylePlain];
//        _SeekTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SeekTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _SeekTableView.delegate = self;
        _SeekTableView.dataSource = self;
        _SeekTableView.allowsSelectionDuringEditing = YES;
        [_SeekTableView registerNib:[UINib nibWithNibName:@"SeekTableViewCell" bundle:nil] forCellReuseIdentifier:@"SeekTableViewCell"];
        
    }
    return _SeekTableView;
}
// 装载数据坐标
-(NSMutableArray *)searchPoiArray
{
    if (!_searchPoiArray) {
        _searchPoiArray = [[NSMutableArray alloc]init];
    }
    return _searchPoiArray;
}
-(NSMutableArray *)seekdataArry
{
    if (!_seekdataArry) {
        _seekdataArry = [[NSMutableArray alloc]init];
    }
    return _seekdataArry;
}
@end
