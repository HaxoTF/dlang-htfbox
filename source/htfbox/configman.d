module htfbox.configman;

import path = std.path;
import std.process;
import std.conv;

string get_config_root()
{
    version(linux) // Linux
    {
        return environment.get("XDG_CONFIG_HOME", path.expandTilde("~/.config"));
    }
    else version(Windows) // Windows
    {
        return environment.get("APPDATA");
    }
    else version(OSX) // MacOS
    {
        return path.expandTilde("~/Library/Application Support");
    }
    else // Unknown OS
    {
        return "";
    }
}