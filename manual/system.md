# 📘 System.d

A toolbox that let's you do stuff with the system without writing any additional instructions for every operating system your program is meant to run on.



# ⚙️ Functions


### `string get_home_path(T...)(T paths)`

**Optional Params:**
- `paths` - paths that will be added at the end

**Returns:** `string` <br>
User's home path or expaded home path if `paths` were specified. <br>
Throws an `Exception` if user's home path couldn't be determined. <br>
Windows: `C:/Users/<username>` + `paths` <br>
MacOS: `/Users/<username>` + `paths` <br>
Linux: `/home/<username>` + `paths`

**Example:**
```d
import std.stdio;
import htfbox;

string path = get_home_path("myfolder");
writeln(path);

// Assuming that user is called "bob":
// On Windows it will print: C:/Users/bob/myfolder
// On MacOS   it will print: /Users/bob/myfolder
// On Linux   it will print: /home/bob/myfolder
```

---

### `string get_config_path(T...)(T paths)`

**Optional Params:**
- `paths` - paths that will be added at the end

**Returns:** `string` <br>
User's config path or expanded user's config path if `path` were specified <br>
If config path couldn't be determined: `HOME` + `.config` <br>
Windows: `C:/Users/<username>/AppData/Roaming` + `paths` <br>
MacOS: `/Users/<username>/Library/Application Support` + `paths` <br>
Linux: `/home/<username>/.config` + `paths`

**Example:**
```d
import std.stdio;
import htfbox;

string path = get_config_path("myfolder");
writeln(path);

// Assuming that user is called "bob":
// On Windows it will print: C:/Users/bob/AppData/Roaming/myfolder
// On MacOS   it will print: /Users/bob/Library/Application Support/myfolder
// On Linux   it will print: /home/bob/.config/myfolder
```

---

### `string get_username()`

**Returns:** `string` <br>
Current user's username

**Example:**
```d
import std.stdio;
import htfbox;

string username = get_username();
writeln(username);

// Assuming that user is called "bob":
// It will just print "bob"
// Not much phylosophy to it ('-' )
```