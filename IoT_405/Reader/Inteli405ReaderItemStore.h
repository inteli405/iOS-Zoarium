//
//  Inteli405ReaderItemStore.h
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class inteli405Reader;

@interface Inteli405ReaderItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;
+ (instancetype)sharedStore;
- (inteli405Reader *)createItem;

@end
