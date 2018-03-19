//
//  ViewController.m
//  Alias
//
//  Created by Davit on 3/7/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import "ViewController.h"
#import "Setup.h"

@interface ViewController ()

@property (strong, nonatomic) Setup *setupView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupView = [[Setup alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.setupView];
    
    
}



@end
