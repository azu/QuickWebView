//
//  AppDelegate.m
//  QuickWebView
//
//  Created by azu on 2013/02/16.
//  Copyright (c) 2013年 azu. All rights reserved.
//

#import "AppDelegate.h"
#import "NSURL+L0URLParsing.h"
@implementation AppDelegate

-(void)awakeFromNib {
    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
    [[self.webView preferences] setDefaultFontSize:16];

}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

}

- (void)handleURLEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    NSString* urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSURL *url = [NSURL URLWithString:urlString];
    if (url && [[url host] isEqualToString:@"open"]) {
        NSDictionary *params = [url dictionaryByDecodingQueryString];
        NSURL *urlForOpen = [NSURL URLWithString:[params objectForKey:@"url"]];
        NSLog(@"url %@",urlForOpen);
        [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:urlForOpen]];
    }
    
}
- (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    NSArray * pairs = [query componentsSeparatedByString:@"&"];
    for (NSString * pair in pairs) {
        NSArray * elements = [pair componentsSeparatedByString:@"="];
        NSString * key     = [[elements objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * value   = [[elements objectAtIndex:1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [dictionary setValue:value forKey:key];
    }
    return dictionary;
}

@end
