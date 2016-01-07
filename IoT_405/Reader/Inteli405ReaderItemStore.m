//
//  Inteli405ReaderItemStore.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405ReaderItemStore.h"
#import "Inteli405Reader.h"
#import "Inteli405Constant.h"

@interface Inteli405ReaderItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation Inteli405ReaderItemStore

+ (instancetype)sharedStore {
    static Inteli405ReaderItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

- (instancetype)init {
    @throw [NSException exceptionWithName:@"Singletom" reason:@"Use +[Inteli405BookItemStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (Inteli405Reader *)createItem {
    Inteli405Reader *item = [[Inteli405Reader alloc] initWithReaderName:@"Zhang San" stateOfReader:IN_405];
    [self.privateItems addObject:item];
    return item;
}

@end
