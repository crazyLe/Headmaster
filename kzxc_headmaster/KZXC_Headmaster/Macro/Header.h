//
//  Header.h
//  KZXC_Instructor
//
//  Created by 翁昌青 on 16/6/27.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#ifndef Header_h
#define Header_h

//自定义Log
#ifdef DEBUG
#define HJLog(format, ...) {NSLog((@" 输出:" format @" 方法名:%s  行数:%d" ),##__VA_ARGS__,__PRETTY_FUNCTION__,__LINE__);}
#else
#define HJLog(...)
#endif

#define pushID [[UIDevice currentDevice] identifierForVendor].UUIDString

#define deviceInfo [NSString stringWithFormat:@"%@,%@",[UIDevice currentDevice].model,[UIDevice currentDevice].systemVersion];

#define curDefaults [NSUserDefaults standardUserDefaults]
#define kUid [curDefaults valueForKey:@"kUid"]
#define kToken [curDefaults valueForKey:@"kToken"]
#define kDounum [curDefaults valueForKey:@"douNum"]
#define kPhone [curDefaults valueForKey:@"phone"]
#define kNickName [curDefaults valueForKey:@"kNickName"]
#define kAuthState [curDefaults valueForKey:@"kAuthState"] //实名认证状态
#define kShowState [curDefaults valueForKey:@"kShowState"] //实名认证状态

//登录状态  1代表登录
#define kLoginStatus ([curDefaults objectForKey:@"isLogin"])

//通知中心
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]

//tabbarIndex
#define tabbarIndex 0
//屏幕宽度
#define kWidth [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define kHeight [UIScreen mainScreen].bounds.size.height

#define loginH (kWidth - 30.00)*(153.00/789.00)
//适配高度
#define HHeader               (kHeight/667.0)
#define WHeader               (kWidth/375.0)



//市字典
//#define kCityDict [curDefaults objectForKey:@"cityDict"]
////省字典
//#define kProvinceDict [curDefaults objectForKey:@"provinceDict"]
////县字典
//#define kCountryDict [curDefaults objectForKey:@"countryDict"]
////
//#define kProvinceData [curDefaults objectForKey:@"addressArray"]

#define WeakObj(o) __weak typeof(o) o##Weak = o;

//单例声明
#define singletonInterface(className) + (instancetype)shared##className;
//单例实现
#define singletonImplementation(className)\
static className *_instance;\
+ (id)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##className\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}

//RGB色值
#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//自由色
#define RandomColor RGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

//是否是iphone6以上设备
#define isUpIPhone6 ([UIScreen mainScreen].bounds.size.width > 320)

#define isIPhone6 ([UIScreen mainScreen].bounds.size.height == 667)

#define isIPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define isIPhpne4 ([UIScreen mainScreen].bounds.size.height == 480)

//字体
#define twelveFont [UIFont systemFontOfSize:12.0]
#define thirteenfont [UIFont systemFontOfSize:13.0]
#define fourteenFont [UIFont systemFontOfSize:14.0]
#define fifteenFont [UIFont systemFontOfSize:15.0]

#define Font11 [UIFont systemFontOfSize:11.0]
#define Font12 [UIFont systemFontOfSize:12.0]
#define Font13 [UIFont systemFontOfSize:13.0]
#define Font14 [UIFont systemFontOfSize:14.0]
#define Font15 [UIFont systemFontOfSize:15.0]
#define Font16 [UIFont systemFontOfSize:16.0]
#define Font17 [UIFont systemFontOfSize:17.0]
#define Font18 [UIFont systemFontOfSize:18.0]
#define Font19 [UIFont systemFontOfSize:19.0]
#define Font20 [UIFont systemFontOfSize:20.0]
#define Font22 [UIFont systemFontOfSize:22.0]

#define kFont11 Font11
#define kFont13 Font13
#define kFont14 Font14
#define kFont15 Font15

//基本类型转String/Number
#define integerToStr(para) [NSString stringWithFormat:@"%ld",para]
#define intToStr(para)     [NSString stringWithFormat:@"%d",para]
#define floatToStr(para)   [NSString stringWithFormat:@"%f",para]
#define doubleToStr(para)  [NSString stringWithFormat:@"%f",para]
#define numToStr(para)     [NSString stringWithFormat:@"%@",para]
#define strToNum(para)     [NSNumber numberWithString:para]

#define kNavHeight 64
#define kTabBarHeight 49
#define BG_COLOR [UIColor colorWithHexString:@"#f2f7f6"]

//用于划线时的高度在不同机型适配
#define LINE_HEIGHT (([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))?0.5:1)

//用于定义collectionViewCell分割线使用
#define kTableViewSeparaterLineColor [UIColor colorWithRed:0.70f green:0.70f blue:0.70f alpha:1.00f]


//粗体
#define BoldFontWithSize(f) [UIFont fontWithName:@"Helvetica-Bold" size:f]

//色值 333 666 999
#define ColorThree  RGBColor(51,51,51)
#define ColorSix    RGBColor(102,102,102)
#define ColorNine   RGBColor(153,153,153)
//色值转uicolor
//#define UIColorFromRGB(rgbValue) [UIColor \
//colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
//green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
//blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//提交按钮大小及色值
//#define Font18 [UIFont systemFontOfSize:18.0]
#define CommonButtonBGColor RGBColor(255,104,103)
#define ButtonH 44
#define HomeBtnH 50

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO




#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

//空判断相关
#define isEmptyStr(str) (!str||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]) //判断是否空字符串
#define isEmptyArr(arr) (!arr||((NSArray *)arr).count==0) //判断是否空数组
#define isNull(str)     (!str||[str isKindOfClass:[NSNull class]])

#define kHandleEmptyStr(str) (isEmptyStr(str)?@"":str)  //解决空字符串问题
#define kEmptyStrToZero(str) (isEmptyStr(str)?@"0":str)  //解决空字符串问题

//文件管理相关
#define kFileManager [NSFileManager defaultManager]

#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory\
, NSUserDomainMask, YES)[0]

/*******************城市相关*************************/

#define kUserDefault curDefaults

//城市相关
#define kCityName      [kUserDefault objectForKey:@"CoachAreaName"]      //城市名 全称
#define kCityID        [kUserDefault objectForKey:@"CoachAreaID"]        //城市ID
#define kCityShortName [kUserDefault objectForKey:@"CoachAreaShortName"] //城市名 简称

#define kAreaVersion   [kUserDefault objectForKey:@"CoachAreaVersion"]   //地区版本号
#define cacheProvinceDataKey @"cacheProvinceDataKey"
#define cacheCityDataKey @"cacheCityDataKey"
#define cacheCountyDataKey @"cacheCountyDataKey"

//开放城市已改为市字典
#define kOpenCityTableName @"OpenCityTable"
#define kOpenCityTableColumnArr @[@"id",@"hot",@"level",@"name",@"parent_id",@"pinyin",@"short_name",@"title"]
#define kCityDict [[SCDBManager shareInstance] getAllObjectsFromTable:kOpenCityTableName KeyArr:kOpenCityTableColumnArr]

//省字典
#define kProvinceTableName @"kProviceTableName"
#define kProvinceTableCollumnArr @[@"id",@"hot",@"level",@"name",@"parent_id",@"pinyin",@"short_name",@"title"]
#define kProvinceDict [[SCDBManager shareInstance] getAllObjectsFromTable:kProvinceTableName KeyArr:kProvinceTableCollumnArr]

//县字典
#define kCountyTableName @"kCountyTableName"
#define kCountyTableCollumnArr @[@"id",@"hot",@"level",@"name",@"parent_id",@"pinyin",@"short_name",@"title"]
#define kCountryDict [[SCDBManager shareInstance] getAllObjectsFromTable:kCountyTableName KeyArr:kCountyTableCollumnArr]

#define kProvinceData [kUserDefault objectForKey:@"addressArray"]

//#define isUpdateDataBase ([[kUserDefault objectForKey:@"isUpdateDataBase"] boolValue])

#define isStartUpdaeDB ([[kUserDefault objectForKey:@"AreaStartUpdateFlag"] boolValue])

#endif /* Header_h */
