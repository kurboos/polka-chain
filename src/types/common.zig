const std = @import("std");
const crypto = std.crypto;

pub const Hash = [32]u8; // Blake3-256 or SHA-256 (you can change later)
pub const Address = [20]u8; // 20-byte address (like Ethereum-style, or change to 32 for Solana-like)
pub const Signature = [64]u8; // Ed25519 or secp256k1 signature (adjust size if needed)
pub const PublicKey = [32]u8; // Ed25519 public key (common choice in modern chains)

pub const HashFunction = crypto.hash.Blake3;

pub const ZERO_HASH: Hash = [_]u8{0} ** 32;
pub const ZERO_ADDRESS: Address = [_]u8{0} ** 20;

/// Generic hash function wrapper
pub fn hash(data: []const u8) Hash {
    var out: Hash = undefined;
    HashFunction.hash(data, &out, .{});
    return out;
}

/// Hash two hashes together (useful for Merkle trees)
pub fn hashCombine(a: Hash, b: Hash) Hash {
    var combined: [64]u8 = undefined;
    @memcpy(combined[0..32], &a);
    @memcpy(combined[32..64], &b);
    return hash(&combined);
}

/// Convert a public key to an address
pub fn pubkeyToAddress(pubkey: PublicKey) Address {
    const h = hash(&pubkey);
    var addr: Address = undefined;
    // TODO: Is memcpy the right way to do this? Maybe we can just slice it directly?
    @memcpy(&addr, h[0..20]);
    return addr;
}

/// Basic error set used across the entire blockchain
pub const BlockchainError = error{
    InvalidBlock,
    InvalidTransaction,
    InvalidSignature,
    InvalidStateTransition,
    InsufficientBalance,
    MempoolFull,
    BlockTooLarge,
    InvalidNonce,
    DuplicateTransaction,
    UnknownValidator,
    ConsensusError,
    StorageError,
    NetworkError,
    SerializationError,
};

/// Common constants
pub const Constants = struct {
    pub const GENESIS_TIMESTAMP: u64 = 1745157600; // Example: April 20, 2025 12:00 UTC (change!)
    pub const MAX_BLOCK_SIZE: usize = 2 * 1024 * 1024; // 2 MB default
    pub const MAX_TX_PER_BLOCK: u32 = 10_000;
    pub const BLOCK_TIME_TARGET_MS: u64 = 6000; // 6 seconds (adjust)
    pub const MAX_FUTURE_BLOCK_TIME: u64 = 15 * 60; // 15 minutes
};

/// Helper for pretty-printing hashes/addresses
pub fn formatHash(writer: anytype, h: Hash) !void {
    for (h) |byte| {
        try writer.print("{x:0>2}", .{byte});
    }
}

pub fn formatAddress(writer: anytype, addr: Address) !void {
    for (addr) |byte| {
        try writer.print("{x:0>2}", .{byte});
    }
}

pub fn shortHash(h: Hash) [16]u8 {
    var buf: [16]u8 = undefined;
    _ = std.fmt.bufPrint(&buf, "{x}", .{std.fmt.fmtSliceHexLower(h[0..8])}) catch unreachable;
    return buf;
}
