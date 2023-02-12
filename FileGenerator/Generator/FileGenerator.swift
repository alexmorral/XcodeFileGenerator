//
//  FileGenerator.swift
//  FileGenerator
//
//  Created by Alex Morral on 12/2/23.
//

import Foundation

protocol FileGeneratorProtocol {
    static var templateString: String { get }
    static var appTemplateString: String { get }
    static var organizationNameTemplateString: String { get }

    func generate(
        organizationName: String,
        appName: String,
        templateName: String
    ) throws -> String
}

extension FileGeneratorProtocol {
    static var templateString: String { "__TEMPLATE__" }
    static var appTemplateString: String { "__APP__" }
    static var organizationNameTemplateString: String { "__ORG__" }
}

struct FileGenerator<T: FileTemplate>: FileGeneratorProtocol {
    static var templateString: String { "__TEMPLATE__" }
    static var appTemplateString: String { "__APP__" }
    static var organizationNameTemplateString: String { "__ORG__" }

    func generate(
        organizationName: String,
        appName: String,
        templateName: String
    ) throws -> String {
        let downloadsURL = try storeDirectory(templateName: templateName)
        try FileManager.default.createDirectory(atPath: downloadsURL.path, withIntermediateDirectories: true, attributes: nil)
        for template in T.allCases {
            let fileName = template.templateFileName.replacingOccurrences(of: Self.templateString, with: templateName)
            let url = downloadsURL.appendingPathComponent(fileName)
            var content = template.templateContent.replacingOccurrences(of: Self.templateString, with: templateName)
            content = content.replacingOccurrences(of: Self.appTemplateString, with: appName)
            content = content.replacingOccurrences(of: Self.organizationNameTemplateString, with: organizationName)
            try content.write(to: url, atomically: true, encoding: .utf8)
        }
        return downloadsURL.path
    }

    private func storeDirectory(templateName: String) throws -> URL {
        try FileManager.default.url(
            for: .downloadsDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ).appendingPathComponent(templateName)
    }
}
