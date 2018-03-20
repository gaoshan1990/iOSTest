//
//  ViewController.m
//  TestWkwebView
//
//  Created by most on 2017/11/8.
//  Copyright © 2017年 most. All rights reserved.
//

#import "ViewController.h"
#import  <WebKit/WebKit.h>
@interface ViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property(nonatomic,strong) WKWebView *WebView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    

    [self testWebView];
    
}

- (void)testWebView{
    
    

    WKWebViewConfiguration  *config = [[WKWebViewConfiguration alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    
    NSString *obj =@"var test ={'exec':function(){alert('dddd')}};";
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:obj injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [config.userContentController addUserScript:script];
    
    [config.userContentController addScriptMessageHandler:self name:obj];
    
    
    
    WKWebView  *webview =[[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    
    self.WebView =webview;
    [self.view addSubview:webview];
    
  
    
    webview.navigationDelegate =self;
    webview.UIDelegate = self;
//    NSString *urlStr = @"http://wwww.baidu.com";
//    
//    NSURL  *url =[NSURL URLWithString:urlStr];
//    NSURLRequest  *request =[NSURLRequest requestWithURL:url];
//    
//    [webview loadRequest:request];
////
    
    UIButton  *btn =[[UIButton alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    btn.backgroundColor =[UIColor redColor];
    [btn setTitle:@"touchMe" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(euvalueJS:) forControlEvents:UIControlEventTouchUpInside];
    [webview addSubview:btn];
  
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
    
    NSURL *pathUrl = [NSURL fileURLWithPath:path];
    [webview loadFileURL:pathUrl allowingReadAccessToURL:pathUrl];
    
    
}

#pragma mark ---WKUIDelegate
    /*  警告 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController  *alertController   =  [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    /*
     
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,
     UIAlertActionStyleDestructive
     */
    UIAlertAction  *action1  =[UIAlertAction actionWithTitle:@"test1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if ([action.title isEqualToString:@"test1"]) {
        }
    }];
    
    UIAlertAction  *action2  =[UIAlertAction actionWithTitle:@"test2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction  *action3  =[UIAlertAction actionWithTitle:@"test3" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];

//    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        
//    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    completionHandler();
}
    ///** 确认框 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    
    
    
    [[[UIAlertView alloc] initWithTitle:@"确认框" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    
    completionHandler(1);
}
    /**  输入框 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    
    [[[UIAlertView alloc] initWithTitle:@"输入框" message:prompt delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    completionHandler(@"");
}
    
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    // js 调取原生的时候走此方法;;;;;;;;
   }

- (IBAction)euvalueJS:(UIButton *)sender {
    
   [self.WebView evaluateJavaScript:@"callJsAlert('ssss')" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
       
   }];
    
}

#pragma mark - WKNavigationDelegate--- 加载方法
// 页面加载开始  Provisional临时的
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    self.title  =webView.title; //获取网页的title;
    NSLog(@"页面开始加载");
}
// 加载内容
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"内容正在加载当中");
}
// 页面加载完成
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面加载完成");
}
//  页面加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}
#pragma mark ----跳转方法
// 接收到服务器重新配置请求之后再执行
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}
// API是根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURLRequest * request = navigationAction.request;
    NSLog(@"%@",request.URL.absoluteString);
    
    // 判断请求头是否是 https://www.baidu.com 如果是就不在请求加载跳转
    WKNavigationActionPolicy  actionPolicy = WKNavigationActionPolicyAllow;
    if ([request.URL.absoluteString hasPrefix:@"https://www.baidu.com"]) {
        
        actionPolicy = WKNavigationActionPolicyCancel;
        
    }
    // 必须这样执行，不然会崩
    decisionHandler(actionPolicy);
}

// API是根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%@",navigationResponse.response);
    /**
     *  判断响应的数据里面的URL是https://www.baidu.com/开头的，要是就不让它加载跳转
     */
    WKNavigationResponsePolicy responsePolicy = WKNavigationResponsePolicyAllow;
    if ([navigationResponse.response.URL.absoluteString hasPrefix:@"https://www.baidu.com/"]) {
        
        responsePolicy = WKNavigationResponsePolicyCancel;
    }
    decisionHandler(responsePolicy);
}

@end
