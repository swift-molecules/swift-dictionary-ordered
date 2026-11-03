# swift-dictionary-ordered

Use this package when you need a hash-keyed map whose entries keep the order they were first inserted in and can be reached by rank as well as by key, including move-only keys and values. Start from `Dictionary<K, V>.Ordered`, a move-only map that owns its storage, or `Dictionary<K, V>.Ordered.Shared`, its copy-on-write variant for when copies need value semantics. If order and ranks do not matter, use `Dictionary<K, V>` from swift-dictionary instead; for ordered keys without values, use swift-set-ordered.

## Laws

- Iteration order is insertion order. `forEach` visits entries by ascending rank, and `index(forKey:)` returns that rank, from zero up to `count`.
- Inserting a key that is already present replaces only its value: the stored key and its rank stay put, and the old value is returned. `withMutableValue` and the keyed subscript setter likewise keep the rank.
- Removing an entry moves every later entry down one rank, so a rank you hold becomes stale after any removal. Inserting a removed key again puts it at the end.
- Assigning `nil` through the keyed subscript removes the key.
- The positional accessors (`key(at:)`, `value(at:)`, `entry(at:)`, `withValue(at:)`, `withMutableValue(at:)`) trap when the rank is not below `count`.
- Each value is destroyed exactly once: a value that is replaced or removed goes back to the caller, and the dictionary destroys whatever it still holds when it is dropped.
- `Dictionary<K, V>.Ordered.Shared`: copies share one store until one of them mutates. Each mutation (insert, `removeValue`, either `withMutableValue`, the subscript setter) copies the store first if it is shared, so the other copies keep their entries, values and ranks. `removeAll` always starts a new store instead of clearing the shared one; `keepingCapacity` keeps only the capacity. `clone()` always returns an independent copy.
