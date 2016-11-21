//
//  Interface.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/8.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#ifndef Interface_h
#define Interface_h



//开发环境
#define ceshiUrl @"http://192.168.5.216:81"
#define basicUrl ceshiUrl @"/index.php/school"

//生产环境
//#define shengchanUrl @"https://www.kangzhuangxueche.com"
//#define basicUrl shengchanUrl @"/index.php/school"

/**
 *  ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝登录注册模块＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
 */
//获取注册验证码
#define getResCodeUrl basicUrl@"/user/getVerificationCode"

//用户注册
#define registerUrl basicUrl@"/user/register"

//获取登录验证码
#define  getLogCodeUrl basicUrl@"/user/sendCode"

//用户登录
#define loginUrl basicUrl@"/user/login"

//找回密码
#define findPswUrl basicUrl@"/user/findPassword"

/**
 *  ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝首页模块＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
 */

//首页
#define homeUrl basicUrl@"/main"

//获取地址
#define getAddressUrl basicUrl@"/getAddress"
//#define getAddressUrl @"https://www.kangzhuangxueche.com/index.php/school/getAddress"
//校长课堂
#define  masterLessonUrl basicUrl@"/article"

//关注度
#define attenionUrl basicUrl@"/statistics"

//招生团
#define zhaoshengUrl basicUrl@"/recruit"

//驾校订单
#define jiaxiaoOrderUrl basicUrl@"/Mypurse/Schoolorder"

//微名片url(测试环境)
#define wmpUrl @"http://192.168.5.216:81/index.php/wap/card/show/%@?app=1&uid=%@&address=%@,%@&cityId=%@"

//#define wmpUrl @"https://www.kangzhuangxueche.com/index.php/wap/card/show/%@?app=1&uid=%@&address=%@,%@&cityId=%@"

//微名片数据获取
#define getwmpMsgUrl basicUrl@"/card/retrieve"

//微名片编辑
#define wmpEditUrl basicUrl@"/card/update"

//教练招生团奖励
#define jiangliDouziUrl basicUrl@"/recruit/bonuses"

//教练招生团管理
#define managerUrl basicUrl@"/recruit/retrieve"

//教练招生团邀请
#define yaoqingUrl basicUrl@"/recruit/create"

//教练招生团成员删除
#define zhaoshengDeleteUrl basicUrl@"/recruit/delete"

//代金劵
#define ddjUrl basicUrl@"/cashCoupon"

//代金劵新增
#define ddjAddUrl basicUrl@"/cashCoupon/create"

//代金劵编辑
#define ddjEditUrl basicUrl@"/cashCoupon/update"

//代金劵删除
#define ddjDeleteUrl basicUrl@"/cashCoupon/delete"

//会员-个人设置获取
#define getMemberInfo basicUrl@"/member/info"

//会员-个人设置编辑
#define submitMemberInfo basicUrl@"/member/update"

//驾校认证状态
#define schoolAuthenticationState basicUrl@"/userAuth"

//各种车型(carType)
#define getCarTypeUrl basicUrl@"/getCar"

//教练车租赁
#define coachCarLease basicUrl@"/carHire"

//教练车出租
#define coachCarMyLease basicUrl@"/myCarHire"

//教练车租赁详情
#define coachCarLeaseDetail basicUrl@"/carHire/retrieve"

//教练车出租列表-新增/编辑
#define addCocahCar basicUrl@"/myCarHire/cu"

//场地租赁
#define venueLease basicUrl@"/venue"

//场地租赁详情
#define venueLeaseDetail basicUrl@"/venue/retrieve"

//场地出租列表
#define myVenueLease basicUrl@"/myVenue"

//场地出租列表-新增/编辑
#define addVenue basicUrl@"/myVenue/cu"

//考试名额
#define MEHZUrl basicUrl@"/examinationQuota"

//我的考试名额
#define myExamQuota basicUrl@"/myExaminationquota"

/**
 *  ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝钱袋＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
 */

//钱袋首页
#define  myPurseUrl basicUrl@"/Mypurse/Purse"

//钱袋账单
#define myPirseUrlOrderUrl basicUrl@"/Mypurse/bill"

//提现
#define tixianUrl basicUrl@"/getCash"

//赚豆规则
//#define zhuandouRuleUrl @"http://115.29.172.68/index.php/wap/beans/rule"

//如何活得赚豆
//#define zhuandouHowgetURrl @"http://115.29.172.68/index.php/wap/beans/howget"

/**
 *  ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝圈子＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
 */

#define basicCircleWebUrl @"http://192.168.5.216:81/index.php/wap/community/show"
//#define basicCircleWebUrl @"https://www.kangzhuangxueche.com/index.php/wap/community/show"

//平台圈子
#define  getCircleUrl basicUrl@"/community"

//我发布
#define getMyCircleUrl basicUrl@"/member/community"

#define getMyCircleListUrl basicUrl@"/member/communitylist"

//发布圈子
#define sendMyCircleUrl basicUrl@"/community/create"

//上传图片
#define uploadCirclePicsUrl basicUrl@"/community/submitPics"

//提交实名认证
#define submitAuthentication basicUrl@"/userAuth/add"

//考试名额详情
#define examinationQuataDetail basicUrl@"/examinationQuota/retrieve"

//考试名额-发布
#define examinationQuataRelease basicUrl@"/examinationQuota/create"

//修改密码
#define editPassword basicUrl@"/editPassword"

//修改手机号
#define editPhone basicUrl@"/editPhone"

//获取验证码
#define getCode basicUrl@"/user/sendCode"

//上传用户头像
#define uploadHeader basicUrl@"/userPics"

//扫一扫
#define saomaUrl basicUrl@"/qrcode"

//获取银行接口
#define getBankUrl basicUrl@"/bank"

//版本检测接口
#define checkVersionUrl basicUrl@"/checkVersion"

//校长助手账号设置
#define setMasterAssistant basicUrl@"/member/setassistant"

//获取消息
#define getAllMsgUrl basicUrl@"/message"

//客户端注册协议
#define getResrules basicUrl@"/wap/agreement"

//充值豆子
#define chongzhiUrl  basicUrl@"/topUpBeans"

//获取银行卡绑定信息
#define getBindBank basicUrl@"/Bankbind/selbank"

//银行卡绑定
#define bindBankCard basicUrl@"/Bankbind/bind"

//驾校钱袋url
#define  jxqdUrl ceshiUrl@"/index.php/wap/clrz"
//#define  jxqdUrl shengchanUrl@"/index.php/wap/clrz"

//首页头条url
#define hometoutiaoUrl ceshiUrl@"/index.php/wap/circle?circleId=3"
#define hometoutiaoUrl2 ceshiUrl@"/index.php/wap/topic?circleId=3"

//#define hometoutiaoUrl shengchanUrl@"/index.php/wap/circle?circleId=3"
//#define hometoutiaoUrl2 shengchanUrl@"/index.php/wap/topic?circleId=3"

#endif /* Interface_h */
