// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class Project: EntityValue {
    public static let endDate: Property = CATServiceMetadata.EntityTypes.project.property(withName: "EndDate")

    public static let id: Property = CATServiceMetadata.EntityTypes.project.property(withName: "Id")

    public static let name: Property = CATServiceMetadata.EntityTypes.project.property(withName: "Name")

    public static let startDate: Property = CATServiceMetadata.EntityTypes.project.property(withName: "StartDate")

    public static let issueDetails: Property = CATServiceMetadata.EntityTypes.project.property(withName: "IssueDetails")

    public init() {
        super.init(type: CATServiceMetadata.EntityTypes.project)
    }

    open class func array(from: EntityValueList) -> Array<Project> {
        return ArrayConverter.convert(from.toArray(), Array<Project>())
    }

    open func copy() -> Project {
        return CastRequired<Project>.from(self.copyEntity())
    }

    open var endDate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: Project.endDate))
        }
        set(value) {
            self.setOptionalValue(for: Project.endDate, to: value)
        }
    }

    open var id: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Project.id))
        }
        set(value) {
            self.setOptionalValue(for: Project.id, to: IntValue.of(optional: value))
        }
    }

    open var issueDetails: Array<Issue> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: Project.issueDetails)).toArray(), Array<Issue>())
        }
        set(value) {
            Project.issueDetails.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class func key(id: Int?) -> EntityKey {
        return EntityKey().with(name: "Id", value: IntValue.of(optional: id))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Project.name))
        }
        set(value) {
            self.setOptionalValue(for: Project.name, to: StringValue.of(optional: value))
        }
    }

    open var old: Project {
        get {
            return CastRequired<Project>.from(self.oldEntity)
        }
    }

    open var startDate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: Project.startDate))
        }
        set(value) {
            self.setOptionalValue(for: Project.startDate, to: value)
        }
    }
}
