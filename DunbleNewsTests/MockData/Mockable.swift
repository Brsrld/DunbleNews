//
//  Mockable.swift
//  DunbleNewsTests
//
//  Created by Barış ŞARALDI on 4.04.2023.
//

import Foundation
@testable import DunbleNews

enum FileExtensionType: String {
    case json = ".json"
}

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                responseModel: T.Type) async -> Result<T, RequestError>  where T : Decodable
}

extension Mockable {
    var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                responseModel: T.Type) async -> Result<T, RequestError> {
        guard let path = bundle.url(forResource: filename,
                                    withExtension: extensionType.rawValue) else {
            fatalError("Failed to load Json file.")
        }
        
        do {
            let data = try await Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(.unknown)
        }
    }
}

