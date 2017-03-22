//
//  BoardViewModel.h
//  ConwayGameOfLife
//
//  Created by 周德艺 on 2017/3/22.
//  Copyright © 2017年 周德艺. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ResetType)
{
    ResetTypeRandom = 0,
    ResetTypeLine,
};

@interface BoardViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <NSMutableArray <NSNumber *> *> *array;

@property (nonatomic, assign) NSInteger steps;

@property (nonatomic, assign) NSInteger lives;

@property (nonatomic, assign) ResetType type;

- (instancetype)initWithSide:(int)side;

- (void)resetByType:(ResetType)type;

- (void)nextStep;

- (void)goToSteps:(NSInteger)steps;


@end
