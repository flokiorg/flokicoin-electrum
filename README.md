
# Flokicoin Electrum Server

A block chain index engine written in Rust based on [romanz/electrs](https://github.com/romanz/electrs).

## Usage

 * [Installation from source](doc/install.md)
 * [Pre-built binaries](doc/binaries.md) (No official binaries available but a beta repository is available for installation)
 * [Configuration](doc/config.md)
 * [Usage](doc/usage.md)
 * [Monitoring](doc/monitoring.md)
 * [Upgrading](doc/upgrading.md) - **contains information about important changes from older versions**

## Features

 * Supports Electrum protocol [v1.4](https://electrumx-spesmilo.readthedocs.io/en/latest/protocol.html)
 * Maintains an index over transaction inputs and outputs, allowing fast balance queries
 * Low index storage overhead (~10%), relying on a local full node for transaction retrieval
 * Efficient mempool tracker (allowing better fee [estimation](https://github.com/spesmilo/electrum/blob/59c1d03f018026ac301c4e74facfc64da8ae4708/RELEASE-NOTES#L34-L46))
 * Low CPU & memory usage (after initial indexing)
 * [`txindex`](https://github.com/bitcoinbook/bitcoinbook/blob/develop/ch03.asciidoc#txindex) is not required for the Bitcoin node
 * Uses a single [RocksDB](https://github.com/spacejam/rust-rocksdb) database, for better consistency and crash recovery


## Index database

The database schema is described [here](doc/schema.md).

## Contributing

All contributions to this project are welcome. Please refer to the [Contributing Guidelines](CONTRIBUTING.md) for more details.


