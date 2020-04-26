//
//  ViewController.h
//  BMOCacheWebview
//
//  Created by Breno Medeiros on 25/04/20.
//  Copyright © 2020 ProgramasBMO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfPaginaAcessada;
@property (weak, nonatomic) IBOutlet UIWebView *wvPaginaWeb;
@property (weak, nonatomic) IBOutlet UITextView *tvLinkDaTransmissao;

@end

