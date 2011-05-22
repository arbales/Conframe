//
//  ConframeAppDelegate.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConframeAppDelegate.h"

@implementation ConframeAppDelegate
@synthesize spinner;
@synthesize username;

@synthesize window, webview;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  [spinner startAnimation: self];
  [webview setFrameLoadDelegate:self];
  [webview setHidden:TRUE];
  [[webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.convore.com/login"]]];
  
    // Setup notifications for webview
  NSNotificationCenter *center = [NSNotificationCenter defaultCenter]; 
  [center addObserver:self selector:@selector (webViewProgressFinished:) name:WebViewProgressFinishedNotification object:webview]; 
}

- (void)webViewProgressFinished:(NSNotification *)aNotification {
  BOOL logged_in;
  @try {
    BOOL logged_in = ![[[webview windowScriptObject] evaluateWebScript: @"$('.username').first().text();"] isEqualToString:@""];
      //    BOOL *logged_in //= detected_username
  }
  @catch (NSException *exception) {
    BOOL logged_in = FALSE;
  }

  
  
  [webview setHidden:FALSE];
  [spinner stopAnimation: self];
  NSString *url = [webview mainFrameURL];
  NSLog(@"%@", url);

    // Logged Out, direct to login window
  if ([url rangeOfString:@"/login.php"].location != NSNotFound) {
    NSLog(@"Gonna load Zepto...");
    NSString *filesContent = [[NSString alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"zepto.min" ofType:@"js"]];
      //NSLog(@"%@", filesContent);
      //[[webview windowScriptObject] evaluateWebScript: filesContent];
    [webview stringByEvaluatingJavaScriptFromString:filesContent];
    [[webview windowScriptObject] evaluateWebScript: @"Zepto('.linear_language').hide();"];
    [[webview windowScriptObject] evaluateWebScript: @"Zepto('.signup_bar_container').hide();"];
    [[webview windowScriptObject] evaluateWebScript: @"Zepto('#pageFooter').hide();"];
    
  } else if ([url isEqualToString:@"https://convore.com/login/"]) {
    [webview setHidden: FALSE];
    [spinner stopAnimation: self];
    [[webview windowScriptObject] evaluateWebScript:@"$('#footer').hide();"];
  }
  else {
    [[webview windowScriptObject] evaluateWebScript:@"$('#stripe').hide();"];
    [[webview windowScriptObject] evaluateWebScript:@"$('#footer').hide();"];
    [[webview windowScriptObject] evaluateWebScript:@"$('#header').hide();"];
    [[webview windowScriptObject] evaluateWebScript:@"$('body').css({'background':'url(https://convore.com/media/images/bkg/page-bkg2.jpg?66c177e9cd010ba169324968185f0236735edc95)'}"];
    [[webview windowScriptObject] evaluateWebScript:@"$('#content').css({'margin-bottom':'0px', 'margin-top':'0px'});"];
    [webview setHidden: FALSE];

  }
}

- (IBAction)alert:(id)sender {
    NSArray *arr = [NSArray arrayWithObjects: @"Hello", nil];
// [[webview windowScriptObject] callWebScriptMethod: @"alert" withArguments:arr];
//   username )
//NSString *found_username = ;
  if (true){
    [webview setHidden:FALSE];
  } else {
    NSLog(@"Value: %@", [[webview windowScriptObject] evaluateWebScript: @"$('.username').first().text();"]); 
  }
  
    //    [username setLabel: [];
}
- (IBAction)see_mentions:(id)sender {
  [[webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.convore.com/mentions"]]];
}
@end
