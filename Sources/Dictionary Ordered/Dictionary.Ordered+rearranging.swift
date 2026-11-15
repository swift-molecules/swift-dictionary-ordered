public import Buffer
public import Buffer_Linear_Primitive
public import Dictionary
public import Dictionary_Ordered_Primitive
public import Hash_Indexed_Primitive
public import Hash_Table_Primitive
public import Memory
public import Memory_Allocator
public import Ownership_Shared_Primitive
public import Storage

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public mutating func removeAll<K: Swift::Hashable, V>(
        where shouldBeRemoved: (borrowing K, borrowing V) -> Bool
    )
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        var kept = Self()
        var removed = false
        forEach { key, value in
            if shouldBeRemoved(key, value) {
                removed = true
            } else {
                kept.insert(key: copy key, value: copy value)
            }
        }
        if removed { self = kept }
    }

    @inlinable
    @discardableResult
    public mutating func insert<K: Swift::Hashable, V>(
        key: K,
        value: V,
        atRank rank: Int
    ) -> V?
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        if contains(key: key) {
            return insert(key: key, value: value)
        }
        var rearranged = Self()
        var position = 0
        var placed = false
        forEach { existing, existingValue in
            if position == rank {
                rearranged.insert(key: key, value: value)
                placed = true
            }
            rearranged.insert(key: copy existing, value: copy existingValue)
            position += 1
        }
        if !placed {
            rearranged.insert(key: key, value: value)
        }
        self = rearranged
        return nil
    }
}
