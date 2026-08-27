public import Buffer_Linear_Primitive
public import Buffer_Protocol
public import Column
public import Dictionary_Primitive
public import Hash_Indexed_Primitive
import Hash
public import Memory_Allocator_Primitive
public import Memory_Heap
public import Ownership_Shared_Primitive
public import Storage_Contiguous
public import Store_Protocol

extension __Dictionary where S: Store.`Protocol` & ~Copyable, S.Element: Hash.Key {

    public typealias Ordered =
        __DictionaryOrdered<Hash.Indexed<Column.Heap<S.Element>>>
}

extension __DictionaryOrdered
where
    S: ~Copyable,
    S: Store.`Protocol` & Buffer.`Protocol`
{

    public typealias Shared = __DictionaryOrdered<Ownership.Shared<S.Element, S>>
}
