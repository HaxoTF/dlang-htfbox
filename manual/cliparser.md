# 📘 CLIParser.d

Some programs can be run via terminal. They are called CLI tools or programs. Most of them accept arguments or flags what allows to specify more options without writing thousands of programs for the same thing, but with slightly different results.

You can make one of those programs too. In order to do so you will have to make a parser that will interpret `args` passed through `main()` function. You can check how that works by writing this simple code:

```d
import std.stdio;

void main(string[] args)
{
    writeln(args);
}
```

Then try to run your program inside a terminal, but instead of running it by typing `./myprogram` try to add something to the command for example: `./myprogram hello world`. You will notice that the code will print exactly what you typed inside your terminal as a list.

You can make a your own parser that will interpret those your own way, but if you wanna go the easy route I already provided you with one written by me :3

## ❔ Examples

list files in a directory
```bash
ls -la /path/to/folder
```
- `-l` - list them in list form
- `-a` - show hidden files also
- `/path/to/folder` - list files inside that folder

---

remove a directory
```bash
rm -rvf /path/to/folder
```
- `-r` - remove recursively (for folders)
- `-v` - print each file/folder you removed
- `-f` - force (do not prompt for "are you sure")
- `/path/to/folder` - folder that will be removed
---

convert `mp4` to `mkv` with `ffmpeg`:
```bash
ffmpeg -i input.mp4 output.mkv
```
- `-i input.mp4` - what file will be converted?
- `output.mkv` - where to put result?

# 🧱 Enums

```d
CLIFlagType
{ 
    DISABLE, // flags that disable something
    ENABLE,  // flags that enable something
    STRING   // flags that take `string` as a argument
}
```

# 📊 Structs

```d
struct CLIFlag
{
    CLIFlagType type;   // type of a flag
    string name;        // name, for example "name" for "--name" flag
    char shortname;     // shortcut, for example 'n' for "-n" flag (can be left blank)
    string val_name;    // what value it will affected in CLIParseResult
    string description; // meant for --help, but I haven't written that yet, so leave empty for now
}
```

```d
struct CLIParseResult
{
    string[] inputs;          // for everything else
    string[][string] strings; // for flags of STRING type
    bool[string] states;      // for flags of ENABLE/DISABLE type
}
```

# ⚙️ Functions

### `CLIParseResult parse_cli_args(string[] args, CLIFlag[] flags, CLIParseResult) initial)`

**Params:**
- `args` - `args` passed through `main()` function
- `flags` - tells the parser what flags exist and how to parse them

**Optional Params:**
- `initial` - the initial state of `CLIParseResult` that will be modified (usefull for defaults)

**Returns:** `CLIParseResult` <br>
A processed `args`

# 🚨 Errors:

### `CLIParserException`

Base for errors below.

---

### `CLIParserParserUnknownFlagException`

Thrown by `parse_cli_args` when user specified a flag that doesn't exist in `CLIFlag[] flags`.

AKA: `Unknown flag: --flag`

---

### `CLIParserGroupedParamShortnamesException`

Thrown by `parse_cli_args` when user specified more than 1 shortnamed flags that require a parameter inside single group.

For example if we assume that both `-a` and `-b` flags accept strings as a value and user typed them like this `myprogram -ab value` this is not allowed since you cannot pass a value to the 2 flags at the same time.

> ⚠️ This isn't throw yet, will be fixed in next version. Parser works fine anyway.

---

### `CLIParserParamShortnameMustBeLastException`

Thrown by `parse_cli_args`. Pretty self-explanatory imo.

# ❔ Example

```d

unittest {
import std.stdio;
import htfbox;

// set the flags your program accepts
CLIFlag[] flags = [
    // (type, name, shortname, val_name, description)
    CLIFlag(CLIFlagType.ENABLE, "verbose", 'v', "verb", "verboses stuff"),
    CLIFlag(CLIFlagType.STRING, "name", 'n', "name", "pass a name of something")
];

// this is optional
CLIParseResult initial = CLIParseResult();
initial.states["verb"] = false; // set default for verbose
initial.strings["name"] = [];   // make sure name is initiated

// you can edit this for different results, experiment!
string[] args = ["myprogram", "--verbose", "-n", "Jake"];

// parse args
CLIParseResult result = parse_cli_args(args, flags, initial);

// check what it returned
writeln(result);
```
