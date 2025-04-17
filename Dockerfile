# Important: This file is provided for demonstration purposes and may NOT be suitable for production use.
# The maintainers of electrs are not deeply familiar with Docker, so you should DYOR.
# If you are not familiar with Docker either it's probably be safer to NOT use it.

FROM debian:bookworm-slim AS base
RUN apt-get update -qqy
RUN apt-get install -qqy librocksdb-dev curl

### Electrum Rust Server ###
FROM base AS electrs-build


RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN apt-get install -qqy clang cmake

ENV ROCKSDB_INCLUDE_DIR=/usr/include
ENV ROCKSDB_LIB_DIR=/usr/lib
ENV PATH="/root/.cargo/bin:${PATH}"


# Install electrs
WORKDIR /build/electrs
COPY . .
RUN cargo install --locked --path .

FROM base AS result
# Copy the binaries
COPY --from=electrs-build /root/.cargo/bin/electrs /usr/bin/electrs

WORKDIR /
