module htfbox.system;

import path = std.path;
import proc = std.process;

/// Where user's stuff is stored?
string get_home_path(T...)(T paths)
{
    string result;
    
    // home path depends on a os
    version(Posix)   result = proc.environment.get("HOME", "");
    version(Windows) result = proc.environment.get("USERPROFILE", "");
    
    // have no idea where home is ('-' )??
    if (result == "")
        throw new Exception("Home couldn't be found");

    // if paths specified add them
    if (paths.length > 0)
        result = path.buildNormalizedPath(result, paths);
    
    return result;
}

/// Where user's config's and data are stored?
string get_config_path(T...)(T paths)
{
    string result;

    version (linux)   result = proc.environment.get("XDG_CONFIG_HOME", "");
    version (Windows) result = proc.environment.get("APPDATA", "");
    version (OSX)     result = get_home_path("Application Support", "");

    // have no idea where os wanna config ('-' )?? (up to me ig, let's go for linux style)
    if (result == "")
        result = get_home_path(".config");
    
    // if paths specified add them
    if (paths.length > 0)
        result = path.buildNormalizedPath(result, paths);
    
    return result;
}

/// How the current user is called?
string get_username()
{
    string result = "";
    version(Posix)   result = proc.environment.get("USER", "");
    version(Windows) result = proc.environment.get("USERNAME", "");
    return result;
}