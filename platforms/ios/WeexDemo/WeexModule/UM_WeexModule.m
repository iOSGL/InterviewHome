//
//  UM_WeexModule.m
//  WeexDemo
//
//  Created by genglei on 2018/7/13.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "UM_WeexModule.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import <UMPush/UMessage.h>

@implementation UM_WeexModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(shareEvent: callback:))
WX_EXPORT_METHOD(@selector(setalias:))

- (void)shareEvent:(NSDictionary *)parames callback:(WXModuleKeepAliveCallback)callback {
    if (![parames isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        [SVProgressHUD showErrorWithStatus:@"非法传参"];
        return;
    }
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        switch (platformType) {
            case UMSocialPlatformType_Sina: {
                if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
                    [SVProgressHUD showErrorWithStatus:@"未安装新浪客户端"];
                    return ;
                }
            }
                break;
                
            case UMSocialPlatformType_WechatSession: {
                if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
                    [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                    return ;
                }
            }
                break;
                
            case UMSocialPlatformType_WechatTimeLine: {
                if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatTimeLine]) {
                    [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                    return ;
                }
            }
                break;
                
            case UMSocialPlatformType_QQ: {
                if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
                    [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                    return ;
                }
            }
                break;
                
            case UMSocialPlatformType_Qzone: {
                if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Qzone]) {
                    [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                    return ;
                }
            }
                break;
                
            default:
                break;
        }
        
        NSString *type = parames[@"type"];
        NSString *title = parames[@"title"];
        NSString *des =parames[@"des"];
        NSString *picUrl = parames[@"picUrl"];
        NSString *linkUrl = parames[@"linkUrl"];
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        if ([type isEqualToString:@"link"]) {
            //创建网页内容对象
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:des thumImage:picUrl];
            //设置网页地址
            shareObject.webpageUrl = linkUrl;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
        } else if ([type isEqualToString:@"pic"]) {
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            [shareObject setShareImage:picUrl];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
        } else if ([type isEqualToString:@"richText"]) {
            //设置文本
            messageObject.text = title;
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            //如果有缩略图，则设置缩略图
            shareObject.thumbImage = [UIImage imageNamed:@"icon"];
            [shareObject setShareImage:picUrl];
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
        }
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                callback(error.userInfo[@"message"],false);
            }else{
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            }
        }];
    }];
}

- (void)setalias:(NSDictionary *)params {
    [UMessage addAlias:params[@"userID"] type:params[@"type"] response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        
    }];
}

@end
