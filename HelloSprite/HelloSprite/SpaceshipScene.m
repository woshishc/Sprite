//
//  SpaceshipScene.m
//  HelloSprite
//
//  Created by suhc on 15/12/19.
//  Copyright © 2015年 kongjianjia. All rights reserved.
//

#import "SpaceshipScene.h"

static NSString *ROCK = @"rock";

@interface SpaceshipScene ()
{
    BOOL contentCreated;
}
@end
@implementation SpaceshipScene

- (void)didMoveToView:(SKView *)view{
    if (!contentCreated) {
        [self createSceneContents];
        contentCreated = YES;
    }
}

- (void)createSceneContents{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceShip = [self newSpaceShip];
    [self addChild:spaceShip];
    
    //制造大量岩石
    SKAction *action0 = [SKAction performSelector:@selector(addRock) onTarget:self];
    SKAction *action1 = [SKAction waitForDuration:0.10 withRange:0.15];
    SKAction *makeRocks = [SKAction sequence:@[action0,action1]];
    [self runAction:[SKAction repeatActionForever:makeRocks]];
}

static inline CGFloat skRandf(){
    return rand()/(CGFloat)RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf()*(high - low) + low;
}

- (void)addRock{
//    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(10, 10)];
    SKTexture *rocketTexture = [SKTexture textureWithImageNamed:@"snow.png"];
    
//    SKSpriteNode *rock = [SKSpriteNode spriteNodeWithImageNamed:@"snow.png"];
    for (int i = 0; i < 1; i++) {
        SKSpriteNode *rock = [SKSpriteNode spriteNodeWithTexture:rocketTexture];
        rock.position = CGPointMake(skRand(0, self.size.width),self.size.height);
        rock.name = ROCK;
        rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
        rock.physicsBody.usesPreciseCollisionDetection = YES;
        [self addChild:rock];
    }
    
}

- (SKSpriteNode *)newSpaceShip{
    //创建船体
//    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(60, 120)];
    SKSpriteNode *hull = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship.png"];
    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic = NO;
    hull.blendMode = SKBlendModeAdd;
    hull.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    //添加移动的动画
    SKAction *action0 = [SKAction waitForDuration:1.0];
    SKAction *action1 = [SKAction moveByX:100.0 y:0.0 duration:1.0];
    SKAction *action2 = [SKAction waitForDuration:1.0];
    SKAction *action3 = [SKAction moveByX:-100.0 y:-0.0 duration:1.0];
    SKAction *action4 = [SKAction waitForDuration:1.0];
    SKAction *action5 = [SKAction moveByX:-100.0 y:-0.0 duration:1.0];
    SKAction *action6 = [SKAction waitForDuration:1.0];
    SKAction *action7 = [SKAction moveByX:100.0 y:0.0 duration:1.0];
    SKAction *hover = [SKAction sequence:@[action0,action1,action2,action3,action4,action5,action6,action7]];
    [hull runAction:[SKAction repeatActionForever:hover]];
    
    //添加颜色变化的动画
    SKAction *action8 = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:1];
    SKAction *action9 = [SKAction waitForDuration:0.1];
    SKAction *action10 = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.2 duration:1];
    SKAction *action11 = [SKAction waitForDuration:0.1];
    SKAction *pulseRed = [SKAction sequence:@[action8,action9,action10,action11]];
    [hull runAction:[SKAction repeatActionForever:pulseRed]];
    
    //添加灯光
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-17.5, 0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(17.5, 0);
    [hull addChild:light2];
    
    return hull;
}

- (SKSpriteNode *)newLight{
    //创建灯光
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
    //设置动画
    SKAction *action0 = [SKAction fadeOutWithDuration:0.25];
    SKAction *action1 = [SKAction fadeInWithDuration:0.25];
    
    SKAction *blink = [SKAction sequence:@[action0,action1]];
    [light runAction:[SKAction repeatActionForever:blink]];
    
    return light;
}

- (void)didSimulatePhysics{
    [self enumerateChildNodesWithName:ROCK usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        if (node.position.y < 0) {
            [node removeFromParent];
        }
    }];
}

@end
