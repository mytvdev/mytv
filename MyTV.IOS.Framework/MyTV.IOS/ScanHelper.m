//
//  ScanHelper.m
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/24/12.
//
//

#import "ScanHelper.h"

@implementation ScanHelper

+(int)getIntFromNSString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    int value;
    [scanner scanInt:&value];
    return value;
}

+(NSDate *)getDateFromNSString:(NSString *)string {
    if(string == NULL || [string compare:@""] == NSOrderedSame) return NULL;
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}

@end
