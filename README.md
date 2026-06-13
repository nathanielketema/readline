# Readline

This is [GNU Readline](https://tiswww.case.edu/php/chet/readline/rltop.html), packaged for
[zig](https://ziglang.org/).

## Start

```console
zig fetch --save git+https://github.com/nathanielketema/readline.git
```

You can then import readline in your `build.zig` with:

```zig
const readline_dep = b.dependency("readline", .{
    .target = target,
    .optimize = optimize,
});
exe.linkLibrary(readline_dep.artifact("readline"));
```
