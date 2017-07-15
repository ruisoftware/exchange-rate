//
//  MainViewController.m
//  ExchangeRate
//
//  Created by Jose Rui Santos on 14/07/17.
//  Copyright © 2017 Jose Rui Santos. All rights reserved.
//

#import "MainViewController.h"
#include <math.h>

@interface MainViewController ()

@end

@implementation MainViewController {

    NSTimer * keypressTimer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_inputFrom release];
    [_currencyFrom release];
    [_inputTo release];
    [_currencyTo release];
    [_dateRate release];
    [_arrowImg release];
    [keypressTimer release];
    [super dealloc];
}

- (void)initialize {
    self.inputFrom.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputTo.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)initTimer {
    keypressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer:) userInfo:nil repeats:NO];
}

- (void)fireTimer:(NSTimer *)timer {
    [keypressTimer release];
    keypressTimer = nil;
}

- (IBAction)inputFromTouchDown:(id)sender {
    [self rotateArrow:TRUE];
}

- (IBAction)inputToTouchDown:(id)sender {
    [self rotateArrow:FALSE];
}


- (IBAction)inputFromEditingChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self initTimer];
}

- (void)rotateArrow: (BOOL)rotateToTheRight {
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if (rotateToTheRight) {
        rotate.fromValue = [NSNumber numberWithFloat:M_PI];
        rotate.toValue = [NSNumber numberWithFloat:0];
    } else {
        rotate.fromValue = [NSNumber numberWithFloat:0];
        rotate.toValue = [NSNumber numberWithFloat:M_PI];
    }
    rotate.duration = .2;
    rotate.repeatCount = 1;
    rotate.removedOnCompletion = NO;
    rotate.fillMode = kCAFillModeForwards;
    [self.arrowImg.layer addAnimation:rotate forKey:nil];
}
@end
