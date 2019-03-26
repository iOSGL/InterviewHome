//
//  NSString+Code.m
//  WeexDemo
//
//  Created by genglei on 2018/7/16.
//  Copyright © 2018年 taobao. All rights reserved.
//

#import "NSString+Code.h"

@implementation NSString (Code)

+ (NSString *)getStatusStringByCode:(YTKRequest *)request {
    if (!request.responseData) {
        return @"网络错误";
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    NSString *code = nil;
    if (dic == nil) {
        
    } else {
        code = dic[@"code"];
    }
    if ([code isEqualToString:@"200"]) {
        return @"成功";
    }
    if ([code isEqualToString:@"201"]) {
        return @"服务器处理异常";
    }
    if ([code isEqualToString:@"500"]) {
        return @"服务器处理错误";
    }
    
    if ([code isEqualToString:@"1000"]) {
        //请求参数不规范,请参考接口中对应的参数
        return @"请求参数不规范";
    }
    if ([code isEqualToString:@"1001"]) {
        // 当前只支持1.0版本,请输入正确的version值
        return @"当前只支持1.0版本";
    }
    if ([code isEqualToString:@"1002"]) {
        //用户的key 不存在,请输入正确的apikey值
        return @"用户的key 不存在";
    }
    if ([code isEqualToString:@"1003"]) {
        //该url已过期,请重新生成timestamp值
        return @"该url已过期";
    }
    if ([code isEqualToString:@"1004"]) {
        //用户签名无效,请重新申城apisign值
        return @"用户签名无效";
    }
    
    if ([code isEqualToString:@"2000"]) {
        return @"用户不存在!";
    }
    if ([code isEqualToString:@"2001"]) {
        return @"密码有误!";
    }
    if ([code isEqualToString:@"2002"]) {
        return @"手机号格式不对!";
    }
    if ([code isEqualToString:@"2003"]) {
        return @"手机验证码发送失败!";
    }
    if ([code isEqualToString:@"2004"]) {
        return @"验证码有误";
    }
    if ([code isEqualToString:@"2005"]) {
        return @"注册失败";
    }
    if ([code isEqualToString:@"2006"]) {
        return @"该手机号已被注册过";
    }
    if ([code isEqualToString:@"2008"])
    {
        return @"用户没有登录";
    }
    
    if ([code isEqualToString:@"2009"])
    {
        return @"用户没有权限";
    }
    
    if ([code isEqualToString:@"2013"])
    {
        return @"该昵称已经注册过";
    }
    
    return @"网络错误";
}

@end
