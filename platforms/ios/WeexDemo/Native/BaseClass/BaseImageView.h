//
//  BaseImageView.h
//  LBYunZhi
//
//  Created by genglei on 2017/1/19.
//  Copyright © 2017年 Astraea尊. All rights reserved.
//

#import <YYWebImage/YYWebImage.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BaseImageView : YYAnimatedImageView

/**
 设置图片

 @param url 链接
 @param placeholder 默认图片
 */
- (void)setImageWithUrl:(NSURL *)url
            placeholder:(UIImage *)placeholder;

/**
 设置圆角图片

 @param url 链接
 @param placeholder 默认图片
 */
- (void)setImageWithCornerUrl:(NSURL *)url
                  placeholder:(UIImage *)placeholder;

/**
 设置头像 做头像特殊处理

 @param url url 链接
 @param placeholder 默认图片
 */
- (void)setImageWithAvatarUrl:(NSURL *)url
                  placeholder:(UIImage *)placeholder;

/**
 头像设置相关

 @return 圆角头像的 manager
 */
+ (YYWebImageManager *)avatarImageManager;

/**
 设置图片
 
 @param url 链接
 @param placeholder 默认图片
 @param completion 图片加载完成回调
 */
- (void)setImageWithUrl:(NSURL *)url
            placeholder:(UIImage *)placeholder
             completion:(nullable YYWebImageCompletionBlock)completion;

/**
 图片附带内容  扩展使用
 */
@property (nonatomic , strong) id Parameter;

@end
