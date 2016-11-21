//
//  ConfigFile.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/8.
//  Copyright © 2016年 cqingw. All rights reserved.
//


#ifndef ConfigFile_h
#define ConfigFile_h

#define versioncode 2

/**
 *  导航栏色值
 *
 *  @return 导航栏色值
 */
#define NavBackColor RGBColor(209,35,45)

/**
 *  导航栏title设置
 *
 *  @return 导航栏title属性字典
 */
#define NavTitleTextAttributes [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:22.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]

#define NavRightTitleTextAttributes [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]

/**
 *  导航栏返回按钮
 */
#define NavBack @"back"

/**
 *  tabbar标题
 *
 *  @return tabbar标题
 */
#define TabBarTitleArray @[@"首页",@"钱袋",@"圈子",@"我的"]

/**
 *  tabbar按钮nNomale状态图片名称
 *
 *  @return tabbar按钮nomale状态图片名称
 */

#define TabBarNomalPicArray @[@"tabbar_home",@"tabbar_cash",@"tabbar_circle",@"tabbar_my"]

/**
 *  tabbar按钮selected状态图片名称
 *
 *  @return tabbar按钮selected状态图片名称
 */

#define TabBarSelectedPicArray @[@"tabbar_home_selected",@"tabbar_cash_selected",@"tabbar_circle_selected",@"tabbar_my_selected"]


/**
 *  tabbar字体设置
 *
 *  @return tabbar字体属性
 */
#define TabBarTitleTextAttributes [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:11.0],NSFontAttributeName,nil]

/**
 *****************************首页模块******************************
 */

//第一排按钮
#define RecommendArray @[@"校长课堂",@"校长圈",@"关注度",@"驾校订单"]

//第一排按钮图片名称
#define RecomendPicArray @[@"firgroup_0",@"firgroup_1",@"firgroup_2",@"firgroup_3"]

//招生神器
#define  SupplyArray @[@"招生神器",@"教练招生团",@"代金劵",@"赏金猎人",@"招生推广"]

//招生神器按钮图片
#define SupplyPicArray @[@"ad_leftImage",@"ad_right_one",@"ad_right_two",@"ad_right_three",@"ad_right_four"]
//招生神器按钮宽度
#define adBtnW kWidth/4
//驾校福利
#define ServicesArray @[@"驾校福利",@"ser_one",@"ser_two",@"ser_three",@"ser_four"]
//驾校福利按钮宽度
#define serBtnW (kWidth - 50)/2

//微名片订制模块
//,@"普通版 c1 3500元 周一至周日",@"普通版 c1 4000元 周一至周日",@"普通版 c1 4500元 周一至周日
#define personTailorArr @[@"驾校名称",@"LOGO",@"地址",@"办学年限(年)",@"场地规格(亩)",@"车辆(辆)",@"介绍",@"平均拿证时间(天)",@"科目二通过率(%)",@"科目三通过率(%)",@"班型"]
#define personTailorValueTestArr @[@"合肥新亚驾校",@"tailor_logo",@"安徽省 合肥市 瑶海区",@"10年",@"80亩",@"100辆",@"高一流驾校",@"60天",@"85%",@"90%",@"添加"]

//我要出租
#define  LeaseArray @[@[@"发布者",@"联系电话",@"地址",@"详细地址"],@[@"面积(亩)",@"车库(个)",@"容量(辆)",@"科目"],@[@"按天计费(元/天)",@"按周计费(元/周)",@"按月计费(元/月)",@"按季计费(元/季)",@"按年计费(元/年)"]]
#define  LeaseCocahCarArray @[@[@"发布者",@"联系电话",@"地址",@"详细地址"],@[@"车型",@"数量(量)",@"车龄(年)",@"里程(万公里)"],@[@"按天计费(元/天)",@"按周计费(元/周)",@"按月计费(元/月)",@"按季计费(元/季)",@"按年计费(元/年)"]]
#define  LeaseValueArray @[@[@"新亚驾校",@"请输入您的手机号码",@"请输入地址",@"请输入详细地址"],@[@"请输入场地面积",@"场地设多少车库",@"最大可容纳多少车量",@"科目二场地"],@[@"¥100/天",@"¥600/周",@"¥2500/月",@"¥6500/季",@"¥26500/年"]]
#define  LeaseCocahValueArray @[@[@"新亚驾校",@"请输入您的手机号码",@"请输入地址",@"请输入详细地址"],@[@"请输入车型",@"请输入教练车数量",@"请输入车龄",@"请输入里程"],@[@"¥100/天",@"¥600/周",@"¥2500/月",@"¥6500/季",@"¥26500/年"]]

#define LeaseHeadImgArrar @[@"section1",@"section2",@"section1",@"section1"]
#define LeaseHeadTitleArray @[@"场地信息",@"价格信息",@"备注",@"上传图片"]


//编辑代金劵

#define  editVoucherArray @[@"标题",@"金额",@"开始时间",@"结束时间"]

//合作名额
#define HZMEKeyArray @[@[@"发布者",@"联系电话",@"地址",@"详细地址"],@[@"人数(人)",@"拿证时间要求(天)",@"考试地域要求",@"转让价格(元)"]]
#define HZMEValueArray @[@[@"请输入发布驾校",@"请输入您的手机号码",@"请输入您的地址",@"请输入您的详细地址"],@[@"请输入转让人数",@"请输入拿证时间要求",@"限本市",@"请输入转让价格"]]

/**
 *****************************我的模块******************************
 */
//#define MineListArray @[@[@"赚豆："],@[@"我的消息",@"我的圈子",@"驾校认证",@"校长助理",@"账号设置",@"账号安全"],@[@"关于"]]
//#define MineListArray @[@[@"我的消息",@"我的圈子",@"驾校认证",@"校长助理",@"账号设置",@"账号安全"],@[@"关于"]]

//#define MineListImgArray @[@[@"mine_list_dou"],@[@"mine_list_xiaoxi",@"mine_list_quanzi",@"mine_list_renzheng",@"xzzl",@"mine_list_shezhi",@"mine_list_anquan"],@[@"mine_list_guanyu"]]
//#define MineListImgArray @[@[@"mine_list_xiaoxi",@"mine_list_quanzi",@"mine_list_renzheng",@"xzzl",@"mine_list_shezhi",@"mine_list_anquan"],@[@"mine_list_guanyu"]]

//充值说明：1元＝10赚豆 2.只能充值整数金额 3.充值成功后若赚豆未到账请联系客服400－000-000
#define tipsOne @"1、1元＝10赚豆"
#define tipsTwo @"2、只能充值整数金额"
#define tipsThi @"3、充值成功后若赚豆未到账请联系客服400－800-6533"

//提现
#define  TXKeyArray @[@"赚豆余额:",@"可提金额:",@"提现金额:",@"提现银行:",@"银行卡号:",@"开 户 名:"]
#define TXPlaceholderArray @[@"请输入提现金额",@"请输入银行",@"请输入本人实名卡号",@"请输入本人实名"]
#define TXTipsArray @[@"1、1元＝10赚豆",@"2、提现最低标准1000赚豆，即100元",@"3、提现赚豆必须是1000的整数倍",@"4、提现申请提交后一般在12小时内到账，\n      遇节假日顺延",@"5、提现暂不收取任何手续费",@"6、提现48小时未到账时，请联系客服"]

//个人设置
#define MineSetArray @[@[@"姓名",@"头像",@"性别",@"年龄",@"手机号"],@[@"驾校",@"地址"]]

#define MineSetValuesArray @[@[@"沈慧敏",@"icon",@"25",@"女",@"1775510128"],@[@"合肥新安驾校",@"安徽省 合肥市 瑶海区"]]

//验证界面
#define validationPhoneNum @"400-800-6533"

#endif /* ConfigFile_h */








