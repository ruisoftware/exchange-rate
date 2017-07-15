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

@property (retain, nonatomic) IBOutlet UITextField *inputFrom;
@property (retain, nonatomic) IBOutlet UISegmentedControl *currencyFrom;
@property (retain, nonatomic) IBOutlet UITextField *inputTo;
@property (retain, nonatomic) IBOutlet UISegmentedControl *currencyTo;
@property (retain, nonatomic) IBOutlet UIDatePicker *dateRate;
@property (retain, nonatomic) IBOutlet UIImageView *arrowImg;

@property (retain, nonatomic) DataModel *model;

- (IBAction)inputFromTouchDown:(id)sender;
- (IBAction)inputToTouchDown:(id)sender;
- (IBAction)inputFromEditingChanged:(id)sender;

@end
