//
//  WXNavigatorHandle.m
//  WeexDemo
//
//  Created by genglei on 2018/8/8.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "WXNavigatorHandle.h"
#import "WXConvert.h"
#import "WXBaseViewController.h"
#import "WXSDKManager.h"
#import "WXImgLoaderProtocol.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface WXNavButton :UIButton

@property (nonatomic, strong) NSString *instanceId;
@property (nonatomic, strong) NSString *nodeRef;
@property (nonatomic)  WXNavigationItemPosition position;

@end

@implementation WXNavButton

@end

@implementation WXNavigatorHandle


- (id)navigationControllerOfContainer:(UIViewController *)container {
    return container.navigationController;
}

- (void)popViewControllerWithParam:(NSDictionary *)param completion:(WXNavigationResultBlock)block withContainer:(UIViewController *)container {
    BOOL animated = YES;
    id obj = [param objectForKey:@"animated"];
    if (obj) {
        animated = [WXConvert BOOL:obj];
    }
    
    [container.navigationController popViewControllerAnimated:animated];
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)pushViewControllerWithParam:(NSDictionary *)param completion:(WXNavigationResultBlock)block withContainer:(UIViewController *)container {
    if (0 == [param count] || !param[@"url"] || !container) {
        [self callback:block code:MSG_PARAM_ERR data:nil];
        return;
    }
    
    if ([param[@"type"] isEqualToString:@"weex"]) {
        [self pushWeexController:param completion:block withContainer:container];
    } else if ([param[@"type"] isEqualToString:@"native"]) {
        [self pushNavtiveController:param completion:block withContainer:container];
    } else if ([param[@"type"] isEqualToString:@"web"]) {
        [self pushWeexController:param completion:block withContainer:container];
    } else {
        [self pushWeexController:param completion:block withContainer:container];
    }
}

- (void)setNavigationBackgroundColor:(UIColor *)backgroundColor withContainer:(UIViewController *)container {
    if (backgroundColor) {
        container.navigationController.navigationBar.barTintColor = backgroundColor;
    }
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated withContainer:(UIViewController *)container {
    if (![container isKindOfClass:[WXBaseViewController class]]) {
        return;
    }
    
    container.navigationController.navigationBarHidden = hidden;
}

- (void)setNavigationItemWithParam:(NSDictionary *)param
                          position:(WXNavigationItemPosition)position
                        completion:(WXNavigationResultBlock)block
                     withContainer:(UIViewController *)container
{
    switch (position) {
        case WXNavigationItemPositionLeft:
            [self setNaviBarLeftItem:param completion:block withContainer:container];
            break;
        case WXNavigationItemPositionRight:
            [self setNaviBarRightItem:param completion:block withContainer:container];
            break;
        case WXNavigationItemPositionMore:
            break;
        case WXNavigationItemPositionCenter:
            [self setNaviBarTitle:param completion:block withContainer:container];
            break;
        default:
            break;
    }
}

- (void)clearNavigationItemWithParam:(NSDictionary *)param position:(WXNavigationItemPosition)position completion:(WXNavigationResultBlock)block withContainer:(UIViewController *)container {
    switch (position) {
        case WXNavigationItemPositionLeft:
            [self clearNaviBarLeftItem:param completion:block withContainer:container];
            break;
        case WXNavigationItemPositionRight:
            [self clearNaviBarRightItem:param completion:block withContainer:container];
            break;
        case WXNavigationItemPositionMore:
            break;
        case WXNavigationItemPositionCenter:
            [self clearNaviBarTitle:param completion:block withContainer:container];
            break;
        default:
            break;
    }
}


- (void)setNaviBarLeftItem:(NSDictionary *)param completion:(WXNavigationResultBlock)block
             withContainer:(UIViewController *)container
{
    if (0 == [param count]) {
        [self callback:block code:MSG_PARAM_ERR data:nil];
        return;
    }
    
    UIView *view = [self barButton:param position:WXNavigationItemPositionLeft withContainer:container];
    
    if (!view) {
        [self callback:block code:MSG_FAILED data:nil];
        return;
    }
    
    container.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)clearNaviBarLeftItem:(NSDictionary *) param completion:(WXNavigationResultBlock)block
               withContainer:(UIViewController *)container
{
    container.navigationItem.leftBarButtonItem = nil;
    
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)setNaviBarRightItem:(NSDictionary *)param completion:(WXNavigationResultBlock)block
              withContainer:(UIViewController *)container
{
    if (0 == [param count]) {
        [self callback:block code:MSG_PARAM_ERR data:nil];
        return;
    }
    
    UIView *view = [self barButton:param position:WXNavigationItemPositionRight withContainer:container];
    
    if (!view) {
        [self callback:block code:MSG_FAILED data:nil];
        return;
    }
    
    container.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)clearNaviBarRightItem:(NSDictionary *) param completion:(WXNavigationResultBlock)block
                withContainer:(UIViewController *)container
{
    container.navigationItem.rightBarButtonItem = nil;
    
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)setNaviBarTitle:(NSDictionary *)param completion:(WXNavigationResultBlock)block
          withContainer:(UIViewController *)container
{
    if (0 == [param count]) {
        [self callback:block code:MSG_PARAM_ERR data:nil];
        return;
    }
    
    container.navigationItem.title = param[@"title"];
    
    [self callback:block code:MSG_SUCCESS data:nil];;
}

- (void)clearNaviBarTitle:(NSDictionary *)param completion:(WXNavigationResultBlock)block
            withContainer:(UIViewController *)container
{
    container.navigationItem.title = @"";
    
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)pushWeexController:(NSDictionary *)param completion:(WXNavigationResultBlock)block
             withContainer:(UIViewController *)container {
    NSString *urlPath = param[@"url"];
    if ([param[@"type"] isEqualToString:@"web"]) {
        if ([AppConfig isServerJS]) {
            urlPath = [NSString stringWithFormat:@"%@/Web/webview.js?weburl=%@",DOCUMENT_URL,urlPath];
        } else {
            urlPath = [NSString stringWithFormat:@"%@/Web/webview.js?weburl=%@",BUNDLE_RESOURCE_URL,urlPath];
        }
    } else {
        if (!([urlPath hasPrefix:@"file://"] || [urlPath hasPrefix:@"http://"] || [urlPath hasPrefix:@"https://"])) {
            if ([AppConfig isServerJS]) {
                urlPath = [NSString stringWithFormat:@"%@%@",DOCUMENT_URL,urlPath];
            } else {
                urlPath = [NSString stringWithFormat:@"%@%@",BUNDLE_RESOURCE_URL,urlPath];
            }
        }
    }
   
    BOOL animated = YES;
    NSString *obj = [[param objectForKey:@"animated"] lowercaseString];
    if (obj && [obj isEqualToString:@"false"]) {
        animated = NO;
    }
    
    WXBaseViewController *vc = [[WXBaseViewController alloc]initWithSourceURL:[NSURL URLWithString:urlPath]];
    vc.hidesBottomBarWhenPushed = YES;
    [container.navigationController pushViewController:vc animated:animated];
    [self callback:block code:MSG_SUCCESS data:nil];
}

- (void)pushNavtiveController:(NSDictionary *)paramDic completion:(WXNavigationResultBlock)block
                withContainer:(UIViewController *)container {
    if (!([paramDic isKindOfClass:[NSDictionary class]])) return;
    NSDictionary *param = paramDic[@"param"];
    Class targetClass = NSClassFromString(param[@"n"]);
    id target = [[targetClass alloc] init];
    if (target == nil) {
        [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
        return;
    } else {
        unsigned int outCount = 0;
        NSMutableArray *keyArray = [NSMutableArray array];
        objc_property_t *propertys = class_copyPropertyList([targetClass class], &outCount);
        for (unsigned int i = 0; i < outCount; i ++) {
            objc_property_t property = propertys[i];
            NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keyArray addObject:propertyName];
        }
        free(propertys);
        
        NSDictionary *parameterDic = param[@"v"];
        if (parameterDic.allKeys.count > 0) {
            NSArray *array = parameterDic.allKeys;
            for (NSInteger i = 0; i < array.count; i++) {
                NSString *key = array[i];
                if ([keyArray containsObject:key]) {
                    [target setValue:parameterDic[key] forKey:key];
                }
            }
        }
        [container.navigationController pushViewController:target animated:YES];
        [self callback:block code:MSG_SUCCESS data:nil];
    }
}

- (UIView *)barButton:(NSDictionary *)param position:(WXNavigationItemPosition)position
        withContainer:(UIViewController *)container
{
    if (param[@"title"]) {
        NSString *title = param[@"title"];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
        CGSize size = [title boundingRectWithSize:CGSizeMake(70.0f, 18.0f) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
        WXNavButton *button = [WXNavButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 0, size.width, size.height);
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor]  forState:UIControlStateHighlighted];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(onClickBarButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.instanceId = param[@"instanceId"];
        button.nodeRef = param[@"nodeRef"];
        button.position = position;
        
        NSString *color = param[@"titleColor"];
        if (color) {
            [button setTitleColor:[WXConvert UIColor:color] forState:UIControlStateNormal];
            [button setTitleColor:[WXConvert UIColor:color] forState:UIControlStateHighlighted];
        }
        
        return button;
    }
    else if (param[@"icon"]) {
        NSString *icon = param[@"icon"];
        
        if (icon) {
            WXNavButton *button = [WXNavButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(0, 0, 25, 25);
            button.instanceId = param[@"instanceId"];
            button.nodeRef = param[@"nodeRef"];
            button.position = position;
            [button addTarget:self action:@selector(onClickBarButton:) forControlEvents:UIControlEventTouchUpInside];
            [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:icon] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                    [button setBackgroundImage:image forState:UIControlStateHighlighted];
                    
                });
            }];
            
            return button;
        }
    }
    
    return nil;
}

- (void)onClickBarButton:(id)sender
{
    WXNavButton *button = (WXNavButton *)sender;
    if (button.instanceId) {
        if (button.nodeRef)
        {
            [[WXSDKManager bridgeMgr] fireEvent:button.instanceId ref:button.nodeRef type:@"click" params:nil domChanges:nil] ;
        }
        else
        {
            NSString *eventType;
            switch (button.position) {
                case WXNavigationItemPositionLeft:
                    eventType = @"clickleftitem";
                    break;
                case WXNavigationItemPositionRight:
                    eventType = @"clickrightitem";
                    break;
                case WXNavigationItemPositionMore:
                    eventType = @"clickmoreitem";
                    break;
                default:
                    break;
            }
            
            [[WXSDKManager bridgeMgr] fireEvent:button.instanceId ref:WX_SDK_ROOT_REF type:eventType params:nil domChanges:nil];
        }
    }
}

- (void)callback:(WXNavigationResultBlock)block code:(NSString *)code data:(NSDictionary *)reposonData {
    if (block) {
        block(code, reposonData);
    }
}

@end
