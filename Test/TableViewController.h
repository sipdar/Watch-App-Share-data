//
//  TableViewController.h
//  Test
//
//  Created by Zhao Guang on 3/17/15.
//  Copyright (c) 2015 askem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModel;

@interface TableViewController : UITableViewController
@property (nonatomic,readonly) DataModel *dataModel;
@end
