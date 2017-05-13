// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class IssueCategory: EntityValue {
    public static let id: Property = CATServiceMetadata.EntityTypes.issueCategory.property(withName: "Id")

    public static let name: Property = CATServiceMetadata.EntityTypes.issueCategory.property(withName: "Name")

    public init() {
        super.init(type: CATServiceMetadata.EntityTypes.issueCategory)
    }

    open class func array(from: EntityValueList) -> Array<IssueCategory> {
        return ArrayConverter.convert(from.toArray(), Array<IssueCategory>())
    }

    open func copy() -> IssueCategory {
        return CastRequired<IssueCategory>.from(self.copyEntity())
    }

    open var id: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: IssueCategory.id))
        }
        set(value) {
            self.setOptionalValue(for: IssueCategory.id, to: IntValue.of(optional: value))
        }
    }

    open class func key(id: Int?) -> EntityKey {
        return EntityKey().with(name: "Id", value: IntValue.of(optional: id))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: IssueCategory.name))
        }
        set(value) {
            self.setOptionalValue(for: IssueCategory.name, to: StringValue.of(optional: value))
        }
    }

    open var old: IssueCategory {
        get {
            return CastRequired<IssueCategory>.from(self.oldEntity)
        }
    }
}
