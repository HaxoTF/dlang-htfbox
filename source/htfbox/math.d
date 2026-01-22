module htfbox.math;

/// Moves value to target by delta, without target miss
T move_towards(T)(T value, T target, T delta)
{
    // need to decrease
    if (value > target)
    {
        value -= delta;
        if (value < target) return target; // prevent target miss
        return value;
    }

    // need to increase
    if (value < target)
    {
        value += delta;
        if (value > target) return target; // prevent target miss
        return value;
    }

    return target;
}

/// Makes sure value is in lower-upper range
T clamp(T)(T value, T lower, T upper)
{
    if (value < lower) return lower;
    if (value > upper) return upper;
    return value;
}