//
//  Inteli405Book.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405Book.h"
#import "Inteli405Constant.h"

@implementation Inteli405Book

- (instancetype)initWithBookName:(NSString *)name stateOfBook:(NSInteger)state Time:(NSDate *)timeS byReader:(NSString *)readerName{
    self.bookName   = name;
    self.stateOfBook= state;
    self.time = timeS;
    self.name = readerName;
    switch (self.stateOfBook) {
        case BOOK_IN_BOOKCASE:
            self.stateOfBookStr = @"归还";
            break;
        case BOOK_LENT:
            self.stateOfBookStr = @"借出";
            break;
        case BOOK_TAKEN_OUT:
            self.stateOfBookStr = @"带出";
            break;
        default:
            break;
    }
    return self;
}
@end
