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
    self.model = [DataModel getInstance];

    self.inputLeft.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputRight.keyboardType = UIKeyboardTypeDecimalPad;
    self.dateRate.minimumDate = [self.model getAPIMinimumDate];
    self.dateRate.maximumDate = [NSDate date];
    self.btnHideKeyboard.hidden = TRUE;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) keyboardWillShow:(NSNotification*)notification {
    self.btnHideKeyboard.hidden = FALSE;
}

- (void) keyboardWillBeHidden:(NSNotification*)notification {
    self.btnHideKeyboard.hidden = TRUE;
}

- (IBAction)btnHideKeyboardTouchDown:(id)sender {
    [self.view endEditing:YES];
}

# pragma mark - Timer that triggers API request

- (void) initTimer {
    keypressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer:) userInfo:nil repeats:NO];
}

- (void) fireTimer:(NSTimer *)timer {
    keypressTimer = nil;
    
    UITextField *fromEdit = [self model].calcDirection == EDirectionL2R ? self.inputLeft : self.inputRight;
    UITextField *toEdit =   [self model].calcDirection == EDirectionL2R ? self.inputRight : self.inputLeft;
    if (fromEdit.text.length == 0) {
        toEdit.text = @"";
        return;
    }
    
    ECurrency leftCurrency = [self.model convertIntToECurreny:[self.currencyLeft selectedSegmentIndex]];
    ECurrency rightCurrency = [self.model convertIntToECurreny:[self.currencyRight selectedSegmentIndex]];

    float result;
    if ([self model].calcDirection == EDirectionL2R) {
        result = [[self model] convertCurrency:[fromEdit.text floatValue] fromCurr:leftCurrency toCurr:rightCurrency withDate:[self.dateRate date]];
    } else {
        result = [[self model] convertCurrency:[fromEdit.text floatValue] fromCurr:rightCurrency toCurr:leftCurrency withDate:[self.dateRate date]];
    }
    toEdit.text = [[NSString stringWithFormat: @"%9.2f", result] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (IBAction) inputLeftEditingChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self initTimer];
}

- (IBAction) inputRightEditingChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self initTimer];
}

- (IBAction)currencyLeftChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self fireTimer:nil];
}

- (IBAction)currencyRightChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self fireTimer:nil];
}

- (IBAction)dateRateChanged:(id)sender {
    if (keypressTimer.isValid) {
        [keypressTimer invalidate];
    }
    [self initTimer];
}

#pragma mark - Arrow animation

- (IBAction) inputLeftTouchDown:(id)sender {
    if ([self model].calcDirection == EDirectionR2L) {
        [self model].calcDirection = EDirectionL2R;
        [self rotateArrow];
    }
}

- (IBAction)inputRightTouchDown:(id)sender {
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
    rotate.duration = .25;
    rotate.repeatCount = 1;
    rotate.removedOnCompletion = NO;
    rotate.fillMode = kCAFillModeForwards;
    [self.arrowImg.layer addAnimation:rotate forKey:nil];
}
@end
