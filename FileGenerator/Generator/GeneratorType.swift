//
//  GeneratorType.swift
//  FileGenerator
//
//  Created by Alex Morral on 12/2/23.
//

import Foundation

enum GeneratorType: String, CaseIterable {
    case mvvm, uiComponent

    var title: String {
        switch self {
        case .mvvm: return "MVVM"
        case .uiComponent: return "UI Component"
        }
    }

    var fileNames: [String] {
        switch self {
        case .mvvm: return MVVMTemplate.allCases.map({ $0.templateFileName })
        case .uiComponent: return UIComponentTemplate.allCases.map({ $0.templateFileName })
        }
    }

    var generator: FileGeneratorProtocol {
        switch self {
        case .mvvm: return FileGenerator<MVVMTemplate>()
        case .uiComponent: return FileGenerator<UIComponentTemplate>()
        }
    }
}
