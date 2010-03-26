//
//  FastTableViewCell.m
//  DocLookup
//
//  Created by Kenji Hollis on 3/5/09.
//  Copyright 2009 Bitgate Mobile, LLC.. All rights reserved.
//

#import "FastTableViewCell.h"


@interface FastTableViewCellView : UIView
@end

@implementation FastTableViewCellView

- (void)drawRect:(CGRect)r
{
	[(FastTableViewCell *)[self superview] drawContentView:r];
}

@end


@implementation FastTableViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		contentView = [[FastTableViewCellView alloc] initWithFrame:CGRectZero];
		contentView.opaque = YES;
		[self addSubview:contentView];
		[contentView release];
    }
    return self;
}

- (void)setFrame:(CGRect)f
{
	[super setFrame:f];
	CGRect b = [self bounds];
	b.size.height -= 1; // leave room for the seperator line
	[contentView setFrame:b];
}

- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[contentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)r
{
	// subclasses should implement this
}

- (void)dealloc {
    [super dealloc];
}


@end
