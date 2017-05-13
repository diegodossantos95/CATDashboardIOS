// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

public class CATServiceMetadata {
    public static let source: String = "<?xml version='1.0' encoding='UTF-8'?><edmx:Edmx xmlns:edmx=\"http://schemas.microsoft.com/ado/2007/06/edmx\" Version=\"1.0\"><edmx:DataServices m:DataServiceVersion=\"1.0\" xmlns:m=\"http://schemas.microsoft.com/ado/2007/08/dataservices/metadata\"><Schema Namespace=\"catIssuesBackend\" xmlns=\"http://schemas.microsoft.com/ado/2008/09/edm\"><EntityType Name=\"Issue\"><Key><PropertyRef Name=\"Id\"/></Key><Property Name=\"Category\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Description\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"255\"/><Property Name=\"Id\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"255\"/><Property Name=\"Priority\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Project\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Status\" Type=\"Edm.Int32\" Nullable=\"false\"/><NavigationProperty Name=\"IssueCategoryDetails\" Relationship=\"catIssuesBackend.Issue_IssueCategory_Many_ZeroToOne0\" FromRole=\"Issue\" ToRole=\"IssueCategory\"/><NavigationProperty Name=\"IssuePriorityDetails\" Relationship=\"catIssuesBackend.Issue_IssuePriority_Many_ZeroToOne0\" FromRole=\"Issue\" ToRole=\"IssuePriority\"/><NavigationProperty Name=\"ProjectDetails\" Relationship=\"catIssuesBackend.Issue_Project_Many_ZeroToOne0\" FromRole=\"Issue\" ToRole=\"Project\"/><NavigationProperty Name=\"IssueStatusDetails\" Relationship=\"catIssuesBackend.Issue_IssueStatus_Many_ZeroToOne0\" FromRole=\"Issue\" ToRole=\"IssueStatus\"/></EntityType><EntityType Name=\"IssueCategory\"><Key><PropertyRef Name=\"Id\"/></Key><Property Name=\"Id\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"255\"/></EntityType><EntityType Name=\"IssuePriority\"><Key><PropertyRef Name=\"Id\"/></Key><Property Name=\"Id\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"255\"/></EntityType><EntityType Name=\"IssueStatus\"><Key><PropertyRef Name=\"Id\"/></Key><Property Name=\"Id\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"255\"/></EntityType><EntityType Name=\"Project\"><Key><PropertyRef Name=\"Id\"/></Key><Property Name=\"EndDate\" Type=\"Edm.DateTime\" Nullable=\"false\"/><Property Name=\"Id\" Type=\"Edm.Int32\" Nullable=\"false\"/><Property Name=\"Name\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"255\"/><Property Name=\"StartDate\" Type=\"Edm.DateTime\" Nullable=\"false\"/><NavigationProperty Name=\"IssueDetails\" Relationship=\"catIssuesBackend.Issue_Project_Many_ZeroToOne0\" FromRole=\"Project\" ToRole=\"Issue\"/></EntityType><Association Name=\"Issue_IssueCategory_Many_ZeroToOne0\"><End Type=\"catIssuesBackend.Issue\" Multiplicity=\"*\" Role=\"Issue\"/><End Type=\"catIssuesBackend.IssueCategory\" Multiplicity=\"0..1\" Role=\"IssueCategory\"/><ReferentialConstraint><Principal Role=\"IssueCategory\"><PropertyRef Name=\"Id\"/></Principal><Dependent Role=\"Issue\"><PropertyRef Name=\"Category\"/></Dependent></ReferentialConstraint></Association><Association Name=\"Issue_IssuePriority_Many_ZeroToOne0\"><End Type=\"catIssuesBackend.Issue\" Multiplicity=\"*\" Role=\"Issue\"/><End Type=\"catIssuesBackend.IssuePriority\" Multiplicity=\"0..1\" Role=\"IssuePriority\"/><ReferentialConstraint><Principal Role=\"IssuePriority\"><PropertyRef Name=\"Id\"/></Principal><Dependent Role=\"Issue\"><PropertyRef Name=\"Priority\"/></Dependent></ReferentialConstraint></Association><Association Name=\"Issue_Project_Many_ZeroToOne0\"><End Type=\"catIssuesBackend.Issue\" Multiplicity=\"*\" Role=\"Issue\"/><End Type=\"catIssuesBackend.Project\" Multiplicity=\"0..1\" Role=\"Project\"/><ReferentialConstraint><Principal Role=\"Project\"><PropertyRef Name=\"Id\"/></Principal><Dependent Role=\"Issue\"><PropertyRef Name=\"Project\"/></Dependent></ReferentialConstraint></Association><Association Name=\"Issue_IssueStatus_Many_ZeroToOne0\"><End Type=\"catIssuesBackend.Issue\" Multiplicity=\"*\" Role=\"Issue\"/><End Type=\"catIssuesBackend.IssueStatus\" Multiplicity=\"0..1\" Role=\"IssueStatus\"/><ReferentialConstraint><Principal Role=\"IssueStatus\"><PropertyRef Name=\"Id\"/></Principal><Dependent Role=\"Issue\"><PropertyRef Name=\"Status\"/></Dependent></ReferentialConstraint></Association><EntityContainer Name=\"catIssuesBackendContainer\" m:IsDefaultEntityContainer=\"true\"><EntitySet Name=\"Issues\" EntityType=\"catIssuesBackend.Issue\"/><EntitySet Name=\"IssueCategories\" EntityType=\"catIssuesBackend.IssueCategory\"/><EntitySet Name=\"IssuePriorities\" EntityType=\"catIssuesBackend.IssuePriority\"/><EntitySet Name=\"IssueStatuses\" EntityType=\"catIssuesBackend.IssueStatus\"/><EntitySet Name=\"Projects\" EntityType=\"catIssuesBackend.Project\"/><AssociationSet Name=\"Issue_IssueCategory_Many_ZeroToOne0Set\" Association=\"catIssuesBackend.Issue_IssueCategory_Many_ZeroToOne0\"><End EntitySet=\"Issues\" Role=\"Issue\"/><End EntitySet=\"IssueCategories\" Role=\"IssueCategory\"/></AssociationSet><AssociationSet Name=\"Issue_IssuePriority_Many_ZeroToOne0Set\" Association=\"catIssuesBackend.Issue_IssuePriority_Many_ZeroToOne0\"><End EntitySet=\"Issues\" Role=\"Issue\"/><End EntitySet=\"IssuePriorities\" Role=\"IssuePriority\"/></AssociationSet><AssociationSet Name=\"Issue_Project_Many_ZeroToOne0Set\" Association=\"catIssuesBackend.Issue_Project_Many_ZeroToOne0\"><End EntitySet=\"Issues\" Role=\"Issue\"/><End EntitySet=\"Projects\" Role=\"Project\"/></AssociationSet><AssociationSet Name=\"Issue_IssueStatus_Many_ZeroToOne0Set\" Association=\"catIssuesBackend.Issue_IssueStatus_Many_ZeroToOne0\"><End EntitySet=\"Issues\" Role=\"Issue\"/><End EntitySet=\"IssueStatuses\" Role=\"IssueStatus\"/></AssociationSet></EntityContainer></Schema></edmx:DataServices></edmx:Edmx>\n"

    internal static let parsed: CSDLDocument = CATServiceMetadata.parse()

    public static let document: CSDLDocument = CATServiceMetadata.resolve()

    static func parse() -> CSDLDocument {
        let parser: CSDLParser = CSDLParser()
        parser.logWarnings = false
        parser.csdlOptions = (CSDLOption.processMixedVersions | CSDLOption.retainOriginalText | CSDLOption.ignoreUndefinedTerms)
        return parser.parseInProxy(CATServiceMetadata.source, url: "catIssuesBackend")
    }

    static func resolve() -> CSDLDocument {
        CATServiceMetadata.EntityTypes.issue.registerFactory(ObjectFactory.with(create: { Issue() }))
        CATServiceMetadata.EntityTypes.issueCategory.registerFactory(ObjectFactory.with(create: { IssueCategory() }))
        CATServiceMetadata.EntityTypes.issuePriority.registerFactory(ObjectFactory.with(create: { IssuePriority() }))
        CATServiceMetadata.EntityTypes.issueStatus.registerFactory(ObjectFactory.with(create: { IssueStatus() }))
        CATServiceMetadata.EntityTypes.project.registerFactory(ObjectFactory.with(create: { Project() }))
        return CATServiceMetadata.parsed
    }

    public class EntityTypes {
        public static let issue: EntityType = CATServiceMetadata.parsed.entityType(withName: "catIssuesBackend.Issue")

        public static let issueCategory: EntityType = CATServiceMetadata.parsed.entityType(withName: "catIssuesBackend.IssueCategory")

        public static let issuePriority: EntityType = CATServiceMetadata.parsed.entityType(withName: "catIssuesBackend.IssuePriority")

        public static let issueStatus: EntityType = CATServiceMetadata.parsed.entityType(withName: "catIssuesBackend.IssueStatus")

        public static let project: EntityType = CATServiceMetadata.parsed.entityType(withName: "catIssuesBackend.Project")
    }

    public class EntitySets {
        public static let issueCategories: EntitySet = CATServiceMetadata.parsed.entitySet(withName: "IssueCategories")

        public static let issuePriorities: EntitySet = CATServiceMetadata.parsed.entitySet(withName: "IssuePriorities")

        public static let issueStatuses: EntitySet = CATServiceMetadata.parsed.entitySet(withName: "IssueStatuses")

        public static let issues: EntitySet = CATServiceMetadata.parsed.entitySet(withName: "Issues")

        public static let projects: EntitySet = CATServiceMetadata.parsed.entitySet(withName: "Projects")
    }
}
