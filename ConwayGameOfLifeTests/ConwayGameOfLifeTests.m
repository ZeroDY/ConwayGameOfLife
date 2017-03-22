//
//  ConwayGameOfLifeTests.m
//  ConwayGameOfLifeTests
//
//  Created by 周德艺 on 2017/3/22.
//  Copyright © 2017年 周德艺. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BoardViewModel.h"

@interface ConwayGameOfLifeTests : XCTestCase

@property (nonatomic, strong) BoardViewModel *model;

@property (nonatomic, strong) BoardViewModel *testModel;

@end

@implementation ConwayGameOfLifeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.model = [[BoardViewModel alloc] initWithSide:20];
    
    self.testModel = [BoardViewModel new];
    NSMutableArray *testArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (int j = 0; j < 20; j++) {
            [rowArray addObject:@0];
        }
        [testArray addObject:rowArray];
    }
    self.testModel.array = testArray;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testFunc_resetByType{
    
    [self.model resetByType:ResetTypeLine];
    
    self.testModel.array[5][10] = @1;
    self.testModel.array[6][10] = @1;
    self.testModel.array[7][10] = @1;
    self.testModel.array[8][10] = @1;
    self.testModel.array[9][10] = @1;
    self.testModel.array[10][10] = @1;
    self.testModel.array[11][10] = @1;
    self.testModel.array[12][10] = @1;
    self.testModel.array[13][10] = @1;
    self.testModel.array[14][10] = @1;
    self.testModel.lives = 10;
    self.testModel.steps = 0;
    
    XCTAssertEqualObjects(self.model.array, self.testModel.array, @"resetByType  ResetTypeLine 方法错误！");
    XCTAssertEqual(self.model.lives, self.testModel.lives, @"resetByType  lives 错误！");
    XCTAssertEqual(self.model.steps, self.testModel.steps, @"resetByType  steps 错误！");
}

- (void)testFunc_nextStep{
    
    [self.model resetByType:ResetTypeLine];
    [self.model nextStep];
    
    self.testModel.array[6][9] = @1;
    self.testModel.array[7][9] = @1;
    self.testModel.array[8][9] = @1;
    self.testModel.array[9][9] = @1;
    self.testModel.array[10][9] = @1;
    self.testModel.array[11][9] = @1;
    self.testModel.array[12][9] = @1;
    self.testModel.array[13][9] = @1;
    
    self.testModel.array[6][10] = @1;
    self.testModel.array[7][10] = @1;
    self.testModel.array[8][10] = @1;
    self.testModel.array[9][10] = @1;
    self.testModel.array[10][10] = @1;
    self.testModel.array[11][10] = @1;
    self.testModel.array[12][10] = @1;
    self.testModel.array[13][10] = @1;
    
    self.testModel.array[6][11] = @1;
    self.testModel.array[7][11] = @1;
    self.testModel.array[8][11] = @1;
    self.testModel.array[9][11] = @1;
    self.testModel.array[10][11] = @1;
    self.testModel.array[11][11] = @1;
    self.testModel.array[12][11] = @1;
    self.testModel.array[13][11] = @1;
    
    self.testModel.lives = 24;
    self.testModel.steps = 1;
    
    XCTAssertEqualObjects(self.model.array, self.testModel.array, @"nextStep  方法错误！");
    XCTAssertEqual(self.model.lives, self.testModel.lives, @"nextStep  lives 错误！");
    XCTAssertEqual(self.model.steps, self.testModel.steps, @"nextStep  steps 错误！");
}


- (void)testFunc_goToSteps{
    
    [self.model resetByType:ResetTypeLine];
    [self.model goToSteps:30];
    
    self.testModel.array[7][9] = @1;
    self.testModel.array[12][9] = @1;
    
    self.testModel.array[5][10] = @1;
    self.testModel.array[6][10] = @1;
    self.testModel.array[8][10] = @1;
    self.testModel.array[9][10] = @1;
    self.testModel.array[10][10] = @1;
    self.testModel.array[11][10] = @1;
    self.testModel.array[13][10] = @1;
    self.testModel.array[14][10] = @1;
    
    self.testModel.array[7][11] = @1;
    self.testModel.array[12][11] = @1;
    
    self.testModel.lives = 12;
    self.testModel.steps = 30;
    
    XCTAssertEqualObjects(self.model.array, self.testModel.array, @"goToSteps  方法错误！");
    XCTAssertEqual(self.model.lives, self.testModel.lives, @"goToSteps  lives 错误！");
    XCTAssertEqual(self.model.steps, self.testModel.steps, @"goToSteps  steps 错误！");
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
