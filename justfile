try: check
  cargo run --

check:
  cargo clippy
  cargo test --workspace

newdep crate_name: check
  cargo add {{crate_name}}
  cargo doc
