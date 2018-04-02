//
//  ResultsViewController.m
//  ChildViewController
//
//  Created by Davit on 3/31/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSDictionary *selectedRowData;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end


@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClicked:)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

- (void)createResultsVC:(UIViewController *)veiwController {
    [veiwController addChildViewController:self];
    [veiwController.view addSubview:self.view];
    self.view.frame = veiwController.view.frame;
}

- (void)deleteResultsVC {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self deleteResultsVC];
}

- (IBAction)doneButtonClicked:(id)sender {
    [self.delegate setMarkButtonLabel:self.selectedRowData];
    [self deleteResultsVC];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.mainView]) {
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row][@"name"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRowData = self.dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end



