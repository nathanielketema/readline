const std = @import("std");

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
    mod.linkSystemLibrary("ncurses", .{});

    mod.addCMacro("_DARWIN_C_SOURCE", "1");
    mod.addCMacro("_POSIX_VERSION", "200112L");
    mod.addCMacro("HAVE_UNISTD_H", "1");
    mod.addCMacro("HAVE_STDLIB_H", "1");
    mod.addCMacro("HAVE_STRING_H", "1");
    mod.addCMacro("HAVE_STRINGS_H", "1");
    mod.addCMacro("HAVE_DIRENT_H", "1");
    mod.addCMacro("HAVE_FCNTL_H", "1");
    mod.addCMacro("HAVE_WCHAR_H", "1");
    mod.addCMacro("HAVE_WCTYPE_H", "1");
    mod.addCMacro("HAVE_LOCALE_H", "1");
    mod.addCMacro("HAVE_LIMITS_H", "1");
    mod.addCMacro("HAVE_STDARG_H", "1");
    mod.addCMacro("HAVE_STDBOOL_H", "1");
    mod.addCMacro("HAVE_SYS_IOCTL_H", "1");
    mod.addCMacro("HAVE_SYS_TIME_H", "1");
    mod.addCMacro("HAVE_SYS_SELECT_H", "1");
    mod.addCMacro("HAVE_SYS_FILE_H", "1");
    mod.addCMacro("HAVE_TERMIOS_H", "1");
    mod.addCMacro("HAVE_PWD_H", "1");
    mod.addCMacro("HAVE_LANGINFO_H", "1");
    mod.addCMacro("HAVE_MEMORY_H", "1");
    mod.addCMacro("HAVE_CHOWN", "1");
    mod.addCMacro("HAVE_FCNTL", "1");
    mod.addCMacro("HAVE_FNMATCH", "1");
    mod.addCMacro("HAVE_GETPWENT", "1");
    mod.addCMacro("HAVE_GETPWNAM", "1");
    mod.addCMacro("HAVE_GETPWUID", "1");
    mod.addCMacro("HAVE_GETTIMEOFDAY", "1");
    mod.addCMacro("HAVE_ISASCII", "1");
    mod.addCMacro("HAVE_ISXDIGIT", "1");
    mod.addCMacro("HAVE_KILL", "1");
    mod.addCMacro("HAVE_LSTAT", "1");
    mod.addCMacro("HAVE_MBRLEN", "1");
    mod.addCMacro("HAVE_MBRTOWC", "1");
    mod.addCMacro("HAVE_MEMMOVE", "1");
    mod.addCMacro("HAVE_PSELECT", "1");
    mod.addCMacro("HAVE_PUTENV", "1");
    mod.addCMacro("HAVE_READLINK", "1");
    mod.addCMacro("HAVE_SELECT", "1");
    mod.addCMacro("HAVE_SETENV", "1");
    mod.addCMacro("HAVE_SETITIMER", "1");
    mod.addCMacro("HAVE_SETLOCALE", "1");
    mod.addCMacro("HAVE_STRCASECMP", "1");
    mod.addCMacro("HAVE_STRCOLL", "1");
    mod.addCMacro("HAVE_STRPBRK", "1");
    mod.addCMacro("HAVE_SYSCONF", "1");
    mod.addCMacro("HAVE_TCGETATTR", "1");
    mod.addCMacro("HAVE_VSNPRINTF", "1");
    mod.addCMacro("HAVE_WCRTOMB", "1");
    mod.addCMacro("HAVE_WCSCOLL", "1");
    mod.addCMacro("HAVE_WCSLEN", "1");
    mod.addCMacro("HAVE_WCSNLEN", "1");
    mod.addCMacro("HAVE_WCSNRTOMBS", "1");
    mod.addCMacro("HAVE_WCTYPE", "1");
    mod.addCMacro("HAVE_WCWIDTH", "1");
    mod.addCMacro("HAVE_MBSTATE_T", "1");
    mod.addCMacro("HAVE_WCHAR_T", "1");
    mod.addCMacro("HAVE_WCTYPE_T", "1");
    mod.addCMacro("HAVE_WINT_T", "1");
    mod.addCMacro("HAVE_ISWCTYPE", "1");
    mod.addCMacro("HAVE_ISWLOWER", "1");
    mod.addCMacro("HAVE_ISWUPPER", "1");
    mod.addCMacro("HAVE_TOWLOWER", "1");
    mod.addCMacro("HAVE_TOWUPPER", "1");
    mod.addCMacro("HAVE_LANGINFO_CODESET", "1");
    mod.addCMacro("HAVE_POSIX_SIGNALS", "1");
    mod.addCMacro("HAVE_POSIX_SIGSETJMP", "1");
    mod.addCMacro("GWINSZ_IN_SYS_IOCTL", "1");
    mod.addCMacro("STRUCT_WINSIZE_IN_SYS_IOCTL", "1");
    mod.addCMacro("HAVE_GETPW_DECLS", "1");
    mod.addCMacro("HAVE_STRUCT_DIRENT_D_INO", "1");
    mod.addCMacro("HAVE_STRUCT_DIRENT_D_FILENO", "1");
    mod.addCMacro("HAVE_TIMEVAL", "1");

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
        .flags = &.{
            "-Wno-parentheses",
            "-Wno-format-security",
            "-DBRACKETED_PASTE_DEFAULT=1",
            "-DRL_LIBRARY_VERSION=\"8.3\"",
            "-DREADLINE_LIBRARY",
        },
    });

    lib.installHeadersDirectory(upstream_root, "readline", .{
        .include_extensions = &.{
            "chardefs.h",
            "history.h",
            "keymaps.h",
            "readline.h",
            "rlconf.h",
            "rlstdc.h",
            "rltypedefs.h",
            "tilde.h",
        },
    });
    b.installArtifact(lib);
}
