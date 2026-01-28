module htfbox.shapes.square;

import htfbox.vector;

struct Square
{
    // Values
    Vector2 pos;
    Vector2 size;
    Vector2 pivot;

    // pos X
    @property double x() {return pos.x;}
    @property void x(double v) {pos.x = v;}
    
    // pos Y
    @property double y() {return pos.y;}
    @property void y(double v) {pos.y = v;}

    // size X (width)
    @property double w() {return size.x;}
    @property void w(double v) {size.x = v;}

    // size Y (height)
    @property double h() {return size.y;}
    @property void h(double v) {size.y = v;}

    // pivot X
    @property double px() {return pivot.x;}
    @property void px(double v) {pivot.x = v;}

    // pivot Y
    @property double py() {return pivot.y;}
    @property void py(double v) {pivot.y = v;}

    // Constructors
    this(V2 pos, V2 size, V2 pivot=V2.ZERO)
    {
        this.pos = pos;
        this.size = size;
        this.pivot = pivot;
    }

    this(double x, double y, double w, double h, double px=0, double py=0)
    {
        this.pos = Vector2(x, y);
        this.size = Vector2(w, h);
        this.pivot = Vector2(px, py);
    }

    /// Return 0 pivot version of that square
    Square cast_pivot()
    {
        return Square(
            x + (w * px),
            y + (h * py),
            w, h, 0, 0
        );
    }

    /// Check collsion with other Square
    bool collides_with(Square other)
    {
        Square a = this.cast_pivot();
        Square b = other.cast_pivot();

        if (a.x > b.x + b.w) return false; //        [B] -> [A]
        if (b.x > a.x + a.w) return false; // [A] <- [B]
        if (a.y > b.y + b.w) return false; //        [B] -> [A]
        if (b.y > a.y + a.w) return false; // [A] <- [B]
        return true; // [B[A]]
    }
}