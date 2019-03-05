//
//  BCClub.m
//  CardSharp
//
//  Created by Robert Stearn on 22/05/2012.
//  Copyright (c) 2012 All rights reserved.
//

#import "BJClub.h"

#define PI 22/7
#define max CGRectGetMaxX(self.bounds)
#define mix CGRectGetMidX(self.bounds)
#define lox CGRectGetMinX(self.bounds)
#define may CGRectGetMaxY(self.bounds)
#define miy CGRectGetMidY(self.bounds)
#define loy CGRectGetMinY(self.bounds)

@implementation BJClub

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSaveGState(currentContext);
	CGContextSetRGBStrokeColor(currentContext, 0.0, 0.0, 0.0, 1.0);
	CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
	UIBezierPath *heartPath = [UIBezierPath bezierPath];
	[heartPath setLineWidth:1];
	[heartPath addArcWithCenter:CGPointMake(max * 0.725, may * 0.659) radius:max * 0.275 startAngle:4.714 endAngle:	2.566 clockwise:YES];
	[heartPath addArcWithCenter:CGPointMake(max * 0.275, may * 0.659) radius:max * 0.275 startAngle:0.593 endAngle:	4.714 clockwise:YES];
	[heartPath addArcWithCenter:CGPointMake(mix, may * 0.341) radius:max * 0.275 startAngle:2.479 endAngle:0.558 clockwise:YES];
	[heartPath closePath];
	[heartPath fill];
	
	UIBezierPath *footPath = [UIBezierPath bezierPath];
	[footPath addArcWithCenter:CGPointMake(max*0.275, may*0.775) radius:max*0.225 startAngle:0.0 endAngle:1.571 clockwise:YES];
	[footPath addLineToPoint:CGPointMake(max*0.725, may * 0.963 )];
	[footPath addArcWithCenter:CGPointMake(max*0.725, may*0.775) radius:max*0.225 startAngle:1.571 endAngle:3.142 clockwise:YES];
	[footPath closePath];
	[footPath fill];
	CGContextRestoreGState(currentContext);
}


@end
