//
//  ETHManager.m
//  YB-YH
//
//  Created by Apple on 2018/6/27.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ETHManager.h"


@interface ETHManager()  <UIWebViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property WebViewJavascriptBridge* bridge;

@end

@implementation ETHManager
XMGSingletoM
-(instancetype)init
{
    self = [super init];
    if (self ) {
        [self initWebView];
        return self;
    }
    return nil;
}

-(void)initWebView
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    webView.delegate = self ;
    [self.window addSubview:webView];

    [WebViewJavascriptBridge enableLogging];

    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
    }];

    [self loadExamplePage:webView];
}

- (void)loadExamplePage:(UIWebView*)webView {
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ExampleApp.html" relativeToURL:[[NSBundle mainBundle] bundleURL]]]];
}

+(void)createAccountPassword:(NSString *)password responseCallback:(WVJBResponseCallback)responseCallback
{
    [[self sharedInstance]createAccountPassword:password responseCallback:responseCallback];
}

-(void)createAccountPassword:(NSString *)password responseCallback:(WVJBResponseCallback)responseCallback
{
    [_bridge callHandler:@"createAccount" data:password responseCallback:^(id response) {
        responseCallback(response);
    }];
}
+(void)createKeyWithPassword:(NSString *)password account:(NSString *)account responseCallback:(WVJBResponseCallback)responseCallback
{
    [[self sharedInstance]createKeyWithPassword:password account:account responseCallback:responseCallback];
}
-(void)createKeyWithPassword:(NSString *)password account:(NSString *)account responseCallback:(WVJBResponseCallback)responseCallback
{
    [_bridge callHandler:@"createKey" data:@{@"password":password,@"account":account} responseCallback:^(id response) {
        responseCallback(response);
    }];
}
+(void)createSignWithKey:(NSString *)key data:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [[self sharedInstance]createSignWithKey:key data:data responseCallback:responseCallback];
}
-(void)createSignWithKey:(NSString *)key data:(id)data responseCallback:(WVJBResponseCallback)responseCallback
{
    [_bridge callHandler:@"createSign" data:@{@"key":key,@"data":data} responseCallback:^(id response) {
        responseCallback(response);
    }];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
   
}
@end
