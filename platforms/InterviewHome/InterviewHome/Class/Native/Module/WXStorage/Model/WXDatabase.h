//
//  WXDatabase.h
//  InterviewHome
//
//  Created by genglei on 2019/3/26.
//  Copyright © 2019年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <fmdb/FMDB.h>

@interface WXDatabase : NSObject
 
- (void)createAllSubjectTable;

- (void)createAllClassTable;

- (void)createQuestionsTable;

- (void)insertSubjects:(NSArray *)subjects;

- (void)insertAllQuestions:(NSArray *)questions;

- (NSArray *)seletAllSubjects;

- (NSArray *)selectQuestionsWithClassID:(NSString *)classID;

- (NSDictionary *)selectQuestionDetail:(NSString *)questionID classID:(NSString *)classID;

- (NSInteger)updateCollection:(NSString *)questionID  classID:(NSString *)classID status:(NSInteger)status;

- (NSArray *)selectAllCollertion;

@end


