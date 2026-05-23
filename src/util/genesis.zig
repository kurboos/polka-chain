const std: type = @import("std");
const crypto: type = std.crypto;

pub const Sha256 = crypto.hash.sha2.Sha256;

export const BlockGenesis = struct {
    index: u64,
    timestamp: i64,
    prev_hash: [32]u8,
    nonce: u64,
    hash: [32]u8,
};
