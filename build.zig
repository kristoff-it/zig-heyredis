const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    _ = b.addModule("okredis", .{
        .root_source_file = b.path("src/root.zig"),
    });
    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    b.default_step.dependOn(&run_lib_unit_tests.step);

    // TODO: fix docs gen
    // docs was doing this:
    // const build_docs = b.addSystemCommand(&[_][]const u8{
    //     b.zig_exe,
    //     "test",
    //     "src/okredis.zig",
    //     // "-target",
    //     // "x86_64-linux",
    //     "-femit-docs",
    //     "-fno-emit-bin",
    //     "--output-dir",
    //     ".",
    // });
}
