// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class Issue: EntityValue {
    public static let category: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Category")

    public static let description: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Description")

    public static let id: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Id")

    public static let name: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Name")

    public static let priority: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Priority")

    public static let project: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Project")

    public static let status: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "Status")

    public static let issueCategoryDetails: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "IssueCategoryDetails")

    public static let issuePriorityDetails: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "IssuePriorityDetails")

    public static let projectDetails: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "ProjectDetails")

    public static let issueStatusDetails: Property = CATServiceMetadata.EntityTypes.issue.property(withName: "IssueStatusDetails")

    public init() {
        super.init(type: CATServiceMetadata.EntityTypes.issue)
    }

    open class func array(from: EntityValueList) -> Array<Issue> {
        return ArrayConverter.convert(from.toArray(), Array<Issue>())
    }

    open var category: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Issue.category))
        }
        set(value) {
            self.setOptionalValue(for: Issue.category, to: IntValue.of(optional: value))
        }
    }

    open func copy() -> Issue {
        return CastRequired<Issue>.from(self.copyEntity())
    }

    open var description: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Issue.description))
        }
        set(value) {
            self.setOptionalValue(for: Issue.description, to: StringValue.of(optional: value))
        }
    }

    open var id: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Issue.id))
        }
        set(value) {
            self.setOptionalValue(for: Issue.id, to: IntValue.of(optional: value))
        }
    }

    open var issueCategoryDetails: IssueCategory? {
        get {
            return CastOptional<IssueCategory>.from(self.optionalValue(for: Issue.issueCategoryDetails))
        }
        set(value) {
            self.setOptionalValue(for: Issue.issueCategoryDetails, to: value)
        }
    }

    open var issuePriorityDetails: IssuePriority? {
        get {
            return CastOptional<IssuePriority>.from(self.optionalValue(for: Issue.issuePriorityDetails))
        }
        set(value) {
            self.setOptionalValue(for: Issue.issuePriorityDetails, to: value)
        }
    }

    open var issueStatusDetails: IssueStatus? {
        get {
            return CastOptional<IssueStatus>.from(self.optionalValue(for: Issue.issueStatusDetails))
        }
        set(value) {
            self.setOptionalValue(for: Issue.issueStatusDetails, to: value)
        }
    }

    open class func key(id: Int?) -> EntityKey {
        return EntityKey().with(name: "Id", value: IntValue.of(optional: id))
    }

    open var name: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Issue.name))
        }
        set(value) {
            self.setOptionalValue(for: Issue.name, to: StringValue.of(optional: value))
        }
    }

    open var old: Issue {
        get {
            return CastRequired<Issue>.from(self.oldEntity)
        }
    }

    open var priority: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Issue.priority))
        }
        set(value) {
            self.setOptionalValue(for: Issue.priority, to: IntValue.of(optional: value))
        }
    }

    open var project: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Issue.project))
        }
        set(value) {
            self.setOptionalValue(for: Issue.project, to: IntValue.of(optional: value))
        }
    }

    open var projectDetails: Project? {
        get {
            return CastOptional<Project>.from(self.optionalValue(for: Issue.projectDetails))
        }
        set(value) {
            self.setOptionalValue(for: Issue.projectDetails, to: value)
        }
    }

    open var status: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Issue.status))
        }
        set(value) {
            self.setOptionalValue(for: Issue.status, to: IntValue.of(optional: value))
        }
    }
}
