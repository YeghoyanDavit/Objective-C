//
//  Setup.m
//  Alias
//
//  Created by Davit on 3/7/18.
//  Copyright © 2018 DavitYeghoyan. All rights reserved.
//

#import "Setup.h"

@interface Setup ()

@property (nonatomic) NSArray *arrayOfColors;
@property (nonatomic) NSArray *buttonsNamesArray;
@property (nonatomic) NSMutableArray *scrollViewButtonsArray;
@property (nonatomic) NSMutableArray *scrollViewViewsArray;
@property (nonatomic) NSMutableArray *textFieldsArray;
@property (weak, nonatomic) UIScrollView *topScrollView;
@property (weak, nonatomic) UIScrollView *bottomScrollView;
@property (weak, nonatomic) UIScrollView *textFieldsScrollView;
@property (weak, nonatomic) UILabel *scoreLabel;
@property (weak, nonatomic) UILabel *timeLabel;
@property (weak, nonatomic) UIView *mainView;
@property (weak, nonatomic) UITextField *activeField;


@end

@implementation Setup

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:254.0/255.0 green:248.0/255.0 blue:239.0/255.0 alpha:1];
        self.arrayOfColors = [self createArrayOfColors];
        self.textFieldsArray = [[NSMutableArray alloc] init];
        self.buttonsNamesArray = @[@"Միավորներ", @"Տևողություն", @"Խմբեր"];
        [self createMainView];
    }
    return self;
}

// Creates array of colors
- (NSArray *)createArrayOfColors {
    UIColor *firstColor = [UIColor colorWithRed:254.0/255.0 green:224.0/255.0 blue:196/255.0 alpha:1];
    UIColor *secondColor = [UIColor colorWithRed:249.0/255.0 green:221.0/255.0 blue:167/255.0 alpha:1];
    UIColor *thirdColor = [UIColor colorWithRed:251.0/255.0 green:225.0/255.0 blue:180/255.0 alpha:1];
    
    return @[firstColor, secondColor, thirdColor];
}

#pragma mark - creates views

// Creates main view
- (void)createMainView {
    CGRect mainViewFrame = CGRectMake(10, 120, self.bounds.size.width - 20 , self.bounds.size.height - 240);
    UIView *mainView = [[UIView alloc] initWithFrame:mainViewFrame];
    mainView.center = self.center;
    mainView.layer.cornerRadius = 8;
    self.mainView = mainView;
    [self addSubview:mainView];
    [self createTopScrollView];
    [self createBottomScrollView];
    [self createViewsAndButtonsOfScrollView];
}

// Creates top scroll view
- (void)createTopScrollView {
    CGRect topScrollViewFrame = CGRectMake(0, 0, self.mainView.bounds.size.width, 60);
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:topScrollViewFrame];
    topScrollView.backgroundColor = [UIColor whiteColor];
    topScrollView.contentSize = CGSizeMake(topScrollView.bounds.size.width * 1.5, topScrollView.bounds.size.height);
    [topScrollView  setPagingEnabled:YES];
    self.topScrollView = topScrollView;
    [self.mainView addSubview:topScrollView];
}

// Creates bottom scroll view
- (void)createBottomScrollView {
    CGRect bootomScrollViewFrame = CGRectMake(0, 60, self.mainView.bounds.size.width, self.mainView.bounds.size.height - 60);
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:bootomScrollViewFrame];
    bottomScrollView.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:224.0/255.0 blue:196.0/255.0 alpha:1];
    bottomScrollView.contentSize = CGSizeMake(bottomScrollView.bounds.size.width * 3, bottomScrollView.bounds.size.height);
    [bottomScrollView  setPagingEnabled:YES];
    self.bottomScrollView = bottomScrollView;
    [self.mainView addSubview:bottomScrollView];
}

// Creates views and buttons in scroll views
- (void)createViewsAndButtonsOfScrollView {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.mainView.bounds.size.width;
    CGFloat h = self.mainView.bounds.size.height - 60;
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.mainView.bounds.size.width / 2.8;
    CGFloat buttonH = self.topScrollView.bounds.size.height;
    
    for (int i = 0; i < 3; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        view.backgroundColor = self.arrayOfColors[i];
        view.tag = i + 1;
        [self.scrollViewViewsArray addObject:view];
        [self.bottomScrollView addSubview:view];
        x += w;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button setTitle:self.buttonsNamesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = i + 1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewButtonsArray addObject:button];
        [self.topScrollView addSubview:button];
        buttonX += buttonW;
    }
    [self createSubviewsInFirstView];
}

// Creates subviews in views of scroll view
- (void)createSubviewsInFirstView {
// Creates subviews in second view in of scroll view
    CGFloat labelX = 0;
    CGFloat labelY = 10;
    CGFloat labelW = self.topScrollView.bounds.size.width;
    CGFloat labelH = 60;
    CGRect labelFrame = CGRectMake(labelX, labelY, labelW, labelH);
    
    UILabel *labelOfPointsPage = [[UILabel alloc] initWithFrame:labelFrame];
    [labelOfPointsPage setText:@"Քանի՞ միավոր է պետք հավաքել հաղթող ճանաչվելու համար"];
    [labelOfPointsPage setTextColor:[UIColor blackColor]];
    labelOfPointsPage.numberOfLines = 2;
    labelOfPointsPage.textAlignment = NSTextAlignmentCenter;
    [self.bottomScrollView.subviews[0] addSubview:labelOfPointsPage];
    
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = 160;
    CGFloat viewH = 160;
    CGRect viewFrame = CGRectMake(viewX, viewY, viewW, viewH);
    UIView *viewForPoints = [[UIView alloc] initWithFrame:viewFrame];
    viewForPoints.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:193.0/255.0 blue:66.0/255.0 alpha:1];
    viewForPoints.layer.cornerRadius = viewW / 2;
    viewForPoints.center = self.bottomScrollView.subviews[0].center;
    [self.bottomScrollView.subviews[0] addSubview:viewForPoints];
    
    CGFloat scoreLabelX = 0;
    CGFloat scoreLabelY = 0;
    CGFloat scoreLabelW = 60;
    CGFloat scoreLabelH = 40;
    CGRect scoreLabelFrame = CGRectMake(scoreLabelX, scoreLabelY, scoreLabelW, scoreLabelH);
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:scoreLabelFrame];
    scoreLabel.text = @"100";
    scoreLabel.textColor = [UIColor grayColor];
    [scoreLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    scoreLabel.center = self.bottomScrollView.subviews[0].center;
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomScrollView.subviews[0] addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    
    CGFloat btn1X = 0;
    CGFloat btn1Y = 100;
    CGFloat btn1W = 64;
    CGFloat btn1H = 64;
    CGRect btn1Frame = CGRectMake(btn1X, btn1Y, btn1W, btn1H);
    UIButton *btn1 = [[UIButton alloc] initWithFrame:btn1Frame];
    btn1.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:157.0/255.0 blue:62.0/255.0 alpha:1];
    [btn1 setTitle:@"-" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    btn1.layer.cornerRadius = btn1W / 2;
    [viewForPoints addSubview:btn1];
    [btn1 addTarget:self action:@selector(decreaseScore:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat btn2X = 100;
    CGFloat btn2Y = 100;
    CGFloat btn2W = 64;
    CGFloat btn2H = 64;
    CGRect btn2Frame = CGRectMake(btn2X, btn2Y, btn2W, btn2H);
    UIButton *btn2 = [[UIButton alloc] initWithFrame:btn2Frame];
    btn2.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:157.0/255.0 blue:62.0/255.0 alpha:1];
    [btn2 setTitle:@"+" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    btn2.layer.cornerRadius = btn2W / 2;
    [viewForPoints addSubview:btn2];
    [btn2 addTarget:self action:@selector(increaseScore:) forControlEvents:UIControlEventTouchUpInside];
    
// Creates subviews in second view in of scroll view
    UILabel *labelOfTimePage = [[UILabel alloc] initWithFrame:labelFrame];
    [labelOfTimePage setText:@"Քանի՞ վայրկյան լինի մեկ փուլի տևողությունը"];
    [labelOfTimePage setTextColor:[UIColor blackColor]];
    labelOfTimePage.numberOfLines = 2;
    labelOfTimePage.textAlignment = NSTextAlignmentCenter;
    [self.bottomScrollView.subviews[1] addSubview:labelOfTimePage];
    
    UIView *viewForTime = [[UIView alloc] initWithFrame:CGRectMake(self.bottomScrollView.bounds.size.width / 2 - 80, self.bottomScrollView.bounds.size.height / 2 - 80, 160, 160)];
    viewForTime.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:193.0/255.0 blue:66.0/255.0 alpha:1];
    viewForTime.layer.cornerRadius = viewW / 2;
    [self.bottomScrollView.subviews[1] addSubview:viewForTime];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:scoreLabelFrame];
    timeLabel.text = @"45";
    timeLabel.textColor = [UIColor grayColor];
    [timeLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    timeLabel.center = viewForTime.center;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomScrollView.subviews[1] addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:btn1Frame];
    btn3.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:157.0/255.0 blue:62.0/255.0 alpha:1];
    [btn3 setTitle:@"-" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3.titleLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    btn3.layer.cornerRadius = btn1W / 2;
    [viewForTime addSubview:btn3];
    [btn3 addTarget:self action:@selector(decreaseTime:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:btn2Frame];
    btn4.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:157.0/255.0 blue:62.0/255.0 alpha:1];
    [btn4 setTitle:@"+" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4.titleLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    btn4.layer.cornerRadius = btn2W / 2;
    [viewForTime addSubview:btn4];
    [btn4 addTarget:self action:@selector(increaseTime:) forControlEvents:UIControlEventTouchUpInside];
    
// Creates subviews in third view in of scroll view
    UILabel *labelOfGroupsPage = [[UILabel alloc] initWithFrame:labelFrame];
    [labelOfGroupsPage setText:@"Լրացրեք խմբերի անունները"];
    [labelOfGroupsPage setTextColor:[UIColor blackColor]];
    labelOfGroupsPage.numberOfLines = 2;
    labelOfGroupsPage.textAlignment = NSTextAlignmentCenter;
    [self.bottomScrollView.subviews[2] addSubview:labelOfGroupsPage];
    
    UIScrollView *textFieldsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.bottomScrollView.bounds.size.width * 2, 100, self.bottomScrollView.bounds.size.width, 260)];
    textFieldsScrollView.contentSize = CGSizeMake(textFieldsScrollView.bounds.size.width, textFieldsScrollView.bounds.size.height + 20);
    //textFieldsScrollView.backgroundColor = [UIColor blueColor];
    self.textFieldsScrollView = textFieldsScrollView;
    [self.bottomScrollView addSubview:textFieldsScrollView];
    
    CGFloat plusX = self.bottomScrollView.bounds.size.width * 3 - 70;
    CGFloat plusY = self.bottomScrollView.bounds.size.height - 70;
    CGFloat plusW = 64;
    CGFloat plusH = 64;
    CGRect plusBtnFrame = CGRectMake(plusX, plusY, plusW, plusH);
    UIButton *plusButton = [[UIButton alloc] initWithFrame:plusBtnFrame];
    plusButton.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:157.0/255.0 blue:62.0/255.0 alpha:1];
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
    [plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plusButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24.f]];
    plusButton.layer.cornerRadius = btn2W / 2;
    [self.bottomScrollView addSubview:plusButton];
    [plusButton addTarget:self action:@selector(addTextField) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat textFieldX = 20;
    CGFloat textFieldY = 20;
    CGFloat textFieldW = self.bottomScrollView.bounds.size.width - 40;
    CGFloat textFieldH = 50;
    for (int i = 0; i < 2; i++) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH)];
        textField.backgroundColor = [UIColor whiteColor];
        textField.tag = i + 1;
        textField.placeholder = [NSString stringWithFormat:@"Խումբ %d", i + 1];
        textFieldY += textFieldH + 20;
        [self.textFieldsArray addObject:textField];
        [self.textFieldsScrollView addSubview:textField];
    }
    
// Adds observers to keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // Creates tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self addGestureRecognizer:tapGesture];

}

#pragma mark - Notification handle methods
- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.bottomScrollView.contentInset = contentInsets;
    self.bottomScrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin) ) {
        [self.bottomScrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.bottomScrollView.contentInset = contentInsets;
    self.bottomScrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark - TextField delegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.activeField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    textField.returnKeyType = UIReturnKeyDone;
    [self endEditing:YES];
    return YES;
}

- (void)hideKeyboard:(UIBarButtonItem*)doneButton {
    [self endEditing:YES];
}



#pragma mark - button click methods
- (void)decreaseScore:(UIButton*)button {
    if ([self.scoreLabel.text integerValue] > 5) {
        self.scoreLabel.text =  [NSString stringWithFormat:@"%ld", [self.scoreLabel.text integerValue] - 5];
    }
}

- (void)increaseScore:(UIButton*)button {
    if ([self.scoreLabel.text integerValue] < 160) {
        self.scoreLabel.text =  [NSString stringWithFormat:@"%ld", [self.scoreLabel.text integerValue] + 5];
    }
}

- (void)decreaseTime:(UIButton*)button {
    if ([self.timeLabel.text integerValue] > 20) {
        self.timeLabel.text =  [NSString stringWithFormat:@"%ld", [self.timeLabel.text integerValue] - 5];
    }
}

- (void)increaseTime:(UIButton*)button {
    if ([self.timeLabel.text integerValue] < 120) {
        self.timeLabel.text =  [NSString stringWithFormat:@"%ld", [self.timeLabel.text integerValue] + 5];
    }
}

- (void)addTextField {
    CGFloat textFieldX = 20;
    CGFloat textFieldW = self.bottomScrollView.bounds.size.width - 40;
    CGFloat textFieldH = 50;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, self.textFieldsArray.count * (textFieldH + 20) + 20, textFieldW, textFieldH)];
    textField.backgroundColor = [UIColor whiteColor];
    [self.textFieldsArray addObject:textField];
    textField.tag = self.textFieldsArray.count;
    NSLog(@"%ld", self.textFieldsArray.count);
    textField.placeholder = [NSString stringWithFormat:@"Խումբ %ld", self.textFieldsArray.count];
    [self.textFieldsScrollView addSubview:textField];
    self.textFieldsScrollView.contentSize = CGSizeMake(self.textFieldsScrollView.bounds.size.width, self.textFieldsArray.count * (textFieldH + 20) + 20);
    
    for (UITextField *field in self.textFieldsArray) {
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textFieldH, textFieldH)];
        field.rightViewMode = UITextFieldViewModeAlways;
        [deleteButton setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
        [field setRightView:deleteButton];
        
        [deleteButton addTarget:self action:@selector(removeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)removeButtonClicked:(UIButton *)sender {
    [self.textFieldsArray removeObject:sender.superview];
    [sender.superview removeFromSuperview];
    NSLog(@"%ld", self.textFieldsArray.count);
    
    if (self.textFieldsArray.count <= 2) {
        for (UITextField *field in self.textFieldsArray) {
            field.rightViewMode = UITextFieldViewModeNever;
        }
    }
    CGFloat y = 20;
    NSInteger counter = 0;
    for (UITextField *field in self.textFieldsArray) {
        field.placeholder = [NSString stringWithFormat:@"Խումբ %ld", counter + 1];
        
        CGRect frame = CGRectMake(20, counter * 70 + y, self.bottomScrollView.bounds.size.width - 40, 50);
        field.frame = frame;
        counter++;
    }
}

- (void)buttonClicked:(UIButton *)sender {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    switch (sender.tag) {
        case 1:
            [self.bottomScrollView setContentOffset:CGPointZero animated:YES];
            break;
        case 2:
            [self.bottomScrollView setContentOffset:CGPointMake(screenSize.width - 20, 0) animated:YES];
            break;
        default:
            [self.bottomScrollView setContentOffset:CGPointMake(2 * screenSize.width - 40, 0) animated:YES];
            break;
    }
}

@end
