function LerpVec3(a, b, t)
    return vec3(
        a.x + (b.x - a.x) * t,
        a.y + (b.y - a.y) * t,
        a.z + (b.z - a.z) * t
    )
end

function Bezier(x1, y1, x2, y2)
    return {
        x1 = x1,
        y1 = y1,
        x2 = x2,
        y2 = y2,
    }
end