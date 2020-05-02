//
//  ViewController.h
//  BMOCacheWebview
//
//  Created by Breno Medeiros on 25/04/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfPaginaAcessada;
@property (weak, nonatomic) IBOutlet UIView *viewPaginaWeb;
@property (weak, nonatomic) IBOutlet WKWebView *wvPaginaWeb;
@property (weak, nonatomic) IBOutlet UITextView *tvLinkDaTransmissao;

- (IBAction)btPegaCache:(id)sender;

@property (weak, nonatomic) NSString *caminhoDosDados;

@end

