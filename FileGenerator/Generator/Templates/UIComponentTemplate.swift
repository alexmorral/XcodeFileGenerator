//
//  UIComponentGenerator.swift
//  FileGenerator
//
//  Created by Alex Morral on 12/2/23.
//

import Foundation

enum UIComponentTemplate: String, FileTemplate {
    case view
    case content
    case style

    var templateContent: String {
        switch self {
        case .view: return viewTemplateContent
        case .content: return contentTemplateContent
        case .style: return styleTemplateContent
        }
    }

    var templateFileName: String {
        switch self {
        case .view: return viewFileName
        case .content: return contentFileName
        case .style: return styleFileName
        }
    }

    var id: String { rawValue }
}

extension UIComponentTemplate {
    var viewFileName: String { "__TEMPLATE__.swift" }
    var contentFileName: String { "__TEMPLATE__Content.swift" }
    var styleFileName: String { "__TEMPLATE__Style.swift" }

    var viewTemplateContent: String {
    """
    //
    // __TEMPLATE__.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //

    import SwiftUI

    public struct __TEMPLATE__: View {
        @ObservedObject public var style: __TEMPLATE__Style
        @ObservedObject public var content: __TEMPLATE__Content

        public init(
            style: __TEMPLATE__Style,
            content: __TEMPLATE__Content
        ) {
            self.style = style
            self.content = content
        }

        public var body: some View {
            Text("Hello World")
        }
    }

    struct __TEMPLATE___Previews: PreviewProvider {
        public static var previewItems: [__TEMPLATE__] = [
            __TEMPLATE__(
                style: .default,
                content: .init()
            )
        ]

        public static var previews: some View {
            VStack {
                ForEach(0..<previewItems.count, id: \\.self) { index in
                    previewItems[index]
                        .previewLayout(PreviewLayout.sizeThatFits)
                }
            }
        }
    }\n
    """
    }

    var contentTemplateContent: String {
    """
    //
    // __TEMPLATE__Content.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //

    import SwiftUI

    public class __TEMPLATE__Content: ObservableObject {

        public init() {}

    }\n
    """
    }

    var styleTemplateContent: String {
    """
    //
    // __TEMPLATE__Style.swift
    // __APP__
    //
    // Copyright © \(Calendar.current.component(.year, from: Date())) __ORG__. All rights reserved.
    //

    import SwiftUI

    public class __TEMPLATE__Style: ObservableObject {

        public init() {}

    }

    public extension __TEMPLATE__Style {
        static let `default` = __TEMPLATE__Style()
    }\n
    """
    }
}

