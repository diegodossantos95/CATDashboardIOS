// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class IssueStatus: EntityValue {
    public static let id: Property = CATServiceMetadata.EntityTypes.issueStatus.property(withName: "Id")

    public static let name: Property = CATServiceMetadata.EntityTypes.issueStatus.property(withName: "Name")

    public init() {
        super.init(type: CATServiceMetadata.EntityTypes.issueStatus)
    }

    open class func array(from: EntityValueList) -> Array<IssueStatus> {
        return ArrayConverter.convert(from.toArray(), Array<IssueStatus>())
    }

    open func copy() -> IssueStatus {
        return CastRequired<IssueStatus>.from(self.copyEntity())
    }

    open var id: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: IssueStatus.id))
        }
        set(value) {
            self.setOptionalValue(for: IssueStatus.id, to: IntValue.of(optional: value))
        }
    }

    open class func key(id: Int?) -> EntityKey {
        return EntityKey().with(name: "Id", value: IntValue.of(optional: id))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: IssueStatus.name))
        }
        set(value) {
            self.setOptionalValue(for: IssueStatus.name, to: StringValue.of(optional: value))
        }
    }

    open var old: IssueStatus {
        get {
            return CastRequired<IssueStatus>.from(self.oldEntity)
        }
    }
}
