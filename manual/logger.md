# 📘 Logger.d

[Go Back](../README.md)

Do you still write logs using `writeln()`? There's better way to do it.

Loggers like these are great, especially for the release version of your project, cause let's be real: you gonna mess up a lot. Errors might happen, someone's PC might blow up or even eat them alive, and how you are supposed to know why that happened? Well... people write debug info into the logs, so users can just pass them to the developer. This way you know how to fix stuff or is everything working correctly.

# 🧱 Enums

`LogType`

- `INFO` - regular log
- `WARN` - something *might* go wrong
- `ERROR` - something went wrong
- `OK` - success



# `class Logger(string log_path)`

`log_path` is the file path that you wanna write logs into. If you want help in deciding what should be the file name you can use `gen_long_name()` function described later in the manual. The log file can be called whatever you desire even `istole.uranus` as long as you are writing to the text file.

The logger will ensure that log root *(`logs/` for example)* exists everytime you use `send()` function, by creating it if log is somewhere else than cwd *(current working directory)*.

Everytime you create `Logger` with the same `log_path` it will clear `log_path` file contents *(if already exists)* and begin writing from scratch.

`Logger` won't create a `log_path` file as long `send()` function hasn't been called yet or `mute_file` was set to `false` from the beggining.

**Static Variables:**

- `list` - holds dict of `Logger`'s for easier managment

**Variables:**

- `log_path` - where to write?
- `mute_console` - if `true` prevents from printing into the console
- `mute_file` - if `true` prevents from writing into `log_path` file

---

### `void send(string msg, LogType logtype)`

Writes `msg` both into the `log_path` (if `mute_file` is set to `false`) and console (if `mute_console` is set to `false`) in a debug-friendly format.

**Params:**

- `msg` - message to write

**Optional Params:**

- `logtype` - the type of log *(info, error, warn, ok, etc.)*

**Example:**
```d
import std.stdio;
import htfbox;

Logger logger = new Logger("log.txt");
logger.send("Hello World!");
logger.send("Hello Earth!", LogType.OK);
logger.send("Hello Heaven!", LogType.WARN);
logger.send("Hello Hell!", LogType.ERROR);
```

Yep, this is literally everything for now...
