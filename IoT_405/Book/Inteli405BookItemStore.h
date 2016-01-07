//
//  Inteli405BookItemStore.h
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Inteli405Book;

@interface Inteli405BookItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;
@property (nonatomic)NSInteger getOrNot;
+ (instancetype)sharedStore;
- (Inteli405Book *)createItem;
@end
