//
//  DataModel.m
//  Test
//
//  Created by Zhao Guang on 3/17/15.
//  Copyright (c) 2015 askem. All rights reserved.
//

#import "DataModel.h"

@interface DataModel ()
@property (nonatomic, strong) NSUserDefaults *defaults;
@end

@implementation DataModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadItems];
        [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            NSLog(@"[note userInfo] == %@",[note userInfo]);
        }];
    }
    return self;
}

-(void)loadItems {
    _defaults =[[NSUserDefaults alloc] initWithSuiteName:@"group.com.test.DataSharing"];
    _items = [_defaults objectForKey:@"Items"];
    if (!_items) {
        _items =[NSMutableArray array];
    }
}

-(void)appendWith:(NSString *)string{
    [_items addObject:string];
    [self save];
}

-(void)removeItemAt:(NSInteger)index{
    [_items removeObjectAtIndex:index];
    [self save];
}

-(void)save {
    [_defaults setObject:_items forKey:@"Items"];
    [self.delege dataModelDidChanged];
}

-(void)refreshData{
    [self loadItems];
    [self.delege dataModelDidChanged];
}


@end
