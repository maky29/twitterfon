//
//  TweetCellView.m
//  TwitterFon
//
//  Created by kaz on 11/2/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import "TweetCellView.h"

@implementation TweetCellView

@synthesize message;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (void)setMessage:(Message*)value
{
    if (message != value) {
		[message release];
		message = [value retain];
	}
    [super setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIColor* textColor;
    UIColor* timestampColor;
    
	UITableViewCell* cell = (UITableViewCell*)self.superview.superview;
	if (cell.selected) {
		textColor       = [UIColor whiteColor];
        timestampColor  = [UIColor lightGrayColor];
	}
	else {
		textColor       = [UIColor blackColor];
        timestampColor  = [UIColor grayColor];
	}
    
    float textFontSize = (message.cellType == MSG_CELL_TYPE_DETAIL) ? 14 : 13;
    
	[textColor set];
    if (message.cellType == MSG_CELL_TYPE_NORMAL) {
        [message.user.screenName drawInRect:CGRectMake(0, 0, CELL_WIDTH - DETAIL_BUTTON_WIDTH, TOP) withFont:[UIFont boldSystemFontOfSize:14]];
    }
	[message.text drawInRect:message.textBounds withFont:[UIFont systemFontOfSize:textFontSize]];
	[timestampColor set];
    if (message.cellType != MSG_CELL_TYPE_NORMAL) {
        NSString *timestamp;
        if ([message.source length]) {
            timestamp = [message.timestamp stringByAppendingFormat:@" from %@", message.source];
        }
        else {
            timestamp = message.timestamp;
        }
        [timestamp drawInRect:CGRectMake(0, message.textBounds.size.height + 3, 250, 16) withFont:[UIFont systemFontOfSize:12]];
    }
    else {
        [message.timestamp drawInRect:CGRectMake(0, TOP + message.textBounds.size.height - 1, 250, 16) withFont:[UIFont systemFontOfSize:12]];
    }
}


- (void)dealloc {
    [message release];
    [super dealloc];
}


@end