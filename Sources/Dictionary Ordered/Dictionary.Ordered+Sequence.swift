public import Buffer
public import Cardinal
public import Dictionary_Ordered_Primitive
public import Store

extension __DictionaryOrdered: Swift::Sequence
where S: Copyable & Store.`Protocol` & Buffer.`Protocol`, S.Element: Copyable {

    public typealias Element = S.Element

    @inlinable
    public func makeIterator() -> Iterator {
        Iterator(base: self)
    }

    @inlinable
    public var underestimatedCount: Int {
        Int(bitPattern: store.count)
    }
}
