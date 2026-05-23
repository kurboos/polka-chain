const std: type = @import("std");
const crypto: type = std.crypto;

pub const Sha256 = crypto.hash.sha2.Sha256;

const BlockGenesis = struct {
    index: u64,
    timestamp: i64,
    prev_hash: [32]u8,
    nonce: u64,
    hash: [32]u8,
};

fn calculateHash(block: BlockGenesis) [32]u8 {
    var hasher = Sha256.init(.{});

    hasher.update(std.mem.asBytes(&block.index));
    hasher.update(std.mem.asBytes(&block.timestamp));
    hasher.update(&block.prev_hash);
    hasher.update(std.mem.asBytes(&block.nonce));

    var out: [32]u8 = undefined;
    hasher.final(&out);
    return out;
}
