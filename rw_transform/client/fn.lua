Transition = {}

-- Linear interpolation: No easing, constant speed.
function Transition.Linear(t)
    return t
end

-- Ease In: Starts slow and accelerates.
function Transition.EaseIn(t)
    return t * t
end

-- Ease Out: Starts fast and decelerates.
function Transition.EaseOut(t)
    return t * (2 - t)
end

-- Ease In and Out: Starts slow, speeds up in the middle, and slows down at the end.
function Transition.EaseInOut(t)
    if t < 0.5 then
        return 2 * t * t
    else
        return -1 + (4 - 2 * t) * t
    end
end

-- Ease In Cubic: Starts slow and accelerates in a cubic manner.
function Transition.EaseInCubic(t)
    return t * t * t
end

-- Ease Out Cubic: Starts fast and decelerates in a cubic manner.
function Transition.EaseOutCubic(t)
    local f = t - 1
    return f * f * f + 1
end

-- Ease In and Out Cubic: Combines cubic ease-in and ease-out.
function Transition.EaseInOutCubic(t)
    if t < 0.5 then
        return 4 * t * t * t
    else
        local f = (2 * t) - 2
        return 0.5 * f * f * f + 1
    end
end

-- Elastic In: Starts slow, speeds up, then bounces back.
function Transition.ElasticIn(t)
    local c4 = (2 * math.pi) / 3
    return t == 0 and 0 or t == 1 and 1 or (-2^(10 * (t - 1)) * math.sin((t - 1 - (c4 / 4)) * (2 * math.pi) / c4))
end

-- Elastic Out: Starts fast, then bounces back.
function Transition.ElasticOut(t)
    local c4 = (2 * math.pi) / 3
    return t == 0 and 0 or t == 1 and 1 or (2^(-10 * t) * math.sin((t - (c4 / 4)) * (2 * math.pi) / c4) + 1)
end

-- Elastic In and Out: Combines elastic ease-in and ease-out.
function Transition.ElasticInOut(t)
    local c5 = (2 * math.pi) / 4.5
    return t == 0 and 0 or t == 1 and 1 or (t < 0.5 and (-0.5 * 2^(20 * t - 10) * math.sin((20 * t - 11.125) * c5)) or (0.5 * 2^(-20 * t + 10) * math.sin((20 * t - 11.125) * c5) + 1))
end
-- Bounce In: Starts slow, then bounces.
function Transition.BounceIn(t)
    return 1 - Transition.BounceOut(1 - t)
end

-- Bounce Out: Starts fast, then bounces.
function Transition.BounceOut(t)
    local n1 = 7.5625
    local d1 = 2.75
    if t < 1 / d1 then
        return n1 * t * t
    elseif t < 2 / d1 then
        t = t - (1.5 / d1)
        return n1 * t * t + 0.75
    elseif t < 2.5 / d1 then
        t = t - (2.25 / d1)
        return n1 * t * t + 0.9375
    else
        t = t - (2.625 / d1)
        return n1 * t * t + 0.984375
    end
end

-- Bounce In and Out: Combines bounce ease-in and ease-out.
function Transition.BounceInOut(t)
    if t < 0.5 then
        return Transition.BounceIn(t * 2) * 0.5
    else
        return Transition.BounceOut(t * 2 - 1) * 0.5 + 0.5
    end
end

Transition.Functions = {
    Linear = Transition.Linear,
    EaseIn = Transition.EaseIn,
    EaseOut = Transition.EaseOut,
    EaseInOut = Transition.EaseInOut,
    EaseInCubic = Transition.EaseInCubic,
    EaseOutCubic = Transition.EaseOutCubic,
    EaseInOutCubic = Transition.EaseInOutCubic,
    ElasticIn = Transition.ElasticIn,
    ElasticOut = Transition.ElasticOut,
    ElasticInOut = Transition.ElasticInOut,
    BounceIn = Transition.BounceIn,
    BounceOut = Transition.BounceOut,
    BounceInOut = Transition.BounceInOut,
}