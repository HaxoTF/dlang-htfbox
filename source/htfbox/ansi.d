module htfbox.ansi;

import std.conv;

/// ANSI codes for foreground color
enum CFR
{
    // special
    RESET   = "\033[0m",
    DEFAULT = "\033[39m",

    // normal
    BLACK   = "\033[30m",
    RED     = "\033[31m",
    GREEN   = "\033[32m",
    YELLOW  = "\033[33m",
    BLUE    = "\033[34m",
    MAGENTA = "\033[35m",
    CYAN    = "\033[36m",
    WHITE   = "\033[37m",

    // bright
    BRIGHT_BLACK   = "\033[90m",
    BRIGHT_RED     = "\033[91m",
    BRIGHT_GREEN   = "\033[92m",
    BRIGHT_YELLOW  = "\033[93m",
    BRIGHT_BLUE    = "\033[94m",
    BRIGHT_MAGENTA = "\033[95m",
    BRIGHT_CYAN    = "\033[96m",
    BRIGHT_WHITE   = "\033[97m"
}
alias CFore = CFR;
alias ColorFore = CFR;
alias ColorForeground = CFR;

/// ANSI codes for background color
enum CBG
{
    // special
    RESET   = "\033[0m",
    DEFAULT = "\033[49m",

    // normal
    BLACK   = "\033[40m",
    RED     = "\033[41m",
    GREEN   = "\033[42m",
    YELLOW  = "\033[43m",
    BLUE    = "\033[44m",
    MAGENTA = "\033[45m",
    CYAN    = "\033[46m",
    WHITE   = "\033[47m",

    // bright
    BRIGHT_BLACK   = "\033[100m",
    BRIGHT_RED     = "\033[101m",
    BRIGHT_GREEN   = "\033[102m",
    BRIGHT_YELLOW  = "\033[103m",
    BRIGHT_BLUE    = "\033[104m",
    BRIGHT_MAGENTA = "\033[105m",
    BRIGHT_CYAN    = "\033[106m",
    BRIGHT_WHITE   = "\033[107m"
}
alias CBack = CBG;
alias ColorBack = CBG;
alias ColorBackground = CBG;

/// ANSI codes for style
enum STL
{
    RESET     = "\033[0m",
    BOLD      = "\033[1m",
    DIM       = "\033[2m",
    ITALIC    = "\033[3m",
    UNDERLINE = "\033[4m"
}
alias Style = STL;

/// Get ANSI code of precise foreground color
string cfr_rgb(T)(T r, T g, T b)
{
    return "\033[38;2;"~ r.to!string ~";"~ g.to!string ~";"~ b.to!string ~"m";
}

/// Get ANSI code of precise background color
string cbg_rgb(T)(T r, T g, T b)
{
    return "\033[48;2;"~ r.to!string ~";"~ g.to!string ~";"~ b.to!string ~"m";
}