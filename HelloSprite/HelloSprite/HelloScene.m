//
//  HelloScene.m
//  HelloSprite
//
//  Created by suhc on 15/12/18.
//  Copyright © 2015年 kongjianjia. All rights reserved.
//

#import "HelloScene.h"
#import "SpaceshipScene.h"

static NSString *HELLONODE = @"helloNode";

@interface HelloScene ()
{
    BOOL contentCreated;
}
@end
@implementation HelloScene

- (void)didMoveToView:(SKView *)view{
    if (!contentCreated) {
        [self createSceneContents];
        contentCreated = YES;
    }
}

- (void)createSceneContents{
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    [self addChild:[self newHelloNode]];
}

- (SKLabelNode *)newHelloNode{
    SKLabelNode *helloNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    helloNode.text = @"Hello,Sprite!";
    helloNode.name = HELLONODE;
    helloNode.fontSize = 24;
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    return helloNode;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SKNode *helloNode = [self childNodeWithName:HELLONODE];
    if (helloNode) {
        helloNode.name = nil;
        SKAction *moveUp = [SKAction moveByX:0 y:100 duration:0.5];
        SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
        SKAction *pause = [SKAction waitForDuration:0.5];
        SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];

        SKAction *moveSequence = [SKAction sequence:@[moveUp,zoom,pause,fadeAway,remove]];
        
        [helloNode runAction:moveSequence completion:^{
            SpaceshipScene *spaceshipScene = [[SpaceshipScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:spaceshipScene transition:doors];
        }];
    }
}

@end
