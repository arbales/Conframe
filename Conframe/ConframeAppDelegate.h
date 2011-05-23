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

@interface ConframeAppDelegate : NSObject <NSApplicationDelegate, MHConvoreClientListener> {
@private
  IBOutlet NSView *accessoryView;
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
    IBOutlet NSView *loginView;
    NSArray *groups_list;
    NSArray *topics_list;
  NSImageView *avatar;
    NSPopUpButton *groups_popup;
    NSArrayController *groups_controller;
    NSTextField *titleView;
}
@property (assign) IBOutlet NSTextField *titleView;
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
@property (assign) IBOutlet NSImageView *avatar;

- (IBAction)loginToConvore:(id)sender;
- (IBAction)showGroup:(id)sender;
- (float)roundedCornerRadius;
- (void)drawRectOriginal:(NSRect)rect;
- (void)setupTitle;
- (void)setupAccessory;

@end
