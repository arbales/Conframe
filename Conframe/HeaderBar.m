//
//  HeaderBar.m
//  Conframe
//
//  Created by Austin Robert Bales on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HeaderBar.h"


@implementation HeaderBar

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithPatternImage:[NSImage imageNamed:@"header-background.png"]] set];
    NSRectFill (dirtyRect);
}

@end
