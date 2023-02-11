//
//  ContentView.swift
//  FileGenerator
//
//  Created by Alex Morral on 11/2/23.
//

import SwiftUI

enum Screen: String, CaseIterable {
    case mvvm, uiComponent
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var selection: Screen = Screen.mvvm

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                NavigationLink(value: Screen.mvvm) {
                    Text("MVVM")
                }
                NavigationLink(value: Screen.uiComponent) {
                    Text("UI Component")
                }
            }
        } detail: {
            switch selection {
            case .mvvm: mvvmView
            case .uiComponent: uiComponentView
            }
        }
    }

    @ViewBuilder
    var mvvmView: some View {
        VStack {
            HStack {
                Text("Organization Name:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Organization Name", text: $viewModel.organizationName)
            }

            HStack {
                Text("App Name:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("App Name", text: $viewModel.appName)
            }
            Divider()
                .padding(.vertical)
            Group {
                Text("Template Name:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Template Name", text: $viewModel.templateName)
            }
            VStack(spacing: 12) {
                Text("The following files will be generated in your Desktop:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading) {
                    ForEach(MVVMTemplate.allCases) { mvvmTemplate in
                        Text(mvvmTemplate.templateFileName.replacingOccurrences(of: MVVMGenerator.templateString, with: viewModel.templateName))
                    }
                }

            }
            .padding()

            Text(viewModel.statusString)
                .foregroundColor(viewModel.viewStatus == .error ? .red : .blue)

            Button(action: viewModel.generateMVVMTapped) {
                Text("Generate")
            }
            .padding()
        }
        .padding()
    }

    @ViewBuilder
    var uiComponentView: some View {
        Text("UI Component")
        Button(action: viewModel.generateUIComponentTapped) {
            Text("Generate")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
