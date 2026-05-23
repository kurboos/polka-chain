const std: type = @import("std");
const genesis: type = @import("./genesis.zig");
pub const Sha256 = std.crypto.hash.sha2.Sha256;

fn utilityFunction() void {
    // This is a placeholder for utility functions that can be used across the project.
}

fn hasherData(block: genesis.BlockGenesis) [32]u8 {
    var hasher = Sha256.init(.{});

    hasher.update(std.mem.asBytes(&block.index));
    hasher.update(std.mem.asBytes(&block.timestamp));
    hasher.update(&block.prev_hash);
    hasher.update(std.mem.asBytes(&block.nonce));

    var out: [32]u8 = undefined;
    hasher.final(&out);
    return out;
}
