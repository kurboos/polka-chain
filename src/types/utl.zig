const std = @import("std");

const Hash = [32]u8;
const Address = [20]u8;
const PublicKey = [32]u8;

/// Hash two 32-byte inputs together
pub fn hashCombine(a: Hash, b: Hash) Hash {
    var combined: [64]u8 = undefined;
    @memcpy(combined[0..32], &a);
    @memcpy(combined[32..64], &b);
    return std.crypto.hash.Blake3.hash(&combined, .{});
}
