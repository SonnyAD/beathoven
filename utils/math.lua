local mathsModule = {}

-- distance between two points
function mathsModule.distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

-- round to closest decimal
function mathsModule.round(num)
    return math.floor(num + 0.5)
end

return mathsModule