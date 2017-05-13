// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class IssuePriority: EntityValue {
    public static let id: Property = CATServiceMetadata.EntityTypes.issuePriority.property(withName: "Id")

    public static let name: Property = CATServiceMetadata.EntityTypes.issuePriority.property(withName: "Name")

    public init() {
        super.init(type: CATServiceMetadata.EntityTypes.issuePriority)
    }

    open class func array(from: EntityValueList) -> Array<IssuePriority> {
        return ArrayConverter.convert(from.toArray(), Array<IssuePriority>())
    }

    open func copy() -> IssuePriority {
        return CastRequired<IssuePriority>.from(self.copyEntity())
    }

    open var id: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: IssuePriority.id))
        }
        set(value) {
            self.setOptionalValue(for: IssuePriority.id, to: IntValue.of(optional: value))
        }
    }

    open class func key(id: Int?) -> EntityKey {
        return EntityKey().with(name: "Id", value: IntValue.of(optional: id))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: IssuePriority.name))
        }
        set(value) {
            self.setOptionalValue(for: IssuePriority.name, to: StringValue.of(optional: value))
        }
    }

    open var old: IssuePriority {
        get {
            return CastRequired<IssuePriority>.from(self.oldEntity)
        }
    }
}
