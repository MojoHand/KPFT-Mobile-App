//
//  FastFeedCell.m
//

#import "FastFeedCell.h"


@implementation FastFeedCell

@synthesize mainText, subText;

static UIFont *mainTextFont;
static UIFont *mainTextReadFont;
static UIFont *subTextFont;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		if (!mainTextFont) 
		{
			mainTextFont = [UIFont boldSystemFontOfSize:18];
		}
		
		if (!mainTextReadFont) 
		{
			mainTextReadFont = [UIFont systemFontOfSize:18];
		}
		
		if (!subTextFont) 
		{
			subTextFont = [UIFont systemFontOfSize:13];
		}
    }
    return self;
}

- (void)prepareForReuse {
	self.mainText = @"";
	self.subText = @"";
	markedRead = NO;
}

- (void)setMainLabel:(NSString *)label 
{
	self.mainText = label;
	[self setNeedsDisplay];
}

- (void)setSubLabel:(NSString *)label 
{
	self.subText = label;
	[self setNeedsDisplay];
}

- (void)setMarkedRead:(BOOL)yesOrNo 
{
	markedRead = yesOrNo;
	[self setNeedsDisplay];
}

- (void)drawContentView:(CGRect)rect 
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor *textColor = [UIColor whiteColor];
	
	// Apply gradient fill
	CGFloat locations[2] = { 0.0, 0.75 };
	CGFloat components[8] = {0.27, 0.31, 0.38, 1.0, // Start color
							 0.14, 0.18, 0.25, 1.0}; // End color 
	
	if (self.selected) 
	{
		components[0] += 0.10;
		components[1] += 0.10;
		components[2] += 0.10;
		components[4] += 0.10;
		components[5] += 0.10;
		components[6] += 0.10;
	}
	
	CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, 2);
	CGPoint start = CGPointMake(0, 0);
	CGPoint end = CGPointMake(0, rect.size.height);
	CGContextDrawLinearGradient(context, myGradient, start, end, 0);
	
	[textColor set];
	CGSize mainTextSize = [self.mainText sizeWithFont:(markedRead ? mainTextReadFont : mainTextFont) constrainedToSize:CGSizeMake(288, 200) lineBreakMode:UILineBreakModeWordWrap];
	[self.mainText drawInRect:CGRectMake(6, 4, mainTextSize.width, mainTextSize.height) withFont:(markedRead ? mainTextReadFont : mainTextFont)];
	
	[[UIColor lightGrayColor] set];
	[self.subText drawAtPoint:CGPointMake(6, mainTextSize.height + 2) forWidth:288 withFont:subTextFont lineBreakMode:UILineBreakModeTailTruncation];
}


- (void)dealloc 
{
    [super dealloc];
}


@end
