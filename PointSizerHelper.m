//
//  PointSizerHelper.m
//  PointSizer
//
//  Created by Kimberly Barnes on 4/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PointSizerHelper.h"


@implementation PointSizerHelper

const CGFloat kScrollObjHeight	= 411.0;
const CGFloat kScrollObjWidth	= 320.0;

+ (void)finishLoadingView:(UIView *)theView:(UIScrollView *)scrollView:(NSArray *)images:(int)startIndex
{
	theView.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	
	NSUInteger i = 1;
	CGRect sampleRect;
	for (NSString *imageName in images)
	{
		UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		if (i==4) {
			sampleRect = rect;
		}
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = i++;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:imageView];
		[imageView release];
	}
	
	// Set the display on the right page to start
	CGFloat offsetX = kScrollObjWidth * startIndex;
	[scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
	
	UIImageView *view = nil;
	NSArray *subviews = [scrollView subviews];
	
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	[scrollView setContentSize:CGSizeMake((images.count * kScrollObjWidth), kScrollObjHeight)];
	
}




@end
