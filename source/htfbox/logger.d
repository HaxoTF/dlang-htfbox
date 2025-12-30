module htfbox.logger;

import std.datetime;
import std.stdio;
import file = std.file;
import path = std.path;
import std.string;
import std.conv;

public enum LogType {
    INFO,
    WARN,
    ERROR,
    OK
}

// easier to access them
public Logger[string] LOGGERS;

class Logger
{
    static Logger[string] list;
    string log_path = "";
    
    static this()
    {
        list = new Logger[string];
    }

    this(string log_path="log.log")
    {
        if (file.exists(log_path))
        {
            file.write(log_path, "");
        }

        string log_root = path.dirName(log_path);
        if (log_root != ".")
        {
            file.mkdirRecurse(log_root);
        }

        this.log_path = log_path;
    }

    void send(string msg, LogType logtype=LogType.INFO)
    {
        string ind; // indicator (like "[ LOG ]" for example)
        string clr; // color (ANSI escape code)

        switch (logtype)
        {
            case LogType.INFO: // INFO
                ind = " [ INFO  ] ";
                clr = "";
                break;
            
            case LogType.WARN: // WARN
                ind = " [ WARN  ] ";
                clr = "\033[33m";
                break;
            
            case LogType.ERROR: // ERROR
                ind = " [ ERROR ] ";
                clr = "\033[31m";
                break;
            
            case LogType.OK: // OK
                ind = " [ OK    ] ";
                clr = "\033[32m";
                break;

            default: break;
        }

        string full_msg = get_time_prefix() ~ ind ~ msg;

        file.append(log_path, full_msg ~ "\n");
        writeln(clr ~ full_msg ~ "\033[0m");
    }

    static string get_time_prefix()
    {
        SysTime now = Clock.currTime();

        string h = rightJustify(now.hour.to!string,   2, ' ');
        string m = rightJustify(now.minute.to!string, 2, '0');
        string s = rightJustify(now.second.to!string, 2, '0');

        return "[ " ~ h ~ ":" ~ m ~ ":" ~ s ~ " ]";
    }

    static string get_date_string()
    {
        return Clock.currTime()
            .toISOExtString(0)
            .replace(':', '-')
            .replace('T', '_');
    }

    /// Generate default log name "name-YYYY-MM-DD_hh_mm_ss.log"
    static string gen_log_name(string name="")
    {
        if (name ~= "") {
            return name ~ "-" ~ get_date_string() ~ ".log";
        }
        return get_date_string() ~ ".log";
    }
}