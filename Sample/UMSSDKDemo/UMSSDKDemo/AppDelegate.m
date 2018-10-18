//
//  AppDelegate.m
//  UMSSDKDemo
//
//  Created by 刘靖煌 on 17/5/22.
//  Copyright © 2017年 com.mob. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <UMSSDKUI/UMSMainTabBarController.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeFacebook),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                          
                          switch (platformType)
                          {
                              case SSDKPlatformTypeSinaWeibo:
                                  //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"60529370"
                                                            appSecret:@"575ab95e19b8a0dbf3c6246f8144ba8f"
                                                          redirectUri:@"http://www.sharesdk.cn"
                                                             authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeFacebook:
                                  //设置Facebook应用信息，其中authType设置为只用SSO形式授权
                                  [appInfo SSDKSetupFacebookByApiKey:@"1201984966578499"
                                                           appSecret:@"eb6e8dcb41cfc7223ffbdaf31fece024"
                                                         displayName:@"UMSSDK"
                                                            authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeWechat:
                                  [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                                        appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                                  break;
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:@"100371282"
                                                       appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                                     authType:SSDKAuthTypeBoth];
                                  break;
                              default:
                                  break;
                          }
                      }];
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.rootViewController = [[UMSMainTabBarController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    return YES;
}

@end
