//
//  Inteli405Reader.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405Reader.h"
#import "Inteli405Constant.h"

@implementation Inteli405Reader

- (instancetype)initWithReaderName:(NSString *)name stateOfReader:(NSInteger)state{
    self.readerName   = name;
    self.stateOfReader= state;
    switch (self.stateOfReader) {
        case IN_405:
            self.stateOfReaderStr = @"在405";
            break;
        case NOT_IN_405:
            self.stateOfReaderStr = @"不在405";
            break;
        default:
            break;
    }
    return self;
}
@end
