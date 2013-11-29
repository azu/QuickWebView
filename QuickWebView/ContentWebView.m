//
// Created by azu on 2013/03/09.
//


#import "ContentWebView.h"


@implementation ContentWebView {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    [[self preferences] setDefaultFontSize:16];
}
- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame {
    if(![frame parentFrame]) {
        [self injectCSS];
    }
}



- (void)injectCSS {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"reader" ofType:@"css"];
    NSString *cssContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSString *js = [NSString stringWithFormat:@"document.addEventListener( \"DOMContentLoaded\", function(){ function addCSS (css){\n"
                                                      "\tif (document.createStyleSheet) { // for IE\n"
                                                      "\t\tvar sheet = document.createStyleSheet();\n"
                                                      "\t\tsheet.cssText = css;\n"
                                                      "\t\treturn sheet;\n"
                                                      "\t} else {\n"
                                                      "\t\tvar sheet = document.createElement('style');\n"
                                                      "\t\tsheet.type = 'text/css';\n"
                                                      "\t\tvar _root = document.getElementsByTagName('head')[0] || document.documentElement;\n"
                                                      "\t\tsheet.textContent = css;\n"
                                                      "\t\treturn _root.appendChild(sheet).sheet;\n"
                                                      "\t}\n"
                                                      "}"
                                                      "addCSS('%@');},false);"
            , [cssContent stringByReplacingOccurrencesOfString:@"\n" withString:@""]];

    [self stringByEvaluatingJavaScriptFromString:js];
}
@end