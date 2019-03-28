//
//  WXDatabase.m
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import "WXDatabase.h"

@interface WXDatabase ()

@property (nonatomic , strong, readonly) FMDatabase *db;

@end

@implementation WXDatabase

- (instancetype)init {
    self = [super init];
    if (self) {
//        _db = [FMDatabase databaseWithPath:DB_SANDBOX_TABLE];
        _db = [FMDatabase databaseWithURL:[NSURL URLWithString:DB_RESOURCE_TABLE]];
    }
    return self;
}

- (void)createAllSubjectTable {
    NSString *table =  @"CREATE TABLE IF NOT EXISTS Subjects_Table (s_id integer PRIMARY KEY AUTOINCREMENT NOT NULL,_id varchar(128),content varchar(128),groupId varchar(128), totalNum integer, unlockTotal integer)";
    if ([_db open]) {
        BOOL sucess = [_db executeStatements:table];
        if (sucess) {
            NSLog(@"sucess  %@",DB_SANDBOX_TABLE);
        } else {
            NSLog(@"faile  %@",DB_SANDBOX_TABLE);
        }
        [_db close];
    }
}

- (void)createAllClassTable {
    NSString *table =  @"CREATE TABLE IF NOT EXISTS Class_Table (c_id integer PRIMARY KEY AUTOINCREMENT NOT NULL,s_id integer(20) NOT NULL,pageID varchar(128),showContent varchar(128),integral integer(20),title varchar(128), questcount integer(128))";
    if ([_db open]) {
        BOOL sucess = [_db executeStatements:table];
        if (sucess) {
            NSLog(@"sucess  %@",DB_SANDBOX_TABLE);
        } else {
            NSLog(@"faile  %@",DB_SANDBOX_TABLE);
        }
        [_db close];
    }
}

- (void)createQuestionsTable {
    NSString *table =  @"CREATE TABLE IF NOT EXISTS Questions_Table (q_id integer PRIMARY KEY AUTOINCREMENT NOT NULL,_id varchar(128),questionTitle varchar(128),classId varchar(128),isCollection integer,answer varchar(128),author varchar(128),createTime varchar(128), number integer)";
    if ([_db open]) {
        BOOL sucess = [_db executeStatements:table];
        if (sucess) {
            NSLog(@"sucess  %@",DB_SANDBOX_TABLE);
        } else {
            NSLog(@"faile  %@",DB_SANDBOX_TABLE);
        }
        [_db close];
    }
}

- (void)insertSubjects:(NSArray *)subjects {
    if (!subjects.count) {
        return;
    }
    if ([_db open]) {
        [subjects enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger index, BOOL * _Nonnull stop) {
            [self->_db beginTransaction];
            BOOL isRollBack = NO;
            @try {
                NSString *_id = obj[@"_id"];
                NSString *groupId = obj[@"groupId"];
                NSString *content = obj[@"content"];
                NSArray *pageList = obj[@"pageList"];
                NSInteger totalNum = pageList.count;
                NSInteger unlockTotal = totalNum;
                [pageList enumerateObjectsUsingBlock:^(NSDictionary *pageDic, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *pageID = pageDic[@"pageID"];
                    NSString *showContent = pageDic[@"showContent"];
                    NSString *title = pageDic[@"title"];
                    NSInteger integral = [pageDic[@"integral"] integerValue];
                    
                    FMResultSet *countSet = [self->_db executeQuery:@"select * from Questions_Table where classId = ?", pageID];
                    NSInteger count = 0;
                    while ([countSet next]) {
                        count ++;
                    }
                    NSInteger questcount = count;
                    [self->_db executeUpdate:@"insert into Class_Table(s_id, pageID, showContent, integral, title, questcount) values (?, ?, ?, ?, ?, ?)", @(index + 1), pageID, showContent, @(integral), title, @(questcount)];
                }];
                
               [self->_db executeUpdate:@"insert into Subjects_Table(_id, content, groupId, totalNum, unlockTotal) values (?, ?, ?, ?, ?)", _id, content, groupId, @(totalNum), @(unlockTotal)];
                
            } @catch (NSException *exception) {
                isRollBack = true;
                [self->_db rollback];
            } @finally {
                if (!isRollBack) {
                    [self->_db commit];
                }
            }
        }];
        
        [_db close];
    }
    
}

- (void)insertAllQuestions:(NSArray *)questions {
    if (!questions.count) {
        return;
    }
    if ([_db open]) {
        NSInteger num = 1;
        NSMutableDictionary *recodDic = [NSMutableDictionary dictionary];
        for (NSInteger i = 0; i < questions.count; i ++) {
            @autoreleasepool {
                [_db beginTransaction];
                BOOL isRollBack = NO;
                @try {
                    NSDictionary *obj = questions[i];
                    NSString *_id = obj[@"_id"];
                    NSString *questionTitle = obj[@"questionTitle"];
                    NSString *classId = obj[@"classId"];
                    NSInteger isCollection = [obj[@"isCollection"] integerValue];
                    NSString *answer = obj[@"answer"];
                    NSString *author = obj[@"author"];
                    NSString *createTime = obj[@"createTime"];
                    
                    if (recodDic[classId]) {
                        num = [recodDic[classId] integerValue];
                        num++;
                    } else {
                        num = 1;
                    }
                    [recodDic setObject:@(num) forKey:classId];
                    [_db executeUpdate:@"insert into Questions_Table(_id, questionTitle, classId, isCollection, answer, author, createTime, number) values (?, ?, ?, ?, ?, ?, ?, ?)", _id, questionTitle, classId, @(isCollection), answer, author, createTime, @(num)];
            
                } @catch (NSException *exception) {
                    isRollBack = true;
                    [self->_db rollback];
                } @finally {
                    if (!isRollBack) {
                        [self->_db commit];
                    }
                }
            }
        }
    }
    
}

- (NSArray *)seletAllSubjects {
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:@"select * from Subjects_Table"];
        while ([set next]) {
            NSInteger s_id = [set intForColumn:@"s_id"];
            NSMutableArray *pageList = [NSMutableArray array];
            FMResultSet *childSet = [_db executeQuery:@"select *from Class_Table where s_id=?", @(s_id)];
            while ([childSet next]) {
                NSString *pageID = [childSet stringForColumn:@"pageID"];
                NSDictionary *pageDic = @{
                                          @"c_id": @([childSet intForColumn:@"c_id"]),
                                          @"s_id": @([childSet intForColumn:@"s_id"]),
                                          @"pageID": pageID,
                                          @"showContent": [childSet stringForColumn:@"showContent"],
                                          @"integral": @([childSet intForColumn:@"integral"]),
                                          @"title": [childSet stringForColumn:@"title"],
                                          @"questcount": @([childSet intForColumn:@"questcount"])
                                          };
                [pageList addObject:pageDic];
            }
            
            NSDictionary *dic = @{
                                  @"s_id": @(s_id),
                                  @"_id": [set stringForColumn:@"_id"],
                                  @"content": [set stringForColumn:@"content"],
                                  @"groupId": [set stringForColumn:@"groupId"],
                                  @"pageList": pageList,
                                  @"totalNum": @([set intForColumn:@"totalNum"]),
                                  @"unlockTotal": @([set intForColumn:@"unlockTotal"])
                                  };
            [array addObject:dic];
        }
    }
    [_db close];
    
    return [array copy];
}

- (NSArray *)selectQuestionsWithClassID:(NSString *)classID {
    NSMutableArray *array = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:@"select * from Questions_Table where classId = ?", classID];
        while ([set next]) {
            NSDictionary *dic = @{
                                   @"q_id": @([set intForColumn:@"q_id"]),
                                   @"_id": [set stringForColumn:@"_id"],
                                   @"questionTitle": [set stringForColumn:@"questionTitle"],
                                   @"classId": [set stringForColumn:@"classId"],
                                   @"isCollection": @([set intForColumn:@"isCollection"]),
                                   @"answer": [set stringForColumn:@"answer"],
                                   @"author": [set stringForColumn:@"author"],
                                   @"createTime": [set stringForColumn:@"createTime"],
                                   @"number": @([set intForColumn:@"number"]),
                                  };
            [array addObject:dic];
        }
    }
    [_db close];
    
    return [array copy];
}

- (NSDictionary *)selectQuestionDetail:(NSString *)questionID classID:(NSString *)classID {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([_db open]) {
        NSString *sql = [NSString stringWithFormat:@"select * from Questions_Table where classId = %@ and number = %@", classID, questionID];
        FMResultSet *set = [_db executeQuery:sql];
        while ([set next]) {
            
            FMResultSet *childSet = [_db executeQuery:@"select content from Subjects_Table where s_id in (select s_id from Class_Table where pageID = ?)", classID];
            NSString *className = nil;
            if ([childSet next]) {
                className = [childSet stringForColumn:@"content"];
            }
            [dic setObject:PARAM_IS_NIL_ERROR(className) forKey:@"className"];
            [dic setObject:@([set intForColumn:@"isCollection"]) forKey:@"isCollection"];
            [dic setObject:[set stringForColumn:@"questionTitle"] forKey:@"questionTitle"];
            [dic setObject:[set stringForColumn:@"answer"] forKey:@"answer"];
            [dic setObject:[set stringForColumn:@"classId"] forKey:@"classId"];
            [dic setObject:@([set intForColumn:@"number"]) forKey:@"number"];
        }
    }
    [_db close];
    return [dic copy];
}

@end
