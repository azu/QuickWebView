//
//  NSString+URLEncode.m
//  QuickWebView
//
//  Created by azu on 2013/02/16.
//  Copyright (c) 2013年 azu. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)
- (NSString *)URLEncode {
    return [self stringByEncodingURL];
}

- (NSString *)stringByEncodingURL {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$.,/?%#[]", kCFStringEncodingUTF8);
}

- (NSString *)URLDecode {
    return [self stringByDecodingURL];
}

- (NSString *)stringByDecodingURL {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
}
@end
