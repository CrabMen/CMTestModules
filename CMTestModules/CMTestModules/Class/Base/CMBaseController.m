//
//  CMBaseController.m
//  CMTestModules
//
//  Created by 智借iOS on 2018/7/25.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMBaseController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreMotion/CoreMotion.h>
#import <AVFoundation/AVFoundation.h>

#import "CMTestModulesConfigController.h"
@interface CMBaseController ()<UIAccelerometerDelegate>

/***/
@property (nonatomic,strong) CMMotionManager *motionManager;


@end

@implementation CMBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self supportShakeToEdit];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self resignFirstResponder];
    
    
}


- (void)showAlert {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"请问您是否要前往配置相关调试功能" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController pushViewController:[CMTestModulesConfigController new] animated:YES];
    
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:okAction];
    [alertVC addAction:cancelAction];
    
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


- (void)supportShakeToEdit {
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    
    NSError *sessionError = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback  error:&sessionError];
    
}




/*
 在需要支持摇动的controller中调用该方法即可
 **/
- (void)motionManagerConfig {
    
    self.motionManager= [[CMMotionManager alloc]init];//一般在viewDidLoad中进行
    self.motionManager.accelerometerUpdateInterval = 1;
    
    [self startAccelerometer];

}

-(void)startAccelerometer {
    
    //以push的方式更新并在block中接收加速度
    
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init] withHandler:^(CMAccelerometerData*accelerometerData,NSError*error) {
        
    [self outputAccelertionData:accelerometerData.acceleration];
        
        if(error) {
            
            NSLog(@"motion error:%@",error);
            
        }
        
    }];
    
}


-(void)outputAccelertionData:(CMAcceleration)acceleration {
    
    //综合3个方向的加速度
    
    double accelerameter =sqrt( pow( acceleration.x,2) + pow( acceleration.y,2) + pow( acceleration.z,2) );
    
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    
    if(accelerameter>2.3f) {
        
        //立即停止更新加速仪（很重要！）
        
        [self.motionManager stopAccelerometerUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类
            
        });
        
    }
    
}


//暂先这么写，耦合性太强，后期会放到CMTestModulesManager类中
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    

    //检测到摇动
    NSLog(@"***摇动开始****");
    

    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

}



- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    //摇动取消
    NSLog(@"***摇动取消****");

}



- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        AudioServicesPlaySystemSound((uint32_t)1000);

        //something happens
        NSLog(@"***摇动结束****");
        
        [self showAlert];

        
    }
    
}


@end
