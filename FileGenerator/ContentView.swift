//
//  ContentView.swift
//  FileGenerator
//
//  Created by Alex Morral on 11/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
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

            Picker("Type of files", selection: $viewModel.generatorSelected) {
                ForEach(GeneratorType.allCases, id: \.self) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)
            .padding(.vertical)

            VStack(spacing: 12) {
                Text("The following files will be generated in your Downloads folder:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading) {
                    ForEach(viewModel.generatorSelected.fileNames, id: \.self) { fileName in
                        Text(fileName.replacingOccurrences(
                            of: FileGenerator<MVVMTemplate>.templateString,
                            with: viewModel.templateName)
                        )
                    }
                }

            }
            .padding()

            Text(viewModel.statusString)
                .foregroundColor(viewModel.viewStatus == .error ? .red : .blue)

            Button(action: viewModel.generateButtonTapped) {
                Text("Generate files")
            }
            .padding()
        }
        .padding()
        .fixedSize()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
