//
//  UploadImageApi.h
//  WeexDemo
//
//  Created by genglei on 2018/8/13.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "BaseRequest.h"

@interface UploadImageApi : BaseRequest

- (id)initWithImage:(UIImage *)image userID:(NSString *)userID;

@end
