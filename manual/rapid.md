# 📘 Rapid.d

A double linked list meant for operations in which you need to frequently add and remove values from a well... list. If that's what you aim for it should be great alternative to arrays that are slow/laggy at this type of stuff (seriously don't use arrays for that). Great for if you plan for example to make a game in which enemies spawn and despawn like crazy.

I called it "Rapid", cause rapid add/removal, get it?

Another advantage of linked lists is that compared to arrays they don't care if items aren't next to each other. As long as RAM ain't full they won't complain. However that comes at the cost of every value taking additional space for `next` and `previous` pointer (I hope you figured out what they are for).

If you still have no idea what I am yapping about [watch this for more details](https://www.youtube.com/watch?v=N6dOwBde7-M)


# `class Rapid!T()`

`T` is the type of the variable that will be stored

**Example:**
```d
import htfbox;
Rapid!string list = new Rapid!string
// This is a list that holds string values
// Similar to: string[]
```

---

### `void add(T value)`

Adds `value` at the end of the list
<br> Call also with: `list ~= value;` or `list += value;`.

---

### `T get(R index)`

Returns value at `index`
<br> Call also with: `list[index];`

---

### `void set(T value, R index)`

Replaces a value at `index` with `value`
<br> Call also with: `list[index] = value;`

---

### `void remove(T value)`

Seeks for `value` and removes it from the list if exists.
<br> Call also with: `list -= value;`

---

### `void remove_at(R index)`

Removed a value at `index` from the list

---

### Example of previous functions:
```d
	import std.stdio;
	import htfbox;

	// create new list that will hold string values
	Rapid!string friends = new Rapid!string;

	// make some friends
	friends.add("Mike");
	friends.add("Jake");
	friends.add("Bob");
	friends.add("Ashley");
	friends.add("Walter White");
	friends.add("Freddy Fazbear");
	writeln(friends);

	// Freddy jumpscared me...
	// Let's turn him into something usefull
	friends.set("toster", 5);
	// skill issue

	// Mike called me FAT
	friends.remove("Mike");

	// Someone excuted sudo rm -rf on Jake
    // I am gonna avenge you Jake...
	friends.remove_at(0);

	// This is my new friend list
	writeln(friends);

    // Just kidding I have no friends
    Rapid!string friends = null;
```

---

### `void filter(bool delegate(T v) rule)`

Runs `rule` on every value and removes if it returns `false`

Think of it like this:
<br> `true` = keep the value
<br> `false` = remove the value

**Example:**
```d
import std.stdio;
import htfbox;

// create list of integers
Rapid!int nums = new Rapid!int;

// add some numbers
for (int i=1; i<=100; i++)
{
    nums.add(i);
}

// check list
writeln(nums);

// keep the even numbers only
nums.filter((v) => v%2==0);

// check list
writeln(nums);
```