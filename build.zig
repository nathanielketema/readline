const std = @import("std");

const Macro = struct {
    name: []const u8,
    value: []const u8,
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("libreadline", .{});
    const upstream_root = upstream.path(".");

    const mod = b.createModule(.{
        .optimize = optimize,
        .target = target,
        .link_libc = true,
    });

    const lib = b.addLibrary(.{
        .name = "readline",
        .linkage = .static,
        .root_module = mod,
    });
    mod.addIncludePath(upstream_root);

    const defines = [_]Macro{
        .{ .name = "HAVE_UNISTD_H", .value = "1" },
        .{ .name = "HAVE_STDLIB_H", .value = "1" },
        .{ .name = "HAVE_STRING_H", .value = "1" },
        .{ .name = "HAVE_STRINGS_H", .value = "1" },
        .{ .name = "HAVE_DIRENT_H", .value = "1" },
        .{ .name = "HAVE_FCNTL_H", .value = "1" },
        .{ .name = "HAVE_WCHAR_H", .value = "1" },
        .{ .name = "HAVE_WCTYPE_H", .value = "1" },
        .{ .name = "HAVE_LOCALE_H", .value = "1" },
        .{ .name = "HAVE_LIMITS_H", .value = "1" },
        .{ .name = "HAVE_STDARG_H", .value = "1" },
        .{ .name = "HAVE_STDBOOL_H", .value = "1" },
        .{ .name = "HAVE_SYS_IOCTL_H", .value = "1" },
        .{ .name = "HAVE_SYS_TIME_H", .value = "1" },
        .{ .name = "HAVE_SYS_SELECT_H", .value = "1" },
        .{ .name = "HAVE_TERMIOS_H", .value = "1" },
        .{ .name = "HAVE_PWD_H", .value = "1" },
        .{ .name = "HAVE_LANGINFO_H", .value = "1" },
        .{ .name = "HAVE_MEMORY_H", .value = "1" },
        // Function availability
        .{ .name = "HAVE_CHOWN", .value = "1" },
        .{ .name = "HAVE_FCNTL", .value = "1" },
        .{ .name = "HAVE_FNMATCH", .value = "1" },
        .{ .name = "HAVE_GETPWENT", .value = "1" },
        .{ .name = "HAVE_GETPWNAM", .value = "1" },
        .{ .name = "HAVE_GETPWUID", .value = "1" },
        .{ .name = "HAVE_GETTIMEOFDAY", .value = "1" },
        .{ .name = "HAVE_ISASCII", .value = "1" },
        .{ .name = "HAVE_KILL", .value = "1" },
        .{ .name = "HAVE_LSTAT", .value = "1" },
        .{ .name = "HAVE_MBRLEN", .value = "1" },
        .{ .name = "HAVE_MBRTOWC", .value = "1" },
        .{ .name = "HAVE_MEMMOVE", .value = "1" },
        .{ .name = "HAVE_PSELECT", .value = "1" },
        .{ .name = "HAVE_PUTENV", .value = "1" },
        .{ .name = "HAVE_READLINK", .value = "1" },
        .{ .name = "HAVE_SELECT", .value = "1" },
        .{ .name = "HAVE_SETENV", .value = "1" },
        .{ .name = "HAVE_SETITIMER", .value = "1" },
        .{ .name = "HAVE_SETLOCALE", .value = "1" },
        .{ .name = "HAVE_STRCASECMP", .value = "1" },
        .{ .name = "HAVE_STRCOLL", .value = "1" },
        .{ .name = "HAVE_STRPBRK", .value = "1" },
        .{ .name = "HAVE_SYSCONF", .value = "1" },
        .{ .name = "HAVE_TCGETATTR", .value = "1" },
        .{ .name = "HAVE_VSNPRINTF", .value = "1" },
        .{ .name = "HAVE_WCRTOMB", .value = "1" },
        .{ .name = "HAVE_WCSCOLL", .value = "1" },
        .{ .name = "HAVE_WCSLEN", .value = "1" },
        .{ .name = "HAVE_WCSNLEN", .value = "1" },
        .{ .name = "HAVE_WCSNRTOMBS", .value = "1" },
        .{ .name = "HAVE_WCTYPE", .value = "1" },
        .{ .name = "HAVE_WCWIDTH", .value = "1" },
        // Multibyte/wide char types
        .{ .name = "HAVE_MBSTATE_T", .value = "1" },
        .{ .name = "HAVE_WCHAR_T", .value = "1" },
        .{ .name = "HAVE_WCTYPE_T", .value = "1" },
        .{ .name = "HAVE_WINT_T", .value = "1" },
        .{ .name = "HAVE_ISWCTYPE", .value = "1" },
        .{ .name = "HAVE_ISWLOWER", .value = "1" },
        .{ .name = "HAVE_ISWUPPER", .value = "1" },
        .{ .name = "HAVE_TOWLOWER", .value = "1" },
        .{ .name = "HAVE_TOWUPPER", .value = "1" },
        .{ .name = "HAVE_LANGINFO_CODESET", .value = "1" },
        // Signal handling
        .{ .name = "HAVE_POSIX_SIGNALS", .value = "1" },
        .{ .name = "HAVE_POSIX_SIGSETJMP", .value = "1" },
        // TTY / ioctl
        .{ .name = "GWINSZ_IN_SYS_IOCTL", .value = "1" },
        .{ .name = "STRUCT_WINSIZE_IN_TERMIOS", .value = "1" },
        .{ .name = "HAVE_GETPW_DECLS", .value = "1" },
        // Dirent struct members
        .{ .name = "HAVE_STRUCT_DIRENT_D_INO", .value = "1" },
        .{ .name = "HAVE_STRUCT_DIRENT_D_FILENO", .value = "1" },
        // Misc
        .{ .name = "READLINE_LIBRARY", .value = "1" },
        .{ .name = "_POSIX_VERSION", .value = "200112L" },
        .{ .name = "HAVE_TIMEVAL", .value = "1" },
    };

    for (defines) |define| {
        mod.addCMacro(define.name, define.value);
    }

    mod.addCSourceFiles(.{
        .root = upstream_root,
        .files = &.{
            "bind.c",
            "callback.c",
            "colors.c",
            "compat.c",
            "complete.c",
            "display.c",
            "funmap.c",
            "histexpand.c",
            "histfile.c",
            "history.c",
            "histsearch.c",
            "input.c",
            "isearch.c",
            "keymaps.c",
            "kill.c",
            "macro.c",
            "mbutil.c",
            "misc.c",
            "nls.c",
            "parens.c",
            "parse-colors.c",
            "readline.c",
            "rltty.c",
            "search.c",
            "shell.c",
            "signals.c",
            "terminal.c",
            "text.c",
            "tilde.c",
            "undo.c",
            "util.c",
            "vi_mode.c",
            "xfree.c",
            "xmalloc.c",
        },
    });
    lib.installHeader(upstream.path("readline.h"), "readline.h");
    lib.installHeader(upstream.path("history.h"), "history.h");
    lib.installHeader(upstream.path("tilde.h"), "tilde.h");
    lib.installHeader(upstream.path("chardefs.h"), "chardefs.h");
    lib.installHeader(upstream.path("keymaps.h"), "keymaps.h");
    b.installArtifact(lib);
}
