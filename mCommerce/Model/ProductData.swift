//
//  Product.swift
//  mCommerce
//
//  Created by Quentin Beaudoul on 28/07/2021.
//

import Foundation
import CoreData

class ProductData: NSManagedObject, Decodable {
    enum CondingKeys: CodingKey {
        case id, name, price, image
    }
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        self.init(context: context)
        let container = try decoder.container(keyedBy: CondingKeys.self)
        self.id = try container.decode(Int16.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(Double.self, forKey: .price)
        self.image = try container.decode(String.self, forKey: .image)
    }
}

typealias Products = [ProductData]

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}
