//
//  ViewController.m
//  BMOCacheWebview
//
//  Created by Breno Medeiros on 25/04/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configurarControlador];
}

-(void)configurarControlador {
    _tfPaginaAcessada.text = @"https://aovivo.club/assistir-disney-xd-ao-vivo/";
    
    WKWebViewConfiguration *configuracao = [[WKWebViewConfiguration alloc] init];
    self.wvPaginaWeb = [[WKWebView alloc] initWithFrame:[self.viewPaginaWeb bounds] configuration:configuracao];
    self.wvPaginaWeb.navigationDelegate = self;
    
    [self setURL:_tfPaginaAcessada.text];
    //[self cacheFile];
    
    /*NSURL  *url = [NSURL URLWithString:_tfPaginaAcessada.text];
    NSData *dadosDaUrl = [NSData dataWithContentsOfURL:url];
    if (dadosDaUrl) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];

        //NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"filename.png"];
        //[dadosDaUrl writeToFile:filePath atomically:YES];

        [dadosDaUrl writeToFile:documentsDirectory atomically:YES];
        
    }*/
}


#pragma mark - Metodos Privados

- (void)setURL:(NSString *)requestURLString {
    NSURL *url = [NSURL URLWithString:requestURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [_wvPaginaWeb loadRequest:request];
    [self.viewPaginaWeb addSubview:_wvPaginaWeb];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"request: %@", navigationAction.request);
    BOOL *permite = NO;

    // check whether this request should be stopped - if this is redirect_uri (like user is already authorized)
    if (permite) {
        self.wvPaginaWeb.navigationDelegate = nil;

        // do what is needed to send authorization data back
        //self.completionBlock(...);

        // close current view controller
        //[self dismissViewControllerAnimated:YES completion:nil];

        // stop executing current request
        decisionHandler(WKNavigationActionPolicyCancel);

    } else {
        // otherwise allow current request
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;

    // filter the responses, in order to verify only the response from specific domain
    if ([[NSString stringWithFormat:[[response URL] absoluteString]] containsString:@"m3u8"]) {

        NSInteger statusCode = [response statusCode];

        // check what is the status code
        if (statusCode == 200 ||
            statusCode == 301 ||
            statusCode == 302) {

            // allow response as everything is ok
            decisionHandler(WKNavigationResponsePolicyAllow);

        } else {
            // handle the error (e.g. any of 4xx or any others)

            self.wvPaginaWeb.navigationDelegate = nil;

            // send needed info back
            //self.completionBlock(...);

            // close current view controller
            //[self dismissViewControllerAnimated:YES completion:nil];

            // stop current response
            decisionHandler(WKNavigationResponsePolicyCancel);
        }

    } else {
        // current response is not from our domain, so allow it
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

- (IBAction)btPegaCache:(id)sender {
    WKWebsiteDataStore *dataStore = _wvPaginaWeb.configuration.websiteDataStore;
    [dataStore.httpCookieStore getAllCookies:^(NSArray* cookies) {
        NSHTTPCookie *cookie;
        for(cookie in cookies){
            NSLog(@"cookie: %@", cookie);
        }
    }];
}











/*- (void) cacheFile {
    //Create the file/directory pointer for the storage of the cache.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    self.caminhoDosDados = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"cache.html"];

    //Check to see if a file exists a the location
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.caminhoDosDados]) {
       //Code for customising when the cache reloads would go here.
    } else {
        //If no file exists write the html cache to it
        //Download and write to file
        NSURL *cacheUrl = [NSURL URLWithString:_tfPaginaAcessada.text];
        NSData *cacheUrlData = [NSData dataWithContentsOfURL:cacheUrl];
        [cacheUrlData writeToFile:self.caminhoDosDados atomically:YES];
    }
    
    //Run the load web view function.
    [self loadWebView];
}
- (void) loadWebView {
    //Load up the web view from the cache.
    [_wvPaginaWeb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.caminhoDosDados]]];
}*/

@end
