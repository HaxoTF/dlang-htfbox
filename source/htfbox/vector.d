module htfbox.vector;

import std.math;
import htfbox.math;

alias V2 = Vector2;

struct Vector2
{
    double x;
    double y;

    static immutable ZERO = Vector2(0, 0);
    static immutable ONE  = Vector2(1, 1);
    static immutable HALF = Vector2(0.5, 0.5);

    this(double x, double y)
    {
        this.x = x;
        this.y = y;
    }

    Vector2 clamp(double lower, double upper)
    {
        return Vector2(
            htfbox.math.clamp(x, lower, upper),
            htfbox.math.clamp(y, lower, upper)
        );
    }

    double to_angle()
    {
        double rads = atan2(y, x);
        return rads * (180 / PI);
    }

    double length()
    {
        return sqrt(x*x + y*y);
    }

    /// Get 0.0-1.0 range version of that vector
    Vector2 normalized()
    {
        double len = length();
        if (len == 0) return Vector2(0, 0);
        return Vector2(x/len, y/len);
    }

    Vector2 move_towards(double x, double y, double delta)
    {
        return Vector2(
            htfbox.math.move_towards(this.x, x, delta),
            htfbox.math.move_towards(this.y, y, delta)
        );
    }

    // Operators

    Vector2 opBinary(string op)(Vector2 o)
    {
        final switch(op)
        {
            case "+": return Vector2(x + o.x, y + o.y);
            case "-": return Vector2(x - o.x, y - o.y);
            case "*": return Vector2(x * o.x, y * o.y);
            case "/": return Vector2(x / o.x, y / o.y);
            case "%": return Vector2(x % o.x, y % o.y);
        }
    }

    Vector2 opBinary(string op, T)(T o)
    {
        final switch(op)
        {
            case "+": return Vector2(x + o, y + o);
            case "-": return Vector2(x - o, y - o);
            case "*": return Vector2(x * o, y * o);
            case "/": return Vector2(x / o, y / o);
            case "%": return Vector2(x % o, y % o);
        }
    }

    void opOpAssign(string op)(Vector2 o)
    {
        final switch(op)
        {
            case "+": x += o.x; y += o.y; return;
            case "-": x -= o.x; y -= o.y; return;
            case "*": x *= o.x; y *= o.y; return;
            case "/": x /= o.x; y /= o.y; return;
            case "%": x %= o.x; y %= o.y; return;
        }
    }

    void opOpAssign(string op, T)(T o)
    {
        final switch(op)
        {
            case "+": x += o; y += o; return;
            case "-": x -= o; y -= o; return;
            case "*": x *= o; y *= o; return;
            case "/": x /= o; y /= o; return;
            case "%": x %= o; y %= o; return;
        }
    }
}