## Beautiful Transitions Made Easy

Transform entities effortlessly with a variety of popular transitions:

| Transition         | Description                                      |
|--------------------|--------------------------------------------------|
| **Linear**         | A constant speed transition.                    |
| **EaseIn**         | Starts slow and accelerates.                    |
| **EaseOut**        | Starts fast and decelerates.                    |
| **EaseInOut**      | Starts and ends slow, with acceleration in between. |
| **EaseInCubic**    | A cubic easing function that starts slow and accelerates. |
| **EaseOutCubic**   | A cubic easing function that starts fast and decelerates. |
| **EaseInOutCubic** | A cubic easing function that starts and ends slow, with acceleration in between. |
| **ElasticIn**      | Bounces in with an elastic effect.              |
| **ElasticOut**     | Bounces out with an elastic effect.             |
| **ElasticInOut**   | Combines both in and out elastic effects.       |
| **BounceIn**       | Bounces in with a spring-like effect.           |
| **BounceOut**      | Bounces out with a spring-like effect.          |
| **BounceInOut**    | Combines both in and out bouncing effects.      |


| Rotation         | Type                                      |
|--------------------|--------------------------------------------------|
| **Default**         | Shortest path.                    |
| **clockwise**         | Rotates clockwise.                    |
| **counterclockwise**        |Rotatess counterclockwise.                    |


Enhance the visual appeal of your applications with these smooth transitions!
## Preview
# MoveEntity
```lua
local pos = vec3(0.0,0.0,2.0) 
exports.rw_transform:TransitionEntity("Linear",entity,pos,2)

MoveEntity(transitionName, entity, targetPosition, duration)
```
![transform](https://github.com/user-attachments/assets/30a9f8fc-eaa2-4b34-93dc-bdfe362a0fe6)
# RotateEntity
```lua
local rad = vec3(0.0,0.0,60.0) 
exports.rw_transform:RotateEntity("Linear",entity,rad,2)

RotateEntity(transitionName, entity, targetRotation, duration)
Default to shortest path
or
RotateEntity(transitionName, entity, targetRotation, duration,"counterclockwise")
```
![rotate](https://github.com/user-attachments/assets/11c3ac2c-fd53-439f-b74b-a9ef35b1c1bc)
# TransitionEntity
```lua
local rad = vec3(0.0,0.0,60.0) 
local pos = vec3(0.0,0.0,2.0) 
exports.rw_transform:TransitionEntity("Linear",entity,rad,pos,2)

TransitionEntity(transitionName, entity, targetRotation, targetPosition, duration)
Default to shortest path
or
TransitionEntity(transitionName, entity, targetRotation, targetPosition, duration,"clockwise")
```
![transform rotate](https://github.com/user-attachments/assets/6785f8a9-98eb-4eaa-8111-60f28d0c75b3)

# CubicBezier 
https://cubic-bezier.com/#1,0,.63,.44
```lua
BezierRotateEntity(x1,y1,x2,y2, entity, targetRotation, duration,"clockwise")
BezierMoveEntity(x1,y1,x2,y2, entity, targetPosition, duration)
BezierTransitionCubicBezier(x1,y1,x2,y2,entity,targetRotation,targetPosition,duration,"clockwise")
```
