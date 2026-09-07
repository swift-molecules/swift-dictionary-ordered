public import Index
public import Store

extension __DictionaryOrdered where S: Store.`Protocol` & ~Copyable {

    public typealias Index = Index.Index<S.Element>
}
