const std = @import("std");
const crypto = std.crypto;
const Sha256 = crypto.hash.sha2.Sha256;
const genesis = @import("./util/genesis.zig");

fn calculateHash(block: genesis.BlockGenesis) [32]u8 {
    var hasher = Sha256.init(.{});

    hasher.update(std.mem.asBytes(&block.index));
    hasher.update(std.mem.asBytes(&block.timestamp));
    hasher.update(&block.prev_hash);
    hasher.update(std.mem.asBytes(&block.nonce));

    var out: [32]u8 = undefined;
    hasher.final(&out);
    return out;
}
