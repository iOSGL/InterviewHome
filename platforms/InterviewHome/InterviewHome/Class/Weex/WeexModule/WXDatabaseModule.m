//
//  WXDatabaseModule.m
//  InterviewHome
//
//  Created by genglei on 2019/3/27.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "WXDatabaseModule.h"
#import "WXDBManger.h"

@implementation WXDatabaseModule

WX_EXPORT_METHOD(@selector(selectAllSubjects:))
WX_EXPORT_METHOD(@selector(selectQuestionsWithClassID:callBack:))
WX_EXPORT_METHOD(@selector(selectQuestionDetailWithClassID:index:callBack:))

- (void)selectAllSubjects:(WXKeepAliveCallback)callbak {
    NSArray *array = [[WXDBManger database]seletAllSubjects];
    if (callbak) {
        callbak(array, false);
    }
}

- (void)selectQuestionsWithClassID:(NSString *)classID callBack:(WXKeepAliveCallback)callback  {
    NSArray *array = [[WXDBManger database] selectQuestionsWithClassID:classID];
    if (callback) {
        callback(array, false);
    }
}

- (void)selectQuestionDetailWithClassID:(NSString *)classID index:(NSString *)number callBack:(WXKeepAliveCallback)callback {
    if (callback) {
        callback([[WXDBManger database]selectQuestionDetail:number classID:classID], false);
    }
}


@end
