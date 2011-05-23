//
//  ConframeAppDelegate.h
//  Conframe
//
//  Created by Austin Robert Bales on 5/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "MHConvoreClient.h"
#import <UIKit/UIKitView.h>
#import <UIKit/UIButton.h>
#import <UIKit/AppKitIntegration.h>

@interface ConframeAppDelegate : NSObject <NSApplicationDelegate, MHConvoreClientListener> {
@private
    MHConvoreClient *client;
    NSWindow *window;
    WebView *webview;
    NSToolbarItem *username;
  NSProgressIndicator *spinner;
    NSView *background;
    NSTextField *username_field;
    NSSecureTextField *password_field;
    NSTextField *error_message;
    NSBox *login_box;
    NSArray *groups_list;
    NSArray *topics_list;
    NSPopUpButton *groups_popup;
    NSArrayController *groups_controller;
}
@property (assign) IBOutlet NSProgressIndicator *spinner;
@property (assign) IBOutlet NSView *background;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet WebView *webview;
@property (assign) IBOutlet NSToolbarItem *username;
@property (assign) IBOutlet NSTextField *username_field;
@property (assign) IBOutlet NSSecureTextField *password_field;
@property (assign) IBOutlet NSTextField *error_message;
@property (assign) IBOutlet NSBox *login_box;
@property (assign) IBOutlet NSPopUpButton *groups_popup;
@property (assign) IBOutlet NSArrayController *groups_controller;
@property (assign) NSArray *groups_list;
@property (assign) NSArray *topics_list;

- (IBAction)loginToConvore:(id)sender;
- (IBAction)showGroup:(id)sender;

@end
