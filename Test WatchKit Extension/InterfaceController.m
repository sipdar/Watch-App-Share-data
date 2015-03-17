//
//  InterfaceController.m
//  Test WatchKit Extension
//
//  Created by Zhao Guang on 3/16/15.
//  Copyright (c) 2015 askem. All rights reserved.
//

#import "InterfaceController.h"
#import "DataModel.h"
#import "WKRowItem.h"
@interface InterfaceController()<DataModelChangedDelegate>
@property (weak, nonatomic) IBOutlet WKInterfaceTable *tableView;
@property (nonatomic, strong) DataModel *dataModel;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.dataModel = [[DataModel alloc] init];
    self.dataModel.delege = self;
    [self loadTable];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)textInputButtonPressed {
    __weak typeof(self) weakSelf = self;
    [self presentTextInputControllerWithSuggestions:@[@"suggestion",@"Test",@"Input"]
                                   allowedInputMode:WKTextInputModeAllowAnimatedEmoji
                                         completion:^(NSArray *results) {
                                             __strong typeof(weakSelf) strongSelf = weakSelf;
                                             if (strongSelf) {
                                                 [_dataModel appendWith:results.firstObject];
                                                 [strongSelf loadTable];
                                                 [WKInterfaceController openParentApplication:@{@"update":@"update"} reply:^(NSDictionary *replyInfo, NSError *error) {
                                                 }];
                                             }
    }];
}

-(void)loadTable {
    [self.tableView setNumberOfRows:[_dataModel.items count] withRowType:@"ItemCell"];
    [_dataModel.items enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        WKRowItem *rowItem = [_tableView rowControllerAtIndex:idx];
        [rowItem.label setText:obj];
    }];
}

-(void)dataModelDidChanged {
    [self loadTable];
}
@end



