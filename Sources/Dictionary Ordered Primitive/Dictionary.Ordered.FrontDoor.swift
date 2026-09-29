public import Buffer_Linear_Primitive
public import Buffer
public import Memory
public import Memory_Allocator
public import Storage

public import Dictionary
public import Hash_Indexed_Primitive
public import Hash_Table_Primitive
public import Ownership_Shared_Primitive
public import Store

extension __Dictionary where S: Store.`Protocol` & ~Copyable, S.Element: Swift.Hashable {

    public typealias Ordered =
        __DictionaryOrdered<Hash.Indexed<Buffer<Storage<Memory.Allocator<Memory.Heap>>.Contiguous<S.Element>>.Linear>>
}

extension __DictionaryOrdered
where
    S: ~Copyable,
    S: Store.`Protocol` & Buffer.`Protocol`
{

    public typealias Shared = __DictionaryOrdered<Ownership.Shared<S.Element, S>>
}
