//
//  AppDelegate.h
//  JSONViewer
//
//  Created by Randy Luecke on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSMutableArray *windowControllers;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)newWindow:(id)sender;

@end
