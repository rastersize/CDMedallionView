// CDMedallionView.m
//
// Copyright (c) 2012 Aron Cedercrantz
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "CDMedallionView.h"


#pragma mark CDMedallionView Private Interface
@interface CDMedallionView (/*Private*/)

#pragma mark - Initializtion and Set Up
- (void)setUp;


#pragma mark - Medallion Image
// The gradient used to draw the shine
@property (strong) NSGradient *shineGradient;

@end


#pragma mark - CDMedallionView Implementation
@implementation CDMedallionView

#pragma mark - Initializtion and Set Up
- (id)init
{
	self = [self initWithFrame:NSMakeRect(0, 0, 128.f, 128.f)];
	return self;
}

- (id)initWithFrame:(NSRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setUp];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setUp];
	}
	return self;
}

- (void)setUp
{
	_addShine = YES;
	NSArray *shineGradientColors = [NSArray arrayWithObjects:
									[[NSColor whiteColor] colorWithAlphaComponent:.45f],
									[[NSColor whiteColor] colorWithAlphaComponent:0.f],
									[[NSColor whiteColor] colorWithAlphaComponent:0.f],
									nil];
	CGFloat shineGradientColorLocations[3] = {1.f, 0.2f, 0.f};
	_shineGradient = [[NSGradient alloc] initWithColors:shineGradientColors atLocations:shineGradientColorLocations colorSpace:[NSColorSpace deviceGrayColorSpace]];
	
	_borderWidth = 4.f;
	_borderColor = [NSColor whiteColor];
	_borderGradient = nil;
	
	_shadow = [[NSShadow alloc] init];
	[_shadow setShadowColor:[NSColor colorWithCalibratedWhite:.25f alpha:.75f]];
	[_shadow setShadowBlurRadius:2.f];
	[_shadow setShadowOffset:NSMakeSize(0, -1)];
}


#pragma mark - State Restoration
+ (NSArray *)restorableStateKeyPaths
{
	static NSArray *restorableStateKeyPaths = nil;
	static dispatch_once_t restorableStateKeyPathsToken;
	dispatch_once(&restorableStateKeyPathsToken, ^{
		NSArray *superRestorableStateKeyPaths = [super restorableStateKeyPaths];
		NSArray *localRestorableStateKeyPahts = @[ @"imageScaling", @"borderWidth", @"borderColor", @"borderGradient", @"addShine", @"shadow" ];
		restorableStateKeyPaths = [superRestorableStateKeyPaths arrayByAddingObjectsFromArray:localRestorableStateKeyPahts];
	});
	return restorableStateKeyPaths;
}


#pragma mark - Drawing
- (void)drawRect:(NSRect)dirtyRect
{
	[[NSGraphicsContext currentContext] saveGraphicsState];
	
	NSRect bounds = self.bounds;
	CGFloat borderWidth = self.borderWidth;
	NSShadow *shadow = self.shadow;
	
	CGFloat shadowSize = MAX(fabs(shadow.shadowOffset.height) * shadow.shadowBlurRadius,
							 fabs(shadow.shadowOffset.width) * shadow.shadowBlurRadius);
	NSRect borderRect = NSMakeRect(borderWidth / 2.f + shadowSize,
								   borderWidth / 2.f + shadowSize,
								   bounds.size.width - (borderWidth + shadowSize * 2.f),
								   bounds.size.height - (borderWidth + shadowSize * 2.f));
	
	NSBezierPath *medallionPath = [NSBezierPath bezierPathWithOvalInRect:borderRect];
	[medallionPath setLineWidth:borderWidth];
	
	[[NSGraphicsContext currentContext] saveGraphicsState];
	[medallionPath setClip];
	
	// Draw image
	[super drawRect:dirtyRect];
	
	// Draw shine
	if (self.addShine) {
		[[NSGraphicsContext currentContext] saveGraphicsState];
		// Draw shine as a sharp gradient
		//   __
		//  / /\
		//  \__/
		NSPoint shineStartStopPoint = NSZeroPoint;
		NSBezierPath *shinePath = [[NSBezierPath alloc] init];
		[shinePath moveToPoint:shineStartStopPoint];
		NSPoint shinePathPoints[4] = {
			shineStartStopPoint,
			NSMakePoint(bounds.size.width, bounds.size.height),
			NSMakePoint(0, bounds.size.height),
			shineStartStopPoint
		};
		[shinePath appendBezierPathWithPoints:shinePathPoints count:4];
		[shinePath closePath];
		[shinePath addClip];
		
		[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositeSourceOver];
		[self.shineGradient drawInRect:bounds angle:90.f];
		
		// Draw highlight
		NSPoint highlightStartStopPoint = NSMakePoint(0, bounds.size.height / 2);
		NSBezierPath *highlightPath = [[NSBezierPath alloc] init];
		[highlightPath moveToPoint:highlightStartStopPoint];
		NSPoint highlightPathPoints[4] = {
			NSMakePoint(NSMidX(bounds), NSMidY(bounds)),
			NSMakePoint(bounds.size.width, bounds.size.height),
			NSMakePoint(0, bounds.size.height),
			highlightStartStopPoint
		};
		[highlightPath appendBezierPathWithPoints:highlightPathPoints count:4];
		[highlightPath closePath];
		[highlightPath addClip];
		
		NSColor *highlightStartingColor = [NSColor colorWithCalibratedWhite:1.f alpha:.1f];
		NSColor *highlightEndingColor = [highlightStartingColor colorWithAlphaComponent:0.f];
		NSGradient *highlightGradient = [[NSGradient alloc] initWithStartingColor:highlightStartingColor endingColor:highlightEndingColor];
		NSPoint centerPoint = NSMakePoint(0.f, 1.f);
		NSRect highlightRect = NSMakeRect(bounds.origin.x,
										  bounds.size.height / 2,
										  bounds.size.width,
										  bounds.size.height / 2);
		
		[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositePlusLighter];
		[highlightGradient drawInRect:highlightRect relativeCenterPosition:centerPoint];
		
		[[NSGraphicsContext currentContext] restoreGraphicsState];
	}
	[[NSGraphicsContext currentContext] restoreGraphicsState];
	
	// Draw medallion
	[shadow set];
	if (self.borderGradient) {
		[self.borderGradient drawInBezierPath:medallionPath angle:180.f];
	} else {
		[self.borderColor set];
		[medallionPath stroke];
	}
	
	[[NSGraphicsContext currentContext] restoreGraphicsState];
}


#pragma mark - Medallion Border
@synthesize borderColor = _borderColor;
@synthesize borderGradient = _borderGradient;
@synthesize borderWidth = _borderWidth;

- (void)setBorderColor:(NSColor *)borderColor
{
	if (borderColor != _borderColor) {
		_borderColor = borderColor;
		[self setNeedsDisplay:YES];
	}
}

- (NSColor *)borderColor
{
	return _borderColor;
}

- (void)setBorderGradient:(NSGradient *)borderGradient
{
	if (borderGradient != _borderGradient) {
		_borderGradient = borderGradient;
		[self setNeedsDisplay:YES];
	}
}

- (NSGradient *)borderGradient
{
	return _borderGradient;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
	if (borderWidth != _borderWidth) {
		_borderWidth = borderWidth;
		[self setNeedsDisplay:YES];
	}
}

- (CGFloat)borderWidth
{
	return _borderWidth;
}

#pragma mark - Medallion Image
@synthesize addShine = _addShine;
@synthesize shineGradient = _shineGradient;

- (void)setAddShine:(BOOL)addShine
{
	if (addShine != _addShine) {
		_addShine = addShine;
		[self setNeedsDisplay:YES];
	}
}

- (BOOL)shouldAddShine
{
	return _addShine;
}

#pragma mark - View Shadow
@synthesize shadow = _shadow;

- (void)setShadow:(NSShadow *)shadow
{
	if (shadow != _shadow) {
		_shadow = shadow;
		[self setNeedsDisplay:YES];
	}
}

- (NSShadow *)shadow
{
	return _shadow;
}


@end

