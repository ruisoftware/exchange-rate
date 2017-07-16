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

NSString *const API_BASEURL = @"https://api.fixer.io";

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

- (float) convertCurrency:(float)value fromCurr:(ECurrency)from toCurr:(ECurrency)to withDate:(NSDate *)date {
    return value*[self getRatioFrom:from toCurr:to withDate:date];
}

- (NSDate *) getAPIMinimumDate { // fixer.io API has no data before April 1st 2005
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:4];
    [comps setYear:2005];
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:comps];
}

- (NSString *) getApiUrl:(ECurrency)from withDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
    NSString *dateUrl;
    if ([[NSCalendar currentCalendar] isDateInToday:date]) {
        dateUrl = @"latest";
    } else {
        dateUrl = [NSString stringWithFormat:@"%04d-%02d-%02d", (int)dateComponents.year, (int)dateComponents.month, (int)dateComponents.day];
    }
    NSLog(@"%@", dateUrl);
    return [NSString stringWithFormat: @"%@/%@?base=%@", API_BASEURL, dateUrl, [self convertECurrenyToStr:from]];
}

- (float) getRatioFrom:(ECurrency)from toCurr:(ECurrency)to withDate:(NSDate *)date {
    if (from == to) {
        return 1.0f;
    }

    NSString *urlString = [self getApiUrl:from withDate:date];
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

- (ECurrency)convertIntToECurreny: (NSInteger) idx {
    switch (idx) {
        case 1:
            return ECurrencyUSD;
        case 2:
            return ECurrencyEUR;
    }
    return ECurrencyRUB;
}

@end
