//
//  UploadImageApi.m
//  WeexDemo
//
//  Created by genglei on 2018/8/13.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "UploadImageApi.h"
#import <AFNetworking.h>


@implementation UploadImageApi {
    NSString *_userID;
    UIImage *_upImage;
}

- (id)initWithImage:(UIImage *)image userID:(NSString *)userID {
    self = [super init];
    if (self) {
        _upImage = image;
        _userID = [userID copy];
    }
    return self;
}

- (id)requestArgument {
    return @{
             @"userID":PARAM_IS_NIL_ERROR(_userID)
             };
}

- (NSString *)requestUrl {
    return @"https://www.mianshihome.com:8080/mianshi/rest/userbase/upLoadPic";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}


- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_upImage, 1);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
    };
}

@end
