//
//  ChatView.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginView.h"


@implementation LoginView

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"page-bkg2.jpg"]] set];
    NSRectFill (dirtyRect);
}

@end
