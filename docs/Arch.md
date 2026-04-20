/
├── build.zig                  # Main build logic (add modules, options, steps)
├── build.zig.zon              # Dependencies (local or remote packages)
├── README.md
├── LICENSE
├── docs/
│   └── architecture.md        # High-level diagram + component relationships
├── src/
│   ├── main.zig               # CLI entry (zig build run -Dmode=node)
│   ├── lib.zig                # Public root module (re-export everything)
│   ├── node/                  # Top-level orchestrator (Node struct)
│   ├── network/               # P2P, gossip, discovery, protocol messages
│   ├── consensus/             # Engine, block proposal/validation, finality
│   ├── core/                  # Block, Transaction, Header, Mempool, types
│   ├── state/                 # Account/UTXO trie, state transition function
│   ├── storage/               # Block DB, state DB, SSTables/memtable (or RocksDB via C)
│   ├── crypto/                # Hashes, signatures, keys (build on std.crypto)
│   ├── rpc/                   # JSON-RPC / gRPC server for wallets/explorers
│   ├── config/                # CLI flags, TOML/YAML parser, defaults
│   ├── primitives/            # Address, Hash, Signature, serialization
│   ├── types/                 # Common enums, errors, constants
│   ├── util/                  # Arena helpers, logging, metrics, LRU cache
│   └── benchmarks/            # (optional) high-throughput tests
├── tests/                     # Integration + fuzz tests
├── data/                      # Genesis files, test data
└── scripts/                   # Build helpers, docker, etc.