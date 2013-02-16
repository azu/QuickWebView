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
// QuickWebView://open/?url=http://eow.alc.co.jp/search?q={query}
- (void)handleURLEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    NSString* urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSLog(@"url %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    if (url && [[url host] isEqualToString:@"open"]) {
        NSDictionary *params = [url dictionaryByDecodingQueryString];
        NSLog(@"url %@",params);
        NSURL *urlForOpen = [NSURL URLWithString:[params objectForKey:@"url"]];
        [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:urlForOpen]];
    }
    
}
// when close window, exit application
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}
@end
