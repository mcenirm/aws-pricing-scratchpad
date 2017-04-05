#!/usr/bin/env jq -f

.products = (
  [
    .products
    | to_entries[]
    | select(
      .value.productFamily == "Storage"
      and (
        .value.attributes.location | startswith("US ")
      )
    )
  ]
  | from_entries
)
