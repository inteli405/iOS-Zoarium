//
//  Inteli405BookItemStore.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405BookItemStore.h"
#import "Inteli405Book.h"
#import "Inteli405Constant.h"
#import "AFNetworking.h"

@interface Inteli405BookItemStore()
@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation Inteli405BookItemStore

+ (instancetype)sharedStore {
    static Inteli405BookItemStore *sharedStore = nil;
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
        _getOrNot = 0;
    }
    return self;
}

- (NSArray *)allItems {
    return self.privateItems;
}

- (NSInteger)getOrNot {
    return self.getOrNot;
}

- (Inteli405Book *)createItem {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://192.168.199.187/statistic/Book_Borrow/history" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        [self.privateItems removeAllObjects];
        NSLog(@"%@",responseObject);
        NSLog(@"%@",[responseObject class]);
        for (NSMutableDictionary *bookItem in responseObject) {
            NSString *timeStamp = [NSString stringWithFormat:@"%@",[bookItem objectForKey:@"timestamp"]];
            timeStamp = [timeStamp substringToIndex:10];
            NSLog(@"%@",timeStamp);
            Inteli405Book *item = [[Inteli405Book alloc] initWithBookName:[[[bookItem objectForKey:@"book"] objectForKey:@"bookinfo"] objectForKey:@"name"] stateOfBook:BOOK_LENT Time:[NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]] byReader:[[bookItem objectForKey:@"user"] objectForKey:@"name"]];
            
            [self.privateItems addObject:item];
        }
        
        NSLog(@"Get");
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [manager GET:@"http://192.168.199.187/statistic/Book_Borrow/history" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        for (NSMutableDictionary *bookItem in responseObject) {
            NSString *timeStamp = [NSString stringWithFormat:@"%@",[bookItem objectForKey:@"timestamp"]];
            timeStamp = [timeStamp substringToIndex:10];
            NSLog(@"%@",timeStamp);
            Inteli405Book *item = [[Inteli405Book alloc] initWithBookName:[[[bookItem objectForKey:@"book"] objectForKey:@"bookinfo"] objectForKey:@"name"] stateOfBook:BOOK_IN_BOOKCASE Time:[NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]] byReader:[[bookItem objectForKey:@"user"] objectForKey:@"name"]];
            
            [self.privateItems addObject:item];
        }
        
        NSLog(@"Get");
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    return nil;
}
@end
