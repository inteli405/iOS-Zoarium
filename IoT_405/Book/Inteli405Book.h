//
//  Inteli405Book.h
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Inteli405Book : NSObject

@property (nonatomic,strong) NSString *bookName;
@property NSInteger stateOfBook;
@property (nonatomic)NSString *stateOfBookStr;
@property (nonatomic)NSDate *time;
@property (nonatomic)NSString *name;

- (instancetype)initWithBookName:(NSString *)name stateOfBook:(NSInteger)state Time:(NSDate *)timeS byReader:(NSString *)readerName;
@end
