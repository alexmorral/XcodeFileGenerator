//
//  ContentViewModel.swift
//  FileGenerator
//
//  Created by Alex Morral on 11/2/23.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var organizationName: String
    @Published var appName: String
    @Published var templateName: String = FileGenerator<MVVMTemplate>.templateString

    @Published var generatorSelected: GeneratorType = .mvvm

    enum ViewStatus {
        case error
        case idle
    }

    @Published var viewStatus = ViewStatus.idle
    @Published var statusString: String = ""

    enum ViewError: Error, LocalizedError {
        case organizationNameEmpty
        case appNameEmpty
        case templateNameInvalid

        public var errorDescription: String? {
            switch self {
            case .organizationNameEmpty: return "Organization Name cannot be empty"
            case .appNameEmpty: return "App Name cannot be empty"
            case .templateNameInvalid: return "Template name is invalid"
            }
        }
    }

    init() {
        organizationName = UserDefaults.standard.value(forKey: "organization_name_key") as? String ?? ""
        appName = UserDefaults.standard.value(forKey: "app_name_key") as? String ?? ""
    }

    func generateButtonTapped() {
        do {
            statusString = ""
            try validateFields()
            let storePath = try generatorSelected.generator.generate(
                organizationName: organizationName,
                appName: appName,
                templateName: templateName
            )
            storeNamesToUserDefaults()
            viewStatus = .idle
            statusString = "Files generated in \(storePath)"
        } catch {
            viewStatus = .error
            statusString = error.localizedDescription
        }
    }

    private func storeNamesToUserDefaults() {
        UserDefaults.standard.set(organizationName, forKey: "organization_name_key")
        UserDefaults.standard.set(appName, forKey: "app_name_key")
        UserDefaults.standard.synchronize()
    }

    private func validateFields() throws {
        if organizationName.isEmpty { throw ViewError.organizationNameEmpty }
        if appName.isEmpty { throw ViewError.appNameEmpty }
        if templateName == FileGenerator<MVVMTemplate>.templateString { throw ViewError.templateNameInvalid }
    }
}
