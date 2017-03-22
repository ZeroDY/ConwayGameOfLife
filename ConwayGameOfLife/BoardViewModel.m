//
//  BoardViewModel.m
//  ConwayGameOfLife
//
//  Created by 周德艺 on 2017/3/22.
//  Copyright © 2017年 周德艺. All rights reserved.
//

#import "BoardViewModel.h"

@implementation BoardViewModel

- (instancetype)initWithSide:(int)side{
    self = [super init];
    if (self) {
        [self resetArrayWithCount:side];
    }
    return self;
}

- (void)resetByType:(ResetType)type{
    self.type = type;
    self.steps = 0;
    self.lives = 0;

    switch (type) {
        case ResetTypeRandom:
            for (int i = 0; i < self.array.count; i++) {
                for (int j = 0; j < self.array.count; j++) {
                    if (arc4random() % 100 < 20) {
                        self.array[i][j] = @1;
                        self.lives ++;
                    }else{
                        self.array[i][j] = @0;
                    }
                }
            }
            break;
            
        case ResetTypeLine:
            for (int i = 0; i < self.array.count; i++) {
                for (int j = 0; j < self.array.count; j++) {
                        self.array[i][j] = @0;
                }
            }
            for (int i = 1; i < 5; i++) {
                self.array[self.array.count/2 - i][self.array[0].count/2] = @1;
                self.array[self.array.count/2 + i][self.array[0].count/2] = @1;
            }
            self.array[self.array.count/2 - 5][self.array[0].count/2] = @1;
            self.array[self.array.count/2][self.array[0].count/2] = @1;
            self.lives = 10;
            break;
            
        default:
            for (int i = 0; i < self.array.count; i++) {
                for (int j = 0; j < self.array.count; j++) {
                    self.array[i][j] = @0;
                }
            }
            break;
    }
}

- (void)resetArrayWithCount:(NSInteger)count{
    if (count < 20) {
        count = 20;
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:count];
        [array addObject: rowArray];
    }
    self.array = array;
}

- (void)goToSteps:(NSInteger)steps{
    if (self.steps > steps) {
        [self resetByType:self.type];
    }
    while (self.steps < steps) {
        [self nextStep];
    }
}

- (void)nextStep{
    
    NSInteger m = self.array.count;
    NSInteger n = self.array[0].count;
    
    int dx[] = {-1, -1, -1, 0, 1, 1, 1, 0};
    int dy[] = {-1, 0, 1, 1, 1, 0, -1, -1};
    
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            int liveCount = 0;
            for (int k = 0; k < 8; ++k) {
                int x = i + dx[k], y = j + dy[k];
                //边界处理，左右连接，上下镜像
                if(x < 0){
                    x = (int)m - 1;
                }else if (x >= m){
                    x = 0;
                }
                
                if (y < 0) {
                    y = 0;
                }else if (y >= n){
                    y = (int)n - 1;
                }
                
                if(self.array[x][y].intValue == 1 || self.array[x][y].intValue == 2){
                    liveCount ++;
                }
            }
            
            if(self.array[i][j].intValue == 0 && liveCount == 3){
                self.array[i][j] = @3;
            } else if(self.array[i][j].intValue == 1){
                if(liveCount < 2 || liveCount > 3){
                    self.array[i][j] = @2;
                }
            }
        }
    }
    
    self.steps ++;
    self.lives = 0;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            self.array[i][j] = @(self.array[i][j].intValue % 2);
            self.lives += self.array[i][j].intValue;
        }
    }
    
}


@end
