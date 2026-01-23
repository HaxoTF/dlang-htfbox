module htfbox.rapid;

import std.array;
import std.conv;
import core.memory;

// I totally forgot how it works (well kinda)
// All I know that it's double linked list meant for quick item add/removal
// Great for list of entities for example that spawn/despawn frequently
// There's 1% chance it will keep eating your RAM (aka: memory leaks)
// ...but I haven't spotted any issues with it so I will consider this class safe as a whole

struct RapidNode(T)
{
    T value;
    RapidNode!T* next;
    RapidNode!T* prev;
}

class Rapid(T)
{
    // properties
    ulong length;
    RapidNode!T* first;
    RapidNode!T* last;

    this()
    {
        length = 0;
        first = null;
        last = null;
    }

    // --- ADD

    void add(T value)
    {
        // make a new node
        RapidNode!T* new_node = cast(RapidNode!T*) GC.malloc(RapidNode!T.sizeof, GC.BlkAttr.NO_SCAN);
        new_node.value = value;
        new_node.next = null;
        new_node.prev = null;

        // if first points to that
        if (first is null)
        {
            first = new_node;
            last = new_node;
        }
        else
        {
            last.next = new_node;
            new_node.prev = last;
            last = new_node;
        }

        length++;
    }

    // --- GET NODE BY INDEX

    private RapidNode!T* get_node_by_index(R)(R index)
    {
        if (index >= length) throw new Exception("Index out of range");

        RapidNode!T* current = first;

        for (size_t i=0; i<index; i++)
        {
            current = current.next;
        }

        return current;
    }

    // --- GET

    T get(R)(R index)
    {
        return get_node_by_index(index).value;
    }

    // --- SET
    
    void set(R)(T value, R index)
    {
        if (index >= length)
            throw new Exception("Index out of range");

        RapidNode!T* node = get_node_by_index(index);
        node.value = value;
    }

    // --- REMOVE AT

    void remove_at(R)(R index)
    {
        RapidNode!T* node = get_node_by_index(index);
        pinch(node);
        GC.free(node);
    }

    // --- REMOVE

    bool remove(T value)
    {
        RapidNode!T* current = first;
        
        while (current !is null)
        {
            if (current.value == value)
            {
                pinch(current);
                return true;
            }

            current = current.next;
        }

        return false;
    }

    // --- PINCH

    private void pinch(RapidNode!T* node)
    {
        // -- Previous

        // if has previous node
        if (node.prev !is null)
        {
            node.prev.next = node.next;
        }

        // It's first
        else
        {
            first = node.next;
        }

        // -- Next

        // if has next node
        if (node.next !is null)
        {
            node.next.prev = node.prev;
        }

        // It's last
        else
        {
            last = node.prev;
        }

        length--;
    }

    // --- FILTER

    void filter(bool delegate(T v) rule)
    {
        // begin from first node
        RapidNode!T* current = this.first;

        // repeat until hits null
        while (current !is null)
        {
            // condition isn't met
            if (!rule(current.value))
            {
                RapidNode!T* rejected = current;
                current = current.next;
                pinch(rejected);
                GC.free(rejected);
            }
            else
            {
                current = current.next;
            }
        }
    }

    // ----- [ OPERATORS ] ----- //

    override string toString()
    {
        string[] node_strings = new string[length];

        RapidNode!T* current = first;
        
        for (int i=0; i<length; i++)
        {
            node_strings[i] = current.value.to!string;
            current = current.next;
        }

        return "[ " ~ join(node_strings, ", ") ~ " ]";
    }

    // rapid ?= item;
    void opOpAssign(string op)(T value)
    {
        switch (op)
        {
            case "+": add(value); break;
            case "~": add(value); break;
            case "-": remove(value); break;
            default: throw new Exception("Unsupported operator: " ~ op); break;
        }
    }

    // rapid[i] = value
    void opIndexAssign(R)(T value, R index)
    {
        this.set(value, index);
    }

    // value = rapid[i]
    T opIndex(size_t index)
    {
        return this.get(index);
    }
}