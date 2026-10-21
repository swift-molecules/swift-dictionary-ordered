public import Buffer
public import Cardinal
public import Dictionary_Ordered_Primitive
import Index
public import Store
public import Tagged

extension __DictionaryOrdered where S: ~Copyable, S: Store.`Protocol` & Buffer.`Protocol` {

    @inlinable
    public var count: Tagged<S.Element, Cardinal> { store.count }

    @inlinable
    public var isEmpty: Bool { store.isEmpty }

    @inlinable
    public var capacity: Tagged<S.Element, Cardinal> { store.capacity }
}

extension __DictionaryOrdered where S: Copyable, S: Store.`Protocol` {

    @inlinable
    public borrowing func clone() -> Self {
        var result = copy self
        result.store.unshare()
        return result
    }
}
