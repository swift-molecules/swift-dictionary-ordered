public import Buffer_Linear_Primitive
public import Buffer
public import Memory
public import Memory_Allocator
public import Storage

public import Dictionary
public import Hash_Indexed_Primitive
public import Hash_Table_Primitive
import Index
public import Ownership_Shared_Primitive
public import Cardinal
public import Tagged
public import Memory_Allocator_Protocol

@_documentation(visibility: public)
@frozen
public struct __DictionaryOrdered<S: ~Copyable>: ~Copyable {

    @usableFromInline
    package var store: S

    @inlinable
    public init(store: consuming S) {
        self.store = store
    }
}

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public consuming func take() -> S {
        store
    }
}

extension __DictionaryOrdered: Copyable where S: Copyable {}

extension __DictionaryOrdered: Sendable where S: Sendable & ~Copyable {}

extension __DictionaryOrdered where S: ~Copyable {

    @inlinable
    public init<K: Swift::Hashable & ~Copyable, V: ~Copyable>(
        minimumCapacity: Tagged<Hash.Entry<K, V>, Cardinal> = .zero
    )
    where S == Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear> {
        self.init(store: S(minimumCapacity: minimumCapacity))
    }

    @inlinable
    public init<K: Swift::Hashable, V>(
        minimumCapacity: Tagged<Hash.Entry<K, V>, Cardinal> = .zero
    )
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        self.init(
            store: Ownership.Shared(
                Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>(minimumCapacity: minimumCapacity)
            )
        )
    }

    @inlinable
    public init<K: Swift::Hashable & ~Copyable, V: ~Copyable>(
        minimumCapacity: Tagged<Hash.Entry<K, V>, Cardinal> = .zero
    )
    where S == Ownership.Shared<Hash.Entry<K, V>, Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>> {
        self.init(
            store: Ownership.Shared(
                Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<Hash.Entry<K, V>>>.Linear>(minimumCapacity: minimumCapacity)
            )
        )
    }
}
