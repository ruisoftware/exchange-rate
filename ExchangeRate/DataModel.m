//
//  Data_DataModel.h
//  ExchangeRate
//
//  Created by Jose Rui Santos on 15/07/17.
//  Copyright © 2017 Jose Rui Santos. All rights reserved.
//

#import "DataModel.h"

@interface DataModel()

@end

@implementation DataModel

NSString *const API_BASEURL = @"https://api.fixer.io/";

+ (id)getInstance {
    static DataModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.calcDirection = EDirectionL2R;
    });
    return instance;
}

#pragma mark - API

- (NSString *)getApiUrl: (ECurrency) from {
    return [NSString stringWithFormat: @"%@latest?base=%@", API_BASEURL, [self convertECurrenyToStr:from]];
}

- (float) convertCurrency: (float)value fromCurr:(ECurrency)from toCurr:(ECurrency)to {
    return value*[self getRatioFrom:from toCurr:to];
}

- (float) getRatioFrom:(ECurrency)from toCurr:(ECurrency)to {
    if (from == to) {
        return 1.0f;
    }

    NSString *urlString = [self getApiUrl:from];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]];
        
    NSDictionary *jsonDict = [self parseJsonResponse:jsonData];
    NSDecimalNumber *rate = [jsonDict valueForKeyPath: [NSString stringWithFormat:@"rates.%@", [self convertECurrenyToStr:to]]];
    return [rate floatValue];
}

- (NSDictionary *)parseJsonResponse: (NSData *)jsonData {
    NSError *jsonError;
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
}

#pragma mark - ECurrency utils

- (NSString *)convertECurrenyToStr: (ECurrency) curr {
    switch (curr) {
        case ECurrencyRUB:
            return @"RUB";
        case ECurrencyUSD:
            return @"USD";
        case ECurrencyEUR:
            return @"EUR";
    }
    return nil;
}

- (ECurrency)convertStrToECurreny: (NSString *) curr {
    if ([curr isEqualToString:@"USD"]) {
        return ECurrencyUSD;
    }
    if ([curr isEqualToString:@"EUR"]) {
        return ECurrencyEUR;
    }
    return ECurrencyRUB;
}

@end
