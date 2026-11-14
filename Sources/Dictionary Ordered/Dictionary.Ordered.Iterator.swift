public import Buffer
public import Cardinal
public import Dictionary_Ordered_Primitive
public import Index
import Ordinal
public import Store
public import Tagged

extension __DictionaryOrdered where S: Copyable & Store.`Protocol` & Buffer.`Protocol`, S.Element: Copyable {

    @frozen
    public struct Iterator: Swift::IteratorProtocol {
        @usableFromInline
        let base: __DictionaryOrdered<S>

        @usableFromInline
        var position: Index::Index<S.Element>

        @inlinable
        init(base: __DictionaryOrdered<S>) {
            self.base = base
            self.position = .zero
        }

        @inlinable
        public mutating func next() -> S.Element? {
            guard position < base.store.count.map(Ordinal.init) else { return nil }
            defer { position += .one }
            return base.store[position]
        }
    }
}
