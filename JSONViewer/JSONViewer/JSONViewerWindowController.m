//
//  JSONViewerWindowController.m
//  JSONViewer
//
//  Created by Randy Luecke on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONViewerWindowController.h"
#import "AppDelegate.h"

@implementation JSONViewerWindowController

@synthesize textView;
@synthesize rootNode;
@synthesize outlineView;
@synthesize sv;
@synthesize tvsv;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        dictValueStrings = [NSMutableArray arrayWithCapacity:1];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)close
{
    [[NSApp delegate] removeController:self];
}

- (IBAction)viewJSON:(id)sender
{
    NSData *data = [self.textView.string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    id value = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error)
    {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Error parsing JSON" defaultButton:@"Damn that sucks" alternateButton:nil otherButton:nil informativeTextWithFormat:@"Check your JSON"];
        [alert beginSheetModalForWindow:self.window modalDelegate:nil didEndSelector:nil contextInfo:nil];
        return;
    }

    content = value;

    [sv setFrame:[self.tvsv frame]];
    [self.window.contentView addSubview:sv];
    [self.tvsv removeFromSuperview];
    [outlineView reloadData];
    [sender removeFromSuperview];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)node
{
    if (!node)
        return 1;


    if ([node isKindOfClass:[NSArray class]] || [node isKindOfClass:[NSDictionary class]])
        return [node count];
    else
        return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)node
{
    if (!node)
        return content;

    if ([node isKindOfClass:[NSDictionary class]])
    {
        NSArray *keys = [node allKeys];
        id value = [node objectForKey:[keys objectAtIndex:index]];
        
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]])
            return value;
        else
        {
            /*
             NSOutlineView keeps a weak reference to nodes in the outlineview.
             Because of this, we can't just return a newly created string, we have to keep it around
             somewhere. So we construct the new string, see if we've already got a string equal to that
             and if we do, return that reference... othewise, keep the new string arround for future
             use. It sucks, but that's what we gotta do.
             
             Radar #10795076
            */
            NSString *newValue = [NSString stringWithFormat:@"%@: %@", [keys objectAtIndex:index], value];
            NSInteger index = [dictValueStrings indexOfObject:newValue];
            
            if(index != NSNotFound)
                newValue = [dictValueStrings objectAtIndex:index];
            else
                [dictValueStrings addObject:newValue];

            return newValue;
        }
    }
    else
        return [node objectAtIndex:index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
    if ([item isKindOfClass:[NSArray class]])
        return [NSString stringWithFormat:@"Array: %d item%@", [item count], [item count] == 1 ? @"" : @"s" ];
    else if ([item isKindOfClass:[NSDictionary class]])
        return [NSString stringWithFormat:@"Dictionary: %d item%@", [item count], [item count] == 1 ? @"" : @"s" ];
    else
        return item;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    //return NO;
    return ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]]) && [item count];
}

@end
