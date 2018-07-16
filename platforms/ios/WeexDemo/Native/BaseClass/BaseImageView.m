//
//  BaseImageView.m
//  LBYunZhi
//
//  Created by genglei on 2017/1/19.
//  Copyright © 2017年 Astraea尊. All rights reserved.
//

#import "BaseImageView.h"
#import <UIImageView+AFNetworking.h>
#import <UIApplication+YYAdd.h>
#import <UIImage+YYAdd.h>

@implementation BaseImageView

- (void)setImageWithUrl:(NSURL *)url placeholder:(UIImage *)placeholder {
    [self yy_setImageWithURL:url placeholder:placeholder];
}

- (void)setImageWithCornerUrl:(NSURL *)url
                  placeholder:(UIImage *)placeholder {
    [self yy_setImageWithURL:url placeholder:placeholder options:YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        CGFloat scale = [[UIScreen mainScreen] scale];
        return  image = [image yy_imageByRoundCornerRadius:scale * 3 borderWidth:0 borderColor:nil];
        
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
    }];
}

- (void)setImageWithAvatarUrl:(NSURL *)url placeholder:(UIImage *)placeholder{
    [self yy_setImageWithURL:url placeholder:placeholder options:kNilOptions manager:[BaseImageView avatarImageManager] progress:nil transform:nil completion:nil];
}


+ (YYWebImageManager *)avatarImageManager {
    static YYWebImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[UIApplication sharedApplication].cachesPath stringByAppendingPathComponent:@"yunzhi.avatar"];
        YYImageCache *cache = [[YYImageCache alloc]initWithPath:path];
        manager = [[YYWebImageManager alloc]initWithCache:cache queue:[YYWebImageManager sharedManager].queue];
        manager.sharedTransformBlock = ^(UIImage *image, NSURL *url) {
            if (!image) return image;
            return [image imageByRoundCornerRadius:100]; // a large value
        };
    });
    return manager;
}

- (void)setImageWithUrl:(NSURL *)url
            placeholder:(UIImage *)placeholder
             completion:(nullable YYWebImageCompletionBlock)completion {
    
    [self yy_setImageWithURL:url placeholder:placeholder options:YYWebImageOptionShowNetworkActivity completion:completion];
}
@end
