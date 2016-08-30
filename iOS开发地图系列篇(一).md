###应用场景

现在很多社交、电商、团购应用都引入了地图和定位功能，像我们平时生活常用到的外卖软件基本上都有定位功能，这也方便用户填写收货地址，增强了用户体验，也能让用户随时看到自己的外卖已经走到了什么地方。再比如：你到了一个陌生的地方想要查找附近的酒店、超市等就可以打开软件搜索周边。在你去某个地方出去游玩的时候，也可以进行路线查询，提前知道出行路线，总之，目前地图和定位功能已经大量引入到应用开发中。今天就和大家一起看一下iOS如何进行地图和定位开发。

###地图主要功能

我们在开发软件中最常用到的功能主要是:最基础的地图定位功能、周边搜索功能、路径规划等功能。

###地图定位功能

####1> 地理编码 

除了提供位置跟踪功能之外，在定位服务中还包含CLGeocoder类用于处理地理编码和逆地理编码（又叫反地理编码）功能。

地理编码：根据给定的位置（通常是地名）确定地理坐标(经、纬度)。
逆地理编码：可以根据地理坐标（经、纬度）确定位置信息（街道、门牌等）。

CLGeocoder最主要的两个方法就是
```
- (void)geocodeAddressString:(NSString *)addressString completionHandler:(CLGeocodeCompletionHandler)completionHandler;
- (void)reverseGeocodeLocation:(CLLocation *)location completionHandler:(CLGeocodeCompletionHandler)completionHandler;
```
分别用于地理编码和逆地理编码。
这个相对比较简单，这里就不做代码演示了。

####2> 定位功能 

在iOS中通过Core Location框架进行定位操作。Core Location自身可以单独使用，和地图开发框架MapKit完全是独立的，但是往往地图开发要配合定位框架使用。在Core Location中主要包含了定位、地理编码（包括反编码）功能。
定位是一个很常用的功能，如一些地图软件打开之后如果用户允许软件定位的话，那么打开软件后就会自动锁定到当前位置，如果用户手机移动那么当前位置也会跟随着变化。要实现这个功能需要使用Core Loaction中CLLocationManager类。首先看一下这个类的一些主要方法和属性：

![181044408609425.png](http://upload-images.jianshu.io/upload_images/726092-b111b9c628de2e69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![181044568607670.png](http://upload-images.jianshu.io/upload_images/726092-5d0fee5233e494cc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

iOS 8 还提供了更加人性化的定位服务选项。App 的定位服务不再仅仅是关闭或打开，现在，定位服务的启用提供了三个选项，「永不」「使用应用程序期间」和「始终」。同时，考虑到能耗问题，如果一款 App 要求始终能在后台开启定位服务，iOS 8 不仅会在首次打开 App 时主动向你询问，还会在日常使用中弹窗提醒你该 App 一直在后台使用定位服务，并询问你是否继续允许。在iOS7及以前的版本，如果在应用程序中使用定位服务只要在程序中调用startUpdatingLocation方法应用就会询问用户是否允许此应用是否允许使用定位服务，同时在提示过程中可以通过在info.plist中配置通过配置Privacy - Location Usage Description告诉用户使用的目的，同时这个配置是可选的。
但是在iOS8中配置配置项发生了变化，可以通过配置NSLocationAlwaysUsageDescription或者NSLocationWhenInUseUsageDescription来告诉用户使用定位服务的目的，并且注意这个配置是必须的，如果不进行配置则默认情况下应用无法使用定位服务，打开应用不会给出打开定位服务的提示，除非安装后自己设置此应用的定位服务。同时，在应用程序中需要根据配置对requestAlwaysAuthorization或locationServicesEnabled方法进行请求。

在开发过程中记得加入CoreLocation.framework和MapKit.framework动态库，下面通过代码给大家详解，代码如下：

```
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interfaceViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (weak, nonatomic) IBOutletUILabel *cityLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [superviewDidLoad];
    //1.使用定位服务
    //设置app有访问定位服务的权限
    //在使用应用期间 / 始终(app在后台)
    //info.plist文件添加以下两条(或者其中一条):
    //NSLocationWhenInUseUsageDescription 在使用应用期间
    //NSLocationAlwaysUsageDescription 始终
    //2.LocationManager 对象管理相关的定位服务
    _manager = [[CLLocationManageralloc] init];
    //manager判断: 手机是否开启定位 / app是否有访问定位的权限
    //[CLLocationManager locationServicesEnabled]; //手机是否开启定位
    //[CLLocationManager authorizationStatus]; //app访问定位的权限的状态
    if (![CLLocationManagerlocationServicesEnabled] || [CLLocationManagerauthorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_managerrequestWhenInUseAuthorization]; //向用户请求访问定位服务的权限
    }
     //设置代理
    _manager.delegate = self;
    //设置定位精度
    _manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //定位频率,每隔多少米定位一次
    _manager.distanceFilter = 10.0f;
    //启动跟踪定位
    [_managerstartUpdatingLocation];
}

#pragma mark 跟踪定位代理方法,每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //如果不需要实时定位，使用完即使关闭定位服务
    [_managerstopUpdatingLocation];
    CLGeocoder * geoCoder = [[CLGeocoderalloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *location = [placemark addressDictionary];
            // Country(国家) State(城市) SubLocality(区) Name全称
            NSLog(@"%@", [location objectForKey:@"State"]);
            _cityLabel.text = [location objectForKey:@"State"];
        }
    }];
}

@end

```

#####注意：
1、定位频率和定位精度并不应当越精确越好，需要视实际情况而定，因为越精确越耗性能，也就越费电。
2、定位成功后会根据设置情况频繁调用-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations方法，这个方法返回一组地理位置对象数组，每个元素一个CLLocation代表地理位置信息（包含经度、纬度、海报、行走速度等信息），之所以返回数组是因为有些时候一个位置点可能包含多个位置。
3、使用完定位服务后如果不需要实时监控应该立即关闭定位服务以节省资源。
4、除了提供定位功能，CLLocationManager还可以调用startMonitoringForRegion:方法对指定区域进行监控。

demo地址：https://github.com/huanghaiyan/MapLocation-master 

####3>大头针 

控件MKMapView的的一些常用属性和方法

![181525382354302.png](http://upload-images.jianshu.io/upload_images/726092-07dd731a0fbd3954.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
￼
![181525472981968.png](http://upload-images.jianshu.io/upload_images/726092-79eca25c7375bb5c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

demo代码如下:

```
#import "ViewController.h"
#import "JZLocationConverter.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interfaceViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
/**
 *  定位管理器
 */
@property (nonatomic,strong) CLLocationManager *locationManager;
/**
 *  地理位置解码编码器
 */
@property (nonatomic,strong) CLGeocoder *geocoder;
/**
 *  地图控件
 */
@property (nonatomic,strong) MKMapView *mapView;
/**
 *  大头针
 */
@property (nonatomic,strong)  MKPointAnnotation *pointAnnotation;

@end

@implementation ViewController

- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        //创建定位管理器对象，作用是定位当前用户的经度和纬度
        _locationManager = [[CLLocationManageralloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManagerrequestAlwaysAuthorization];
        _locationManager.distanceFilter = 10.f;
    }
    return_locationManager;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoderalloc]init];
    }
    return_geocoder;
}

- (MKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MKMapViewalloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //设置地图的类型
        _mapView.maskView = MKMapTypeStandard;
        //显示当前用户的位置
        _mapView.showsUserLocation = YES;
    }
    return_mapView;
}

- (MKPointAnnotation *)pointAnnotation
{
    if (!_pointAnnotation) {
        _pointAnnotation = [[MKPointAnnotationalloc]init];
    }
    return_pointAnnotation;
}

- (void)viewDidLoad {
    [superviewDidLoad];
    //info.plist文件添加以下两条(或者其中一条):
    //NSLocationWhenInUseUsageDescription 在使用应用期间
    //NSLocationAlwaysUsageDescription 始终
    [self.viewaddSubview:self.mapView];
    if(![CLLocationManagerlocationServicesEnabled]||[CLLocationManagerauthorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManagerrequestWhenInUseAuthorization];
    }
    [self.locationManagerstartUpdatingLocation];

}
#pragma mark -定位代理经纬度回调
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [self.locationManagerstopUpdatingLocation];
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oCoordinate = newLocation.coordinate;
    CLLocationCoordinate2D gcjPt = [JZLocationConverterwgs84ToGcj02:oCoordinate];
    //定义地图的缩放比例
    MKCoordinateSpan coordinateSpan;
    coordinateSpan.longitudeDelta = 0.1;
    coordinateSpan.latitudeDelta = 0.1;
    //为地图添加定义的内容
    MKCoordinateRegion coordinateRegion;
    coordinateRegion.center = gcjPt;
    coordinateRegion.span = coordinateSpan;
   
    //添加到地图上
    [self.mapViewsetRegion:coordinateRegion animated:YES];
   
    [self.geocoderreverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSDictionary *location = [place addressDictionary];
           
            //设置大头针坐标
            self.pointAnnotation.coordinate = gcjPt;
            self.pointAnnotation.title = [location objectForKey:@"State"];
            self.pointAnnotation.subtitle = [location objectForKey:@"SubLocality"];
           
            //添加大头针对象
            [self.mapViewaddAnnotation:self.pointAnnotation];
           
            NSLog(@"国家：%@",[location objectForKey:@"Country"]);
            NSLog(@"城市：%@",[location objectForKey:@"State"]);
            NSLog(@"区：%@",[location objectForKey:@"SubLocality"]);
        }
    }];
}

@end

```
demo地址：https://github.com/huanghaiyan/MKPointAnnotation-master