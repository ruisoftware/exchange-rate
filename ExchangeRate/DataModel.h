//
//  DataModel.h
//  ExchangeRate
//
//  Created by Jose Rui Santos on 15/07/17.
//  Copyright © 2017 Jose Rui Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataProtocol.h"

@interface DataModel : NSObject<DataProtocol>

@property (assign, nonatomic) EDirection calcDirection;

+ (id) getInstance; /* singleton */

- (NSDate *) getAPIMinimumDate;
- (float) convertCurrency:(float)value fromCurr:(ECurrency)from toCurr:(ECurrency)to withDate:(NSDate *)date;

- (NSString *) convertECurrenyToStr:(ECurrency)curr;
- (ECurrency) convertStrToECurreny:(NSString *)curr;
- (ECurrency) convertIntToECurreny:(NSInteger)idx;
@end
