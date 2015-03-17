//
//  DataModel.h
//  Test
//
//  Created by Zhao Guang on 3/17/15.
//  Copyright (c) 2015 askem. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol DataModelChangedDelegate <NSObject>

-(void)dataModelDidChanged;

@end

@interface DataModel : NSObject
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) id <DataModelChangedDelegate> delege;
-(void)appendWith:(NSString *)string;
-(void)removeItemAt:(NSInteger)index;
-(void)refreshData;
@end
