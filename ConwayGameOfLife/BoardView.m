//
//  BoardView.m
//  ConwayGameOfLife
//
//  Created by 周德艺 on 2017/3/22.
//  Copyright © 2017年 周德艺. All rights reserved.
//

#import "BoardView.h"

@interface BoardView ()

@property (nonatomic, assign) NSInteger side;

@property (nonatomic, strong) NSMutableArray <NSMutableArray <NSNumber *> *> *boardArray;

@end

@implementation BoardView


/**
 RefreshView

 @param array 2d array
 */
- (void)refreshView:(NSMutableArray<NSMutableArray<NSNumber *> *> *)array{
    self.side = array.count;
    self.boardArray = array;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat marginW = rect.size.width / self.side;
    [self drawCellRect:context width:marginW array:self.boardArray];
    
    [[UIColor whiteColor] set];
    CGContextSetLineWidth(context, 0.5);
    CGFloat endX = rect.origin.x + rect.size.width;
    CGFloat endY = rect.origin.y + rect.size.height;
    for (int i = 1; i < self.side; i++) {
        CGContextMoveToPoint(context, 0, marginW * i);
        CGContextAddLineToPoint(context, endX, marginW * i);
        
        CGContextMoveToPoint(context, marginW * i, 0);
        CGContextAddLineToPoint(context, marginW * i, endY);
    }
    
    CGContextStrokePath(context);
}


- (void)drawCellRect:(CGContextRef)contextRef
               width:(CGFloat)marginW
               array:(NSArray <NSArray *> *)array {
    UIColor *liveColor = [UIColor colorWithRed:0.50 green:0.85 blue:0.98 alpha:1.00];
    UIColor *deadColor = [UIColor groupTableViewBackgroundColor];
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j < array[i].count; j++) {
            NSNumber *isLive = array[i][j];
            CGContextAddRect(contextRef, CGRectMake(marginW * i, marginW * j, marginW, marginW));
            if (isLive.intValue) {
                CGContextSetFillColorWithColor(contextRef, liveColor.CGColor);
            }else{
                CGContextSetFillColorWithColor(contextRef, deadColor.CGColor);
            }
            CGContextFillPath(contextRef);
        }
    }
}

@end
