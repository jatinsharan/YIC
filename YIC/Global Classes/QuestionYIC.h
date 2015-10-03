//
//  QuestionYIC.h
//  YIC
//
//  Created by Jatin on 10/2/15.
//
//

#import <Foundation/Foundation.h>

@interface QuestionYIC : NSObject
@property (assign, nonatomic) int qId;
@property (strong, nonatomic) NSString* qSection;
@property (strong, nonatomic) NSString* qLevel;
@property (strong, nonatomic) NSString* qInstruction;
@property (strong, nonatomic) NSString* qQuestion;
@property (strong, nonatomic) NSString* qOption_1;
@property (strong, nonatomic) NSString* qOption_2;
@property (strong, nonatomic) NSString* qOption_3;
@property (strong, nonatomic) NSString* qOption_4;
@property (strong, nonatomic) NSString* qCorrectOption;
@property (assign, nonatomic) int qMarks;
@end
