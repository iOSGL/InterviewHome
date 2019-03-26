//
//  AppDelegate.m
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "AppDelegate.h"
#import "WXDefine.h"
#import <WeexSDK/WeexSDK.h>
#import <AVFoundation/AVFoundation.h>
#import "WeexSDKManager.h"
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMPush/UMessage.h>
#import <UMShare/UMShare.h>
#import "AppConfig.h"
#import "BaseProcessHandler.h"
#import "DownloadApi.h"
#import <SSZipArchive/SSZipArchive.h>
#import "UpdateApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define UM_APPKEY @"5b3de566f29d980dae00007a"
#define SINA_APPKEY @"3646337853"
#define SINA_SECRET @"bee7d46f7512a6faa54739323d429ecc"
#define QQ_APPKID @"1107024056"
#define QQ_APPKEY @"E1Hf6wZZA8jue3m4"
#define WX_APPKEY @"wx7479228bc30af11a"
#define WX_APP_SECRETC @"1eb4d50dcd3ddf61fb92bb0885398f61"
#define LOCAL_VERSION @"jsbundle_version"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configUM]; // 配置友盟
    [self configUMPush:launchOptions]; // 配置友盟推送
    [self configUMSharePlatforms]; // 配置分享平台
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [AppConfig setUp];
    [WeexSDKManager setup];
    [self.window makeKeyAndVisible];
    //    [self startSplashScreen];
    [self checkUpdate];
    return YES;
}


#pragma mark
#pragma mark - UMPush Delegate

//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:false];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
        [[BaseProcessHandler sharedInstance]mediatorViewController:[MethodsUtil getCurrentVC] didSelectServiceCategory:serviceTypeWeb param:userInfo];
        
    }else{
        //应用处于后台时的本地推送接受
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}

#pragma mark
#pragma mark - UMShare Call Back

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark
#pragma mark - Config UM

- (void)configUM {
    [UMConfigure initWithAppkey:UM_APPKEY channel:@"App Store"];
    [MobClick setScenarioType:E_UM_NORMAL];
    [UMessage setBadgeClear:YES];
    [UMessage setAutoAlert:YES];
#if DEBUG
    [UMConfigure setLogEnabled:YES];
# else
    [UMConfigure setLogEnabled:false];
#endif
    
}

#pragma mark
#pragma mark - Confiig U-Push

- (void)configUMPush:(NSDictionary *)launchOptions {
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories=categories;
    }
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        }else{
            
        }
    }];
}

#pragma mark
#pragma mark -

- (void)configUMSharePlatforms {
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APPKEY appSecret:WX_APP_SECRETC redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPKID/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPKEY  appSecret:SINA_SECRET redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

#pragma mark
#pragma mark animation when startup

- (void)startSplashScreen
{
    UIView* splashView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    splashView.backgroundColor = WEEX_COLOR;
    
    UIImageView *iconImageView = [UIImageView new];
    UIImage *icon = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weex-icon" ofType:@"png"]];
    if ([icon respondsToSelector:@selector(imageWithRenderingMode:)]) {
        iconImageView.image = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        iconImageView.tintColor = [UIColor whiteColor];
    } else {
        iconImageView.image = icon;
    }
    iconImageView.frame = CGRectMake(0, 0, 320, 320);
    iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    iconImageView.center = splashView.center;
    [splashView addSubview:iconImageView];
    
    [self.window addSubview:splashView];
    
    float animationDuration = 1.4;
    CGFloat shrinkDuration = animationDuration * 0.3;
    CGFloat growDuration = animationDuration * 0.7;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [UIView animateWithDuration:shrinkDuration delay:1.0 usingSpringWithDamping:0.7f initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            iconImageView.transform = scaleTransform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:growDuration animations:^{
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
                iconImageView.transform = scaleTransform;
                splashView.alpha = 0;
            } completion:^(BOOL finished) {
                [splashView removeFromSuperview];
            }];
        }];
    } else {
        [UIView animateWithDuration:shrinkDuration delay:1.0 options:0 animations:^{
            CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.75, 0.75);
            iconImageView.transform = scaleTransform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:growDuration animations:^{
                CGAffineTransform scaleTransform = CGAffineTransformMakeScale(20, 20);
                iconImageView.transform = scaleTransform;
                splashView.alpha = 0;
            } completion:^(BOOL finished) {
                [splashView removeFromSuperview];
            }];
        }];
    }
}

#pragma mark -

- (void)checkUpdate {
    NSString *localVersion = [[NSUserDefaults standardUserDefaults]stringForKey:LOCAL_VERSION];
    if (!localVersion) {
        localVersion = [UIApplication sharedApplication].appVersion;
    }
    UpdateApi *update = [[UpdateApi alloc]initWithLocakVersion:localVersion];
    [update startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([[DataAnalytical getStatusCode:request] isEqualToString:@"200"]) {
            NSDictionary *dic = [DataAnalytical getResponseDic:request];
            DownloadApi *download = [[DownloadApi alloc]initWithUrl:dic[@"RELEASE_URL"]];
            [download startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                if ([SSZipArchive unzipFileAtPath:ZIP_PATH toDestination:DOCUMENT_PATH]) {
                    [[NSUserDefaults standardUserDefaults]setObject:dic[@"RELEASE_NUM"] forKey:LOCAL_VERSION];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"解压失败"];
                }
                NSFileManager *manger = [NSFileManager defaultManager];
                if ([manger fileExistsAtPath:ZIP_PATH]) {
                    [manger removeItemAtPath:ZIP_PATH error:nil];
                }
            } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                [SVProgressHUD showErrorWithStatus:@"更新失败"];
            }];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
