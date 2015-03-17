//
//  TableViewController.m
//  Test
//
//  Created by Zhao Guang on 3/17/15.
//  Copyright (c) 2015 askem. All rights reserved.
//

#import "TableViewController.h"
#import "DataModel.h"
@interface TableViewController ()<DataModelChangedDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (nonatomic, strong) DataModel *dataModel;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataModel = [[DataModel alloc] init];
    self.dataModel.delege = self;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataModel.items removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataModel.items[indexPath.row];
    return cell;
}

- (IBAction)creatItem:(UITextView *)sender {
}

- (IBAction)editEnd:(id)sender {
    [self.textView resignFirstResponder];
    [_dataModel appendWith:_textView.text];
    _textView.text = nil;
}

-(void)dataModelDidChanged{
    [self.tableView reloadData];
}

@end
