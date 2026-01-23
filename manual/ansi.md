# 📘 Ansi.d

Did you know your terminal got cheat codes? You can write them into the console in order to get specific results.



# ⚙️ Functions

### `string cfr_rgb(T)(T r, T g, T b)`

**Params:**
- `r` - red *(0-255)*
- `g` - green *(0-255)*
- `b` - blue *(0-255)*

**Returns:** `string` <br>
ANSI esc code of a precise RGB foreground color

**Example:**
```d
import std.stdio;
import htfbox;

// use it by printing it to the terminal
string ansi_code = cfr_rgb(0, 150, 255);
writeln(ansi_code ~ "I am blue da bee dee da bee day");
```

---

### `string cbg_rgb(T)(T r, T g, T b)`

**Params:**
- `r` - red *(0-255)*
- `g` - green *(0-255)*
- `b` - blue *(0-255)*

**Returns:** `string` <br>
ANSI esc code of a precise RGB background color

**Example:**
```d
import std.stdio;
import htfbox;

// use it by printing it to the terminal
string ansi_code = cbg_rgb(0, 200, 255);
writeln(ansi_code ~ "I am in the water! It's wet!");
```


# 🧱 Enums

### `CFR` *(Color FoReground)* and `CBG` *(Color BackGround)* 

- **Special**
- `RESET`
- `DEFAULT`
- **Normal**
- `BLACK`
- `RED`
- `GREEN`
- `YELLOW`
- `BLUE`
- `MAGENTA`
- `CYAN`
- `WHITE`
- **Bright**
- `BRIGHT_BLACK`
- `BRIGHT_RED`
- `BRIGHT_GREEN`
- `BRIGHT_YELLOW`
- `BRIGHT_BLUE`
- `BRIGHT_MAGENTA`
- `BRIGHT_CYAN`
- `BRIGHT_WHITE`

<br>

**`CFR` Aliases:** `CFore`, `ColorFore` and `ColorForeground` <br>
**`CBG` Aliases:** `CBack`, `ColorBack` and `ColorBackground`

**Example:**
```d
import std.stdio;
import htfbox;

// You use them by priting them into the terminal
// For example if you want to make a hotdog:
writeln(CFR.YELLOW ~ CBG.RED ~ " /\\/\\/\\/\\/\\/\\/\\/\\ " ~ CFR.RESET);
```

---

### `STL` *(STyLe)*

- `RESET`
- `BOLD`
- `DIM`
- `ITALIC`
- `UNDERLINE`

**Aliases:** `Style`

**Example:**
```d
import std.stdio;
import htfbox;
writeln(STL.ITALIC ~ "'I use Arch btw'" ~ STL.RESET ~ " - HaxoTF");
```