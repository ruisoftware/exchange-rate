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
    NSTimer *keypressTimer;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initialize {
    self.inputFrom.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputTo.keyboardType = UIKeyboardTypeDecimalPad;
    self.model = [DataModel getInstance];
}

# pragma mark - Timer that triggers API request

- (void) initTimer {
    keypressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer:) userInfo:nil repeats:NO];
}

- (void) fireTimer:(NSTimer *)timer {
    keypressTimer = nil;
    
    float result = [[self model] convertCurrency:3.0f fromCurr:ECurrencyEUR toCurr: ECurrencyRUB];
    [self inputTo].text = [[NSString stringWithFormat: @"%9.2f", result] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (IBAction) inputFromEditingChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self initTimer];
}

#pragma mark - Arrow animation

- (IBAction) inputFromTouchDown:(id)sender {
    if ([self model].calcDirection == EDirectionR2L) {
        [self model].calcDirection = EDirectionL2R;
        [self rotateArrow];
    }
}

- (IBAction) inputToTouchDown:(id)sender {
    if ([self model].calcDirection == EDirectionL2R) {
        [self model].calcDirection = EDirectionR2L;
        [self rotateArrow];
    }
}

- (void) rotateArrow {
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    if ([self model].calcDirection == EDirectionL2R) {
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
