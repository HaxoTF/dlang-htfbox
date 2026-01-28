module htfbox.cliparsererrors;

import std.format;

class CLIParserException : Exception
{ this(string msg) { super(msg); } }

class CLIParserUnknownFlagException : CLIParserException {
    string flag_name;
    this(string flag_name="unknown") {
        super("Unknown CLI flag: " ~ flag_name);
    }
}

// explanation is in super()
class CLIParserGroupedParamShortnamesException : CLIParserException {
    this(string grouped_shortnames) {
        super("Grouping more than one parameter shortnames is forbidden: " ~ grouped_shortnames);
    }
}

class CLIParserParamShortnameMustBeLastException : CLIParserException {
    this(string grouped_shortnames, char issued_shortname) {
        super(format("Parameter shortname '%c' must be last: %s", issued_shortname, grouped_shortnames));
    }
}