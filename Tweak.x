#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

// 1. هيكل بيانات الكرة وموقعها
typedef struct {
    CGPoint position;
    CGPoint velocity;
    int ballID;
    BOOL isSolid;
} PoolBall;

// 2. تعريف واجهة الكلاس ليفهمها المترجم (Interface)
@interface PhysicsEngineClass : NSObject
- (PoolBall *)getBallDataAtIndex:(int)index;
- (void)drawTrajectoryLineForBall:(PoolBall *)ball withPower:(float)power showBounce:(BOOL)showBounce;
@end

// 3. Hook لمكالمة تحديث الفيزياء ورسم مسارات الكرات
%hook PhysicsEngineClass

- (void)updatePhysicsAndDrawLines:(void *)ballsArray force:(float)hitForce angle:(float)hitAngle {
    %orig;

    float customPower = hitForce * 1.5f;

    for (int i = 0; i < 15; i++) {
        PoolBall *ball = [self getBallDataAtIndex:i];
        
        if (ball && ball->position.x != 0) {
            [self drawTrajectoryLineForBall:ball 
                                  withPower:customPower 
                                 showBounce:YES];
        }
    }
}

%end

// 4. Hook لتفعيل عرض خطوط المسارات لجميع الكرات
%hook GuidelineManager

- (BOOL)shouldDrawExtendedLines {
    return YES;
}

- (BOOL)showAllBallsTrajectory {
    return YES;
}

%end
