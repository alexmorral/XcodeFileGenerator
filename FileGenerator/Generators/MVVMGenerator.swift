//
//  MVVMGenerator.swift
//  FileGenerator
//
//  Created by Alex Morral on 11/2/23.
//

import Foundation

struct MVVMGenerator {
    static let templateString = "__TEMPLATE__"
    static let appTemplateString = "__APP__"
    static let organizationNameTemplateString = "__ORG__"

    func generate(
        organizationName: String,
        appName: String,
        templateName: String
    ) throws -> String {
        let downloadsURL = try storeDirectory(templateName: templateName)
        try FileManager.default.createDirectory(atPath: downloadsURL.path, withIntermediateDirectories: true, attributes: nil)
        for template in MVVMTemplate.allCases {
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

enum MVVMTemplate: String, Identifiable, CaseIterable {
    case configurator
    case router
    case viewModel
    case viewController
    case view
    case staticData

    var templateContent: String {
        switch self {
        case .configurator: return configuratorTemplateContent
        case .router: return routerTemplateContent
        case .viewModel: return viewModelTemplateContent
        case .viewController: return viewControllerTemplateContent
        case .view: return viewTemplateContent
        case .staticData: return staticDataTemplateContent
        }
    }

    var templateFileName: String {
        switch self {
        case .configurator: return configuratorFileName
        case .router: return routerFileName
        case .viewModel: return viewModelFileName
        case .viewController: return viewControllerFileName
        case .view: return viewFileName
        case .staticData: return staticDataFileName
        }
    }

    var id: String { rawValue }
}

extension MVVMTemplate {
    var configuratorFileName: String { "__TEMPLATE__Configurator.swift" }
    var routerFileName: String { "__TEMPLATE__Router.swift" }
    var viewModelFileName: String { "__TEMPLATE__ViewModel.swift" }
    var viewControllerFileName: String { "__TEMPLATE__ViewController.swift" }
    var viewFileName: String { "__TEMPLATE__View.swift" }
    var staticDataFileName: String { "__TEMPLATE__Data.swift" }

    var configuratorTemplateContent: String {
    """
    //
    // __TEMPLATE__Configurator.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //

    import UIKit

    /// sourcery: AutoMockable
    protocol __TEMPLATE__ConfiguratorProtocol {
        func configure(_ controller: __TEMPLATE__ViewController)
    }

    struct __TEMPLATE__Configurator: __TEMPLATE__ConfiguratorProtocol {
        func configure(_ controller: __TEMPLATE__ViewController) {
            let router = __TEMPLATE__Router(controller: controller)
            let viewModel = __TEMPLATE__ViewModel(router: router)

            controller.viewModel = viewModel
        }
    }\n
    """
    }

    var routerTemplateContent: String {
    """
    //
    // __TEMPLATE__Router.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //

    import UIKit

    /// sourcery: AutoMockable
    protocol __TEMPLATE__RouterProtocol {
        func dismiss()
    }

    class __TEMPLATE__Router: __TEMPLATE__RouterProtocol {
        private weak var controller: __TEMPLATE__ViewController?

        init(controller: __TEMPLATE__ViewController) {
            self.controller = controller
        }

        func dismiss() {
            self.controller?.dismiss(animated: true, completion: nil)
        }
    }\n
    """
    }

    var viewModelTemplateContent: String {
    """
    //
    // __TEMPLATE__ViewModel.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //

    import UIKit
    import SwiftUI

    /// sourcery: AutoMockable
    protocol __TEMPLATE__ViewModelProtocol {

    }
    
    final class __TEMPLATE__ViewModel: __TEMPLATE__ViewModelProtocol, ObservableObject {
        private let router: __TEMPLATE__RouterProtocol
    
        var staticData = __TEMPLATE__Data()
    
        init(router: __TEMPLATE__RouterProtocol) {
            self.router = router
        }
    }\n
    """
    }
    
    var viewControllerTemplateContent: String {
    """
    //
    // __TEMPLATE__ViewController.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //
    
    import UIKit
    import SwiftUI
    
    final class __TEMPLATE__ViewController: UIViewController {
    
        var viewModel: __TEMPLATE__ViewModel!
    
        private var hostingViewController: UIHostingController<__TEMPLATE__View>!
        private var rootView: __TEMPLATE__View!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
        }
    
        func setup() {
            rootView = __TEMPLATE__View(viewModel: viewModel)
            hostingViewController = UIHostingController(rootView: rootView)
            addChild(hostingViewController)
            view.addAndPin(view: hostingViewController.view)
        }
    
    }\n
    """
    }
    
    var viewTemplateContent: String {
    """
    //
    // __TEMPLATE__View.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //
    
    import SwiftUI
    
    struct __TEMPLATE__View: View {
        @ObservedObject var viewModel: __TEMPLATE__ViewModel
    
        var body: some View {
            Text("Hello world")
        }
    }
    
    struct __TEMPLATE__View_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel: __TEMPLATE__ViewModel = {
                let vc = __TEMPLATE__ViewController()
                let configurator = __TEMPLATE__Configurator()
                configurator.configure(vc)
                return vc.viewModel
            }()
            __TEMPLATE__View(viewModel: viewModel)
        }
    }\n
    """
    }
    var staticDataTemplateContent: String {
    """
    //
    // __TEMPLATE__Data.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //
    
    import Foundation
    
    struct __TEMPLATE__Data {
    
    }\n
    """
    }
}

