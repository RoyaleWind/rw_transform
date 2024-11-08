--- Performs interpolation of entity's rotation and/or position based on the given transition function.
local function PerformTransition(entity, initialRotation, targetRotation, initialPosition, targetPosition, duration, Bezier, rotationDirection)
    local elapsedTime = 0.0
    local isFrozen = IsEntityPositionFrozen(entity)
    FreezeEntityPosition(entity,true)

    local function CalculateRotation(initial, target, t)
        local result = {}
        for i = 1, 3 do
            local diff = target[i] - initial[i]
            
            -- Adjust for shortest path
            if rotationDirection == "clockwise" then
                if diff > 0 then diff = diff - 360 end
            elseif rotationDirection == "counterclockwise" then
                if diff < 0 then diff = diff + 360 end
            else
                -- Default to shortest path
                if diff > 180 then
                    diff = diff - 360
                elseif diff < -180 then
                    diff = diff + 360
                end
            end
            
            result[i] = initial[i] + (diff * t)
        end
        return result
    end

    while elapsedTime < duration do
        elapsedTime = elapsedTime + GetFrameTime()
        local t = math.min(math.max(elapsedTime / duration, 0), 1)
        local transition = CubicBezier(t,Bezier)

        --- OLD Rotation
        -- if initialRotation and targetRotation then
        --     local rotation = LerpVec3(initialRotation, targetRotation, transition)
        --     SetEntityRotation(entity, rotation.x, rotation.y, rotation.z, 2, true)
        -- end

        if initialRotation and targetRotation then
            local rotation = CalculateRotation(initialRotation, targetRotation, transition)
            SetEntityRotation(entity, rotation[1], rotation[2], rotation[3], 2, true)
        end

        if initialPosition and targetPosition then
            local position = LerpVec3(initialPosition, targetPosition, transition)
            SetEntityCoords(entity, position.x, position.y, position.z, true, true, true, false)
        end

        Wait(0)
    end

    if targetRotation then
        SetEntityRotation(entity, targetRotation.x, targetRotation.y, targetRotation.z, 2, true)
    end
    if targetPosition then
        SetEntityCoords(entity, targetPosition.x, targetPosition.y, targetPosition.z, true, true, true, false)
    end
    FreezeEntityPosition(entity,isFrozen)
end

--- Rotates an entity from its initial rotation to a target rotation over a given duration.
-- CubicBezier https://cubic-bezier.com/#1,0,.63,.44
function BezierRotateEntity(x1,y1,x2,y2, entity, targetRotation, duration, rotationDirection)
    local initialRotation = GetEntityRotation(entity, 2)

    PerformTransition(entity, initialRotation, targetRotation, nil, nil, duration, Bezier(x1,y1,x2,y2),rotationDirection)
end
exports("BezierRotateEntity",BezierRotateEntity)

--- Moves an entity from its initial position to a target position over a given duration.
-- CubicBezier https://cubic-bezier.com/#1,0,.63,.44
function BezierMoveEntity(x1,y1,x2,y2, entity, targetPosition, duration)
    local initialPosition = GetEntityCoords(entity, true)

    PerformTransition(entity, nil, nil, initialPosition, targetPosition, duration, Bezier(x1,y1,x2,y2))
end
exports("BezierMoveEntity",BezierMoveEntity)

--- Rotates and/or moves an entity from its initial rotation/position to a target rotation/position over a given duration.
--  CubicBezier https://cubic-bezier.com/#1,0,.63,.44
function BezierTransitionCubicBezier(x1,y1,x2,y2,entity,targetRotation,targetPosition,duration,rotationDirection)
    if not (x1 and y1 and x2 and y2) then
        print("^1Invalid CubicBezier provided: ^7" .. tostring(x1) .. ", " .. tostring(y1) .. ", " .. tostring(x2) .. ", " .. tostring(y2))
        return
    end

    local initialRotation = targetRotation and GetEntityRotation(entity, 2) or nil
    local initialPosition = targetPosition and GetEntityCoords(entity, true) or nil

    PerformTransition(entity, initialRotation, targetRotation, initialPosition, targetPosition, duration, Bezier(x1,y1,x2,y2),rotationDirection)
end
exports("BezierTransitionCubicBezier",BezierTransitionCubicBezier)