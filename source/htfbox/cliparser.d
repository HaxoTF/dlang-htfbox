module htfbox.cliparser;

public import htfbox.cliparsererrors;
import std.string;
import std.conv;

// this module gets crowdy...
// and hard to read also...

// I have zero idea if D already got build-in package for this
// but I had fun working on it, so it was worth it anyway ;3

enum CLIFlagType
{
    DISABLE,
    ENABLE,
    STRING
}
alias CLIFT=CLIFlagType;

struct CLIFlag
{
    CLIFlagType type;
    string name;
    char shortname;
    string val_name;
    string description;
}

struct CLIParseResult
{
    string[] inputs; // for everything else
    string[][string] strings; // for flags that takes strings as a argument
    bool[string] states; // for flags of ENABLE/DISABLE type
}

CLIFlag* get_flag_by_name(CLIFlag[] flags, string name)
{
    for(int i=0; i<flags.length; i++)
        if (flags[i].name == name) return &flags[i];
    return null;
}

CLIFlag* get_flag_by_shortname(CLIFlag[] flags, char shortname)
{
    for(int i=0; i<flags.length; i++)
        if (flags[i].shortname == shortname) return &flags[i];
    return null;
}

/// Takes string[] args from main and parses them into machine readable version
CLIParseResult parse_cli_args(string[] args, CLIFlag[] flags, CLIParseResult initial=CLIParseResult())
{
    CLIParseResult result = initial;

    CLIFlag* last_flag = null;
    bool expect_value = false;

    // for every argument
    foreach (string arg; args)
    {
        // if previous flag expected a value add this arg into the list
        if (expect_value)
        {
            result.strings[last_flag.val_name] ~= arg;
            expect_value = false; // next arg won't be treated as value
            continue; // done for this arg
        }

        // if --flag
        if(startsWith(arg, "--"))
        {
            // flag name provided
            string name = arg[2 .. $];

            // now get the flag from list
            CLIFlag* flag = get_flag_by_name(flags, name);
            if (flag is null) throw new CLIParserUnknownFlagException(arg); // no, I won't google it

            // what flag expects me to do?
            switch (flag.type)
            {
                case CLIFlagType.DISABLE: result.states[flag.val_name] = false; break;
                case CLIFlagType.ENABLE: result.states[flag.val_name] = true; break;
                case CLIFlagType.STRING: expect_value = true; break;
                default: break; // I am too lazy to put custom exception here
            }

            last_flag = flag;
            continue; // done for this arg
        }

        // if -f or -abc
        if (startsWith(arg, "-"))
        {
            expect_value = false;

            // for each shortname
            for(int i=1; i<arg.length; i++)
            {
                // param shortname must be last
                if (expect_value)
                    throw new CLIParserParamShortnameMustBeLastException(arg, last_flag.shortname);

                char sn = arg[i]; // cpu efficient imo

                // get the flag
                CLIFlag* flag = get_flag_by_shortname(flags, sn);
                if (flag is null) throw new CLIParserUnknownFlagException(sn.to!string); // no, I won't google it once again...

                switch (flag.type)
                {
                    case CLIFlagType.DISABLE: result.states[flag.val_name] = false; break;
                    case CLIFlagType.ENABLE: result.states[flag.val_name] = true; break;
                    case CLIFlagType.STRING: expect_value = true; break;
                    default: break; // I am too lazy to put custom exception here
                }

                last_flag = flag;
            }
            continue; // done for this arg
        }

        // this is normal INPUT arg
        result.inputs ~= arg;
    }

    return result;
}

alias CLIF=CLIFlag;

