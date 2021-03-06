//
//  CDAppDelegate.m
//  Medallion Test App
//
//  Created by Aron Cedercrantz on 22-11-2012.
//  Copyright (c) 2012 Aron Cedercrantz. All rights reserved.
//

#import "CDAppDelegate.h"

@implementation CDAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	self.smallMedallionView.borderWidth = 2.f;
	self.smallMedallionView.addShine = YES;
	
	self.mediumMedallionView.borderWidth = 3.f;
	self.mediumMedallionView.addShine = YES;
	
	self.largeMedallionView.addShine = YES;
}

- (void)toggleShine:(NSButton *)sender
{
	BOOL addShine = (sender.state == NSOnState);
	self.smallMedallionView.addShine = addShine;
	self.mediumMedallionView.addShine = addShine;
	self.largeMedallionView.addShine = addShine;
}

@end
