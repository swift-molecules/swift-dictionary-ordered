public import Buffer_Linear_Primitive
public import Buffer
public import Column
public import Dictionary
public import Hash_Indexed_Primitive
import Hash
public import Index
public import Memory_Allocator
public import Memory
public import Ownership_Shared_Primitive
public import Storage_Memory
public import Storage

@_documentation(visibility: public)
@frozen
public struct __DictionaryOrdered<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var store: S

    @inlinable
    public init(store: consuming S) {
        self.store = store
    }

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __DictionaryOrdered: Copyable where S: Copyable {}

extension __DictionaryOrdered: Sendable where S: Sendable & ~Copyable {}

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public init<K: Hash.Key & ~Copyable, V: ~Copyable>(
        minimumCapacity: Index.Index<Hash.Entry<K, V>>.Count = .zero
    )
    where S == Hash.Indexed<Column.Heap<Hash.Entry<K, V>>> {
        self.init(store: S(minimumCapacity: minimumCapacity))
    }

    @inlinable
    public init<K: Hash.Key, V>(
        minimumCapacity: Index.Index<Hash.Entry<K, V>>.Count = .zero
    )
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Column.Heap<Hash.Entry<K, V>>>> {
        self.init(
            store: Ownership.Shared(
                Hash.Indexed<Column.Heap<Hash.Entry<K, V>>>(minimumCapacity: minimumCapacity)
            )
        )
    }

    @inlinable
    public init<K: Hash.Key & ~Copyable, V: ~Copyable>(
        minimumCapacity: Index.Index<Hash.Entry<K, V>>.Count = .zero
    )
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Column.Heap<Hash.Entry<K, V>>>> {
        self.init(
            store: Ownership.Shared(
                Hash.Indexed<Column.Heap<Hash.Entry<K, V>>>(minimumCapacity: minimumCapacity)
            )
        )
    }
}
