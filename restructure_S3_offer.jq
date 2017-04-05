#!/usr/bin/env jq -f

.terms.OnDemand as $termsOnDemand
| del(.terms)

| .products = (
  [
    .products
    | to_entries[]
    | .value.terms.OnDemand = (
      $termsOnDemand[.key]
    )
  ]
  | from_entries
)
