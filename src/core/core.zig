const std: type = @import("std");
const crypto: type = std.crypto;

pub const Hash = [32]u8;
pub const Address = [20]u8;
pub const PublicKey = [32]u8;
pub const Signature = [64]u8;

// We choose Blake3 as our default hash function for its speed and security,
// but this can be changed later if needed.
pub const HashFunction = crypto.hash.Blake3;
pub const ZERO_HASH: Hash = [_]u8{0} ** 32;
pub const ZERO_ADDRESS: Address = [_]u8{0} ** 20;

// Generic hash function wrapper
pub fn hash(data: []const u8) Hash {
    var output: Hash = undefined;
    HashFunction.hash(data, &output, .{});
    // return output;
    //
    // Considerng to do `return HashFunction.hashReturn(output, .{});`
    // if we want to avoid copying the hash output
}
