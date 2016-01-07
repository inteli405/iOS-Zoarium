//
//  Inteli405Reader.h
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Inteli405Reader : NSObject
@property (nonatomic,strong) NSString *readerName;
@property NSInteger stateOfReader;
@property (nonatomic)NSString *stateOfReaderStr;

- (instancetype)initWithReaderName:(NSString *)name stateOfReader:(NSInteger)state;
@end
