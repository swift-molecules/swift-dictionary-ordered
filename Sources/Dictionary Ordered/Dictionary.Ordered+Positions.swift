public import Buffer_Linear_Primitive
public import Buffer
public import Memory
public import Memory_Allocator
public import Memory_Allocator_Protocol
public import Storage

public import Dictionary_Ordered_Primitive
public import Dictionary
public import Hash_Indexed_Primitive
public import Hash_Table_Primitive
public import Index
import Ordinal
public import Ownership_Shared_Primitive

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public func index<K: Swift.Hashable & ~Copyable, V: ~Copyable>(
        forKey key: borrowing K
    ) -> Index::Index<Hash.Entry<K, V>>?
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        store.position(
            matching: Hash.Value(_unchecked: key.hashValue),
            context: key,
            equals: { (candidate: borrowing Hash.Entry<K, V>, probe: borrowing K) in
                candidate.key == probe
            }
        )
    }

    @inlinable
    public func index<K: Swift.Hashable & ~Copyable, V: ~Copyable>(
        forKey key: borrowing K
    ) -> Index::Index<Hash.Entry<K, V>>?
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        store.withColumn { column in
            column.position(
                matching: Hash.Value(_unchecked: key.hashValue),
                context: key,
                equals: { (candidate: borrowing Hash.Entry<K, V>, probe: borrowing K) in
                    candidate.key == probe
                }
            )
        }
    }
}

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public func key<K: Swift.Hashable, V: ~Copyable>(
        at position: Index::Index<Hash.Entry<K, V>>
    ) -> K
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        precondition(
            position < store.count.map(Ordinal.init),
            "ordered index domain: position out of bounds"
        )
        return store[position].key
    }

    @inlinable
    public func key<K: Swift.Hashable, V: ~Copyable>(
        at position: Index::Index<Hash.Entry<K, V>>
    ) -> K
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        store.withColumn { column in
            precondition(
                position < column.count.map(Ordinal.init),
                "ordered index domain: position out of bounds"
            )
            return column[position].key
        }
    }

    @inlinable
    public func value<K: Swift.Hashable & ~Copyable, V>(
        at position: Index::Index<Hash.Entry<K, V>>
    ) -> V
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        precondition(
            position < store.count.map(Ordinal.init),
            "ordered index domain: position out of bounds"
        )
        return store[position].value
    }

    @inlinable
    public func value<K: Swift.Hashable & ~Copyable, V>(
        at position: Index::Index<Hash.Entry<K, V>>
    ) -> V
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        store.withColumn { column in
            precondition(
                position < column.count.map(Ordinal.init),
                "ordered index domain: position out of bounds"
            )
            return column[position].value
        }
    }

    @inlinable
    public func entry<K: Swift.Hashable, V>(
        at position: Index::Index<Hash.Entry<K, V>>
    ) -> (key: K, value: V)
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        precondition(
            position < store.count.map(Ordinal.init),
            "ordered index domain: position out of bounds"
        )
        return (key: store[position].key, value: store[position].value)
    }

    @inlinable
    public func entry<K: Swift.Hashable, V>(
        at position: Index::Index<Hash.Entry<K, V>>
    ) -> (key: K, value: V)
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        store.withColumn { column in
            precondition(
                position < column.count.map(Ordinal.init),
                "ordered index domain: position out of bounds"
            )
            return (key: column[position].key, value: column[position].value)
        }
    }

    @inlinable
    public func withValue<K: Swift.Hashable & ~Copyable, V: ~Copyable, R>(
        at position: Index::Index<Hash.Entry<K, V>>,
        _ body: (borrowing V) -> R
    ) -> R
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        precondition(
            position < store.count.map(Ordinal.init),
            "ordered index domain: position out of bounds"
        )
        return body(store[position].value)
    }

    @inlinable
    public func withValue<K: Swift.Hashable & ~Copyable, V: ~Copyable, R>(
        at position: Index::Index<Hash.Entry<K, V>>,
        _ body: (borrowing V) -> R
    ) -> R
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        store.withColumn { column in
            precondition(
                position < column.count.map(Ordinal.init),
                "ordered index domain: position out of bounds"
            )
            return body(column[position].value)
        }
    }
}

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public mutating func withMutableValue<K: Swift.Hashable & ~Copyable, V: ~Copyable, R>(
        at position: Index::Index<Hash.Entry<K, V>>,
        _ body: (inout V) -> R
    ) -> R
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        precondition(
            position < store.count.map(Ordinal.init),
            "ordered index domain: position out of bounds"
        )
        return body(&store[position].value)
    }

    @inlinable
    public mutating func withMutableValue<K: Swift.Hashable & ~Copyable, V: ~Copyable, R>(
        at position: Index::Index<Hash.Entry<K, V>>,
        _ body: (inout V) -> R
    ) -> R
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        store.withUnique { column in
            precondition(
                position < column.count.map(Ordinal.init),
                "ordered index domain: position out of bounds"
            )
            return body(&column[position].value)
        }
    }
}
