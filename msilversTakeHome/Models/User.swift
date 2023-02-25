//
//  User.swift
//  msilversTakeHome
//
//  Created by Mike Silvers on 2/24/23.
//

import Foundation

/// The user information retrieved for display
/// Note: SInce we are not in control of the API endpoint, the only required field is the `id`
struct User: Identifiable, Codable {
    /// the id number for the contact
    var id: Int
    /// the contact name
    var name: String?
    /// the contact email
    var email: String?
    /// the contact phone number
    var phone: String?

    // Since we are only using a few of the available JSON fields,
    // there is no reason to parse out all of the available data -
    // just parse what we need
    enum CodingKeys: CodingKey {
        case id, name, email, phone
    }
}
