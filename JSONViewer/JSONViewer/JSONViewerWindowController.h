//
//  JSONViewerWindowController.h
//  JSONViewer
//
//  Created by Randy Luecke on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JSONViewerWindowController : NSWindowController<NSOutlineViewDelegate, NSOutlineViewDataSource>
{
    id content;
    NSMutableArray *dictValueStrings;
}

@property(strong) IBOutlet NSTextView *textView;
@property(strong) IBOutlet NSOutlineView *outlineView;
@property(strong) IBOutlet NSScrollView *sv;
@property(strong) id rootNode;
@property(strong) IBOutlet NSScrollView *tvsv;

- (IBAction)viewJSON:(id)sender;

@end
