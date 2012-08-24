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

@end
