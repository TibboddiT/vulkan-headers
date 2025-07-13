const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const libModule = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });

    libModule.addCSourceFile(.{
        .file = b.addWriteFiles().add("empty.c", ""),
    });

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "vulkan-headers",
        .root_module = libModule,
    });

    inline for (.{ "vk_video", "vulkan" }) |subdir| {
        lib.installHeadersDirectory(b.path("include/" ++ subdir), subdir, .{});
    }
    b.installArtifact(lib);
}
