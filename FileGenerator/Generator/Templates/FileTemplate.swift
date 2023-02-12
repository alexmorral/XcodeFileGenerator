//
//  FileTemplate.swift
//  FileGenerator
//
//  Created by Alex Morral on 12/2/23.
//

import Foundation

protocol FileTemplate: Identifiable, CaseIterable {
    var templateContent: String { get }
    var templateFileName: String { get }
}
