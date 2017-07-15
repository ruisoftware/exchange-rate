//
//  MainViewController.h
//  ExchangeRate
//
//  Created by Jose Rui Santos on 14/07/17.
//  Copyright © 2017 Jose Rui Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"

@class MainViewController;

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *inputLeft;
@property (weak, nonatomic) IBOutlet UITextField *inputRight;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencyLeft;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencyRight;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateRate;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UIButton *btnHideKeyboard;

- (IBAction)inputLeftTouchDown:(id)sender;
- (IBAction)inputLeftEditingChanged:(id)sender;

- (IBAction)inputRightTouchDown:(id)sender;
- (IBAction)inputRightEditingChanged:(id)sender;

- (IBAction)currencyLeftChanged:(id)sender;
- (IBAction)currencyRightChanged:(id)sender;
- (IBAction)dateRateChanged:(id)sender;
- (IBAction)btnHideKeyboardTouchDown:(id)sender;

@property (retain, nonatomic) DataModel *model;

@end
