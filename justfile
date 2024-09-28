# run it again
try: check
  cargo run --

# unit testing
check:
  cargo clippy
  cargo test --workspace

# add a crate
newdep crate_name: check
  cargo add {{crate_name}}
  cargo doc
