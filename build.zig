const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "polka",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // Declare modules (Zig’s way of creating clean boundaries)
    // const node_mod = b.addModule("node", .{ .root_source_file = b.path("src/node/node.zig") });
    // const network_mod = b.addModule("network", .{ .root_source_file = b.path("src/network/p2p.zig") });
  

    // Wire dependencies
    // node_mod.addImport("network", network_mod);
 

    exe.root_module.addImport("node", node_mod);

    b.installArtifact(exe);

    // Add run, test, benchmark steps...
}