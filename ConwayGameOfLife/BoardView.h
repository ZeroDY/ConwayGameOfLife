//
//  BoardView.h
//  ConwayGameOfLife
//
//  Created by 周德艺 on 2017/3/22.
//  Copyright © 2017年 周德艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UIView

- (void)refreshView:(NSMutableArray<NSMutableArray<NSNumber *> *> *)array;

@end
