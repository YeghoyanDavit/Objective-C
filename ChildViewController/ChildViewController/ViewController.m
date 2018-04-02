//
//  ViewController.m
//  ChildViewController
//
//  Created by Davit on 3/31/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import "ViewController.h"
#import "ResultsViewController.h"
#import "RequestManager.h"

@interface ViewController () <ResultsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *markButton;
@property (weak, nonatomic) IBOutlet UIButton *modelButton;
@property (nonatomic) NSMutableArray *marksArray;
@property (nonatomic) NSNumber *modelValue;
@property (nonatomic) BOOL isMarkChosen;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.marksArray = [[NSMutableArray alloc] init];
}

- (IBAction)markButtonClicked {
    ResultsViewController *vc = [[ResultsViewController alloc] init];
    self.view.tag = 1;
    RequestManager *markRequest = [[RequestManager alloc] init];
    [markRequest searchMusicWithTerm:[kBaseUrl stringByAppendingString:kApiUrl] withSuccess:^(id response) {
        //NSLog(@"%@", response);
        for (NSDictionary *dict in response) {
            [self.marksArray addObject:dict];
        }
        vc.dataArray = self.marksArray;
        vc.delegate = self;
        [vc createResultsVC:self];
        vc.resultsTitleLabel.text = @"Marks";
    } withFailure:nil];
}

- (IBAction)modelButtonClicked {
    if (!self.isMarkChosen) {
        [self displayAlert];
    } else {
        ResultsViewController *vc = [[ResultsViewController alloc] init];
        self.view.tag = 2;
        NSMutableArray *markArray = [[NSMutableArray alloc] init];
        RequestManager *modelRequest = [[RequestManager alloc] init];
        [modelRequest searchMusicWithTerm:[kBaseUrl stringByAppendingString:[NSString stringWithFormat:@"/%@/models%@",self.modelValue, kApiUrl]] withSuccess:^(id response) {
            for (NSDictionary *dict in response) {
                [markArray addObject:dict];
            }
            vc.dataArray = markArray;
            vc.delegate = self;
            [vc createResultsVC:self];
            vc.resultsTitleLabel.text = @"Models";
        } withFailure:nil];
    }
}

- (void)setMarkButtonLabel:(NSDictionary *)selectedData {
    if (self.view.tag == 1 && selectedData != nil) {
        [self.markButton setTitle:selectedData[@"name"] forState:UIControlStateNormal];
        self.modelValue = selectedData[@"value"];
        self.isMarkChosen = YES;
    } else if (self.view.tag == 2) {
        [self.modelButton setTitle:selectedData[@"name"] forState:UIControlStateNormal];
    }
}

- (void)displayAlert {
    NSString *title = @"Worning!";
    NSString *message = @"Please select the mark of the car first";
    NSString *okText = @"Ok";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:okText style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
