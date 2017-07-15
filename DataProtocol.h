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

- (NSDecimalNumber) getRatioFor(ECurrency from, ECurrency to, NSDecimalNumber *value)

@end
