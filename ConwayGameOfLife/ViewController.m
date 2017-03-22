//
//  ViewController.m
//  ConwayGameOfLife
//
//  Created by 周德艺 on 2017/3/22.
//  Copyright © 2017年 周德艺. All rights reserved.
//

#import "ViewController.h"
#import "BoardView.h"
#import "BoardViewModel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet BoardView *boardView;

@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

@property (weak, nonatomic) IBOutlet UILabel *livesLabel;

@property (weak, nonatomic) IBOutlet UIButton *runBtn;

@property (nonatomic, strong) BoardViewModel *viewModel;

@property (nonatomic, strong) dispatch_source_t sourceTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[BoardViewModel alloc] initWithSide:20];
    [self resetByType:ResetTypeRandom];
}

/**
 刷新页面
 */
- (void)refreshView{
    [self.boardView refreshView:self.viewModel.array];
    self.stepsLabel.text = [NSString stringWithFormat:@"Steps : %ld",self.viewModel.steps];
    self.livesLabel.text = [NSString stringWithFormat:@"Lives : %ld",self.viewModel.lives];
}


/**
 重置模板
 */
- (void)resetByType:(ResetType)type{
    [self stopRun];
    [self.viewModel resetByType:type];
    [self refreshView];
}

- (IBAction)randomResetAction:(UIButton *)sender {
    [self resetByType:ResetTypeRandom];
}

- (IBAction)lineResetAction:(UIButton *)sender {
    [self resetByType:ResetTypeLine];
}

/**
 NextStep
 */
- (IBAction)nextStepAction:(id)sender {
    [self stopRun];
    [self.viewModel nextStep];
    [self refreshView];
}

/**
 GotoStep
 */
- (IBAction)gotoStepsAction:(UIButton *)sender {
    [self stopRun];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Goto n steps" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"steps";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Goto" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *textField = alertController.textFields.firstObject;
        NSInteger steps = textField.text.integerValue;
        [self.viewModel goToSteps:steps];
        [self refreshView];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


/**
 Run or stop
 */
- (IBAction)runOrStopAction:(UIButton *)sender {
    if (sender.selected) {
        dispatch_cancel(self.sourceTimer);
        [sender setTitle:@"Run" forState:UIControlStateNormal];
    }else{
        self.sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0);
        dispatch_source_set_timer(self.sourceTimer, start, (int64_t)(0.2 * NSEC_PER_SEC), 0);
        
        dispatch_source_set_event_handler(self.sourceTimer, ^{
            [self.viewModel nextStep];
            [self refreshView];
        });
        
        dispatch_resume(self.sourceTimer);
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
}

- (void)stopRun{
    if (self.runBtn.selected) {
        dispatch_cancel(self.sourceTimer);
        self.runBtn.selected = NO;
        [self.runBtn setTitle:@"Run" forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
