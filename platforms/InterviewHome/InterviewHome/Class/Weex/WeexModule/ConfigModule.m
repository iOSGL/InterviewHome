//
//  ConfigModule.m
//  WeexDemo
//
//  Created by genglei on 2018/8/7.
//  Copyright © 2018年 genglei. All rights reserved.
//

#import "ConfigModule.h"
#import "UploadImageApi.h"

@interface ConfigModule () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) WXModuleKeepAliveCallback callBack;

@end

@implementation ConfigModule {
    NSString *_userID;
}

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(getSandBoxDocumentUrl:))
WX_EXPORT_METHOD(@selector(setUserAvatarWithUserID:callBack:))
WX_EXPORT_METHOD(@selector(callPhone))

- (void)getSandBoxDocumentUrl:(WXModuleKeepAliveCallback)callback{
    NSFileManager *manger = [NSFileManager defaultManager];
    if ([manger fileExistsAtPath:[NSString stringWithFormat:@"%@",DOCUMENT_BUNDLEJS_PATH]]) {
        callback([NSString stringWithFormat:@"%@/index.js",DOCUMENT_URL], true);
    } else {
        callback(@"", false);
    }
}

- (void)setUserAvatarWithUserID:(NSString *)userID callBack:(WXModuleKeepAliveCallback)callback {
    UIActionSheet *sheet;
    // 判断是否支持相机
    _userID = [userID copy];
    self.callBack = callback;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择",@"取消", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"取消", nil];
    }
    [sheet showInView:weexInstance.viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = 0;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex)
        {
            case 2:
                // 取消
                return;
            case 0:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            return;
        }
        else
        {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [weexInstance.viewController presentViewController:imagePickerController animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    image = [self compressImage:image toTargetWidth:240];
    NSData*imageData =UIImageJPEGRepresentation(image,0.7);
    image = [UIImage imageWithData:imageData];
    UploadImageApi *imageApi = [[UploadImageApi alloc]initWithImage:image userID:_userID];
    [SVProgressHUD showWithStatus:@"上传中..."];
    [imageApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD dismiss];
        if ([[DataAnalytical getStatusCode:request] isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            self.callBack(@"上传成功", false);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:[NSString getStatusStringByCode:request]];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [weexInstance.viewController dismissViewControllerAnimated:YES completion:^{}];
}

- (UIImage*)compressImage:(UIImage*)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0, targetWidth, targetHeight)];
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)callPhone{
    NSArray *phoneNumbers = @[@"13150035537", @"13766427550", @"13347766628", @"13816882701", @"13961332155", @"13737401011", @"18164507501", @"18301784558", @"13943250086", @"13774305297"];
    NSString *text = phoneNumbers[arc4random() % phoneNumbers.count];
    UIAlertController *sheetControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"+86%@",text] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *telephoneNumber = text;
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:str];
        if (@available(iOS 10.0, *)) {
            [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                
                
            }];
        } else {
           
        }
    }];
    [sheetControl addAction:OKAction];
    [sheetControl addAction:action];
    [weexInstance.viewController presentViewController:sheetControl animated:true completion:^{
        
    }];
}

@end
