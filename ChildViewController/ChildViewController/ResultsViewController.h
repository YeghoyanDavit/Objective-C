//
//  ResultsViewController.h
//  ChildViewController
//
//  Created by Davit on 3/31/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ResultsViewControllerDelegate;

@interface ResultsViewController : UIViewController

@property (weak, nonatomic) id <ResultsViewControllerDelegate> delegate;
@property (nonatomic) NSArray *dataArray;


- (void)createResultsVC:(UIViewController *)veiwController;
@property (weak, nonatomic) IBOutlet UILabel *resultsTitleLabel;

@end

@protocol ResultsViewControllerDelegate

- (void)setMarkButtonLabel:(NSDictionary *)selectedData;

@end
