//
//  DataModel.h
//  ExchangeRate
//
//  Created by Jose Rui Santos on 15/07/17.
//  Copyright © 2017 Jose Rui Santos. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataProtocol <NSObject>

typedef enum {
    ECurrencyRUB,
    ECurrencyUSD,
    ECurrencyEUR
} ECurrency;

typedef enum {
    EDirectionL2R,
    EDirectionR2L
} EDirection;

extern NSString *const API_BASEURL;

- (float)convertCurrency:(float)value fromCurr:(ECurrency)from toCurr:(ECurrency)to withDate:(NSDate *)date;

@end
