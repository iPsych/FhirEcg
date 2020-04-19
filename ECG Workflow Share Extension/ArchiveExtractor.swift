//
//  Unzipper.swift
//  ECG Workflow Share Extension
//
//  Created by Yannick Börner on 22.01.20.
//  Copyright © 2020 Berlin Institute of Health. All rights reserved.
//

import Foundation
import ZIPFoundation

struct Unzipper {
    
    let fileManager = FileManager()
    let appBundleDocumentsUrl: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    func unzipFile(pathToZip: String) {
        // Clean up previous exports
        deletePreviousExports()
        
        // Unzip archive
        do {
            try fileManager.unzipItem(at: URL(fileURLWithPath: pathToZip), to: appBundleDocumentsUrl)
        } catch {
            print("Extraction of ZIP archive failed with error:\(error)")
        }
    }
    
    private func deletePreviousExports() {
        let pathToPreviousExport = appBundleDocumentsUrl.appendingPathComponent("apple_health_export")
    
        do {
            try fileManager.removeItem(at: pathToPreviousExport)
        } catch {
            print("No previous exports were found")
        }
    }
    
    // For debugging purposes
    private func printContentsOfDirectory(directory: URL) {
        if let allItems = try? FileManager.default.contentsOfDirectory(atPath: directory.relativePath) {
            print("Directory: " + directory.relativePath + "contains the following files:")
            print(allItems)
        }
    }
}
