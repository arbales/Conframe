//
//  ConframeAppDelegate.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConframeAppDelegate.h"

@implementation ConframeAppDelegate
@synthesize username;

@synthesize window, webview;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[webview mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.convore.com"]]];
}

- (IBAction)alert:(id)sender {
    NSArray *arr = [NSArray arrayWithObjects: @"Hello", nil];
// [[webview windowScriptObject] callWebScriptMethod: @"alert" withArguments:arr];
//   username )
    [username setLabel: [[webview windowScriptObject] evaluateWebScript: @"$('.username').text();"]];
}
@end
