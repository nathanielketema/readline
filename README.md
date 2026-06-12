# Readline

This is [GNU Readline](https://tiswww.case.edu/php/chet/readline/rltop.html), packaged for
[zig](https://ziglang.org/).

## Start

```console
zig fetch --save git+https://github.com/nathanielketema/readline.git
```

You can then add it as a dependency to your `build.zig`:

```zig
const readline = b.dependency("readline", .{
    .target = target,
    .optimize = optimize,
}).module("readline");

// Example usage:
const exe = b.addExecutable(.{
    .name = "foo",
    .root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "readline", .module = readline },
        },
    }),
});
```
