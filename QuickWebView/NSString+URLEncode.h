//
//  NSString+URLEncode.h
//  QuickWebView
//
//  Created by azu on 2013/02/16.
//  Copyright (c) 2013年 azu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)
- (NSString *)URLEncode;
- (NSString *)stringByEncodingURL;
- (NSString *)URLDecode;
- (NSString *)stringByDecodingURL;
@end
