//
//  ConframeAppDelegate.h
//  Conframe
//
//  Created by Austin Robert Bales on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface ConframeAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    WebView *webview;
    NSToolbarItem *username;
}
- (IBAction)alert:(id)sender;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webview;
@property (assign) IBOutlet NSToolbarItem *username;

@end
