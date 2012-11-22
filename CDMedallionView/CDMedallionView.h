// CDMedallionView.h
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

#import <Cocoa/Cocoa.h>


/**
 Draws a medallion (i.e. like the one used on the login screen of OS X Lion) around an arbitrary image.
 
 Use it like you would use any old `NSImageView` and then configure the border.
 */
#pragma mark CDMedallionView Interface
@interface CDMedallionView : NSImageView

#pragma mark - Medallion Border
///-----------------------
/// @name Medallion Border
///-----------------------
/**
 The width, or thickness, of the border.
 
 The default is `4.0` points.
 
 @warning Must be zero (`0.0`) or larger.
 */
@property (assign) CGFloat borderWidth;

/**
 The color of the border.
 
 Defaults to `[NSColor whiteColor]`.
 */
@property (strong) NSColor *borderColor;


#pragma mark - Medallion Image
///----------------------
/// @name Medallion Image
///----------------------
/**
 Whether a shine should be drawn over the image.
 
 The default is `YES`.
 */
// If `YES` adds a shine over the image. Default is `YES`.
@property (assign, getter = shouldAddShine) BOOL addShine;


#pragma mark - View Shadow
///------------------
/// @name View Shadow
///------------------
/**
 The shadow of the view. If `nil` no shadow will be drawn.
 
 The default is a shadow based on a slightly translucent light gray color with a blur radius of 2.0 points with an offset of `[0.0, -1.0]` points (i.e. downwards).
 */
@property (strong) NSShadow *shadow;

@end
