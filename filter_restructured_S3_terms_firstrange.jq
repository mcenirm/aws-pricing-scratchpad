#!/usr/bin/env jq -f

.products = (
  [
    .products
    | to_entries[]
    | .value.terms.OnDemand = (
      [
        .value.terms.OnDemand
        | to_entries[]
        | .value.priceDimensions = (
          [
            .value.priceDimensions
            | to_entries[]
            | select(
              .value.beginRange == "0"
            )
          ]
          | from_entries
        )
      ]
      | from_entries
    )
  ]
  | from_entries
)
