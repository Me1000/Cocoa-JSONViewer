//
//  AppDelegate.m
//  JSONViewer
//
//  Created by Randy Luecke on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "JSONViewerWindowController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    windowControllers = [NSMutableArray arrayWithCapacity:1];
}

- (IBAction)newWindow:(id)sender
{
    JSONViewerWindowController *controller = [[JSONViewerWindowController alloc] initWithWindowNibName:@"JSONViewerWindow"];
    [controller showWindow:self];
    [windowControllers addObject:controller];
}

- (void)removeController:(NSWindowController *)controller
{
    [windowControllers removeObject:controller];
}

@end
