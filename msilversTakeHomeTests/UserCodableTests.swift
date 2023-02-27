//
//  UserCodableTests.swift
//  msilversTakeHomeTests
//
//  Created by Mike Silvers on 2/24/23.
//

import XCTest

final class UserCodableTests: XCTestCase {

    // MARK: Testing functions
    
    /// Test the decoding of the array of `User` objects
    func testUserDecode() throws {
        
        // make sure the user data is correctly created from the literal string
        guard let userData = userJSON.data(using: .utf8) else {
            // without the JSON data, we can not continue with tests
            XCTFail("There was an error creating `Data` from the literal string")
            return
        }
        
        // setup the decoder
        let decoder = JSONDecoder()
        
        do {
            
            // do the actual decode
            let userArray = try decoder.decode([User].self, from: userData)
            
            // check for the number of users
            XCTAssertEqual(userArray.count, 10, "Expecting 10 `User` objects, found \(userArray.count)")

            // loop thru the user array
            for (idx, testUser) in userArray.enumerated() {
                
                // perform the actual tests - the errors will be listed
                checkUser(testUser, idx)
            }
            
            
        } catch {
            XCTFail("There was a problem decoding the User object.")
        }
    }


    // MARK: Supporting functions
    
    /// Function to test the values expected VS the values received
    /// - Parameter user: The `User` object to be tested
    /// - Parameter position: An `Int` representing the
    private func checkUser(_ testUser: User, _ position: Int) {
        
        // quick note on the nil values - we could do a test for nil (XCTAssertNil), but we are setting the nil values to blanck strings since they are all strings
        // If in the future actual nil values need to be tested, some adjustment will need to be done here (for example, have a nil check array and check accorgin to the position)
        // in addition, if we are dealing with large data sets, we could do simple array lookups to determine if the calue exists in the array rather than checking the actual
        // array position.
        XCTAssertEqual(testUser.id, userIdExpected[position], "Expecting `id` of \(userIdExpected[position]), actual \(testUser.id)")
        XCTAssertEqual(testUser.name ?? "", namesExpected[position], "Expecting `name` of \(namesExpected[position]), actual '\(testUser.name ?? "")'")
        XCTAssertEqual(testUser.email ?? "", emailExpected[position], "Expecting `email` of '\(emailExpected[position])', actual '\(testUser.email ?? "")'")
        XCTAssertEqual(testUser.phone ?? "", phoneExpected[position], "Expecting `phone` of '\(phoneExpected[position])', actual '\(testUser.phone ?? "")'")
        
    }
    
    // MARK: Supporting variables

    /// user ID expexted
    let userIdExpected = [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10]
    
    /// Names expected
    let namesExpected = [
        "Leanne Graham",
        "Ervin Howell",
        "",
        "Patricia Lebsack",
        "",
        "Mrs. Dennis Schulist",
        "Kurtis Weissnat",
        "Nicholas Runolfsdottir V",
        "Glenna Reichert",
        "Clementina DuBuque"]

    /// Email expected
    let emailExpected = [
        "Sincere@april.biz",
        "Shanna@melissa.tv",
        "Nathan@yesenia.net",
        "",
        "",
        "",
        "Telly.Hoeger@billy.biz",
        "Sherwood@rosamond.me",
        "Chaim_McDermott@dana.io",
        "Rey.Padberg@karina.biz"]

    /// Phone expected
    let phoneExpected = [
        "1-770-736-8031 x56442",
        "010-692-6593 x09125",
        "1-463-123-4447",
        "493-170-9623 x156",
        "(254)954-1289",
        "",
        "",
        "586.493.6943 x140",
        "(775)976-6794 x41206",
        "024-648-3804"]

    /// JSON returned for the `User` object
    let userJSON = """
[
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  },
  {
    "id": 2,
    "name": "Ervin Howell",
    "email": "Shanna@melissa.tv",
    "phone": "010-692-6593 x09125"
  },
  {
    "id": 3,
    "email": "Nathan@yesenia.net",
    "phone": "1-463-123-4447"
  },
  {
    "id": 4,
    "name": "Patricia Lebsack",
    "phone": "493-170-9623 x156"
  },
  {
    "id": 5,
    "phone": "(254)954-1289"
  },
  {
    "id": 6,
    "name": "Mrs. Dennis Schulist"
  },
  {
    "id": 7,
    "name": "Kurtis Weissnat",
    "email": "Telly.Hoeger@billy.biz"
  },
  {
    "id": 8,
    "name": "Nicholas Runolfsdottir V",
    "username": "Maxime_Nienow",
    "email": "Sherwood@rosamond.me",
    "address": {
      "street": "Ellsworth Summit",
      "suite": "Suite 729",
      "city": "Aliyaview",
      "zipcode": "45169",
      "geo": {
        "lat": "-14.3990",
        "lng": "-120.7677"
      }
    },
    "phone": "586.493.6943 x140",
    "website": "jacynthe.com",
    "company": {
      "name": "Abernathy Group",
      "catchPhrase": "Implemented secondary concept",
      "bs": "e-enable extensible e-tailers"
    }
  },
  {
    "id": 9,
    "name": "Glenna Reichert",
    "username": "Delphine",
    "email": "Chaim_McDermott@dana.io",
    "address": {
      "street": "Dayna Park",
      "suite": "Suite 449",
      "city": "Bartholomebury",
      "zipcode": "76495-3109",
      "geo": {
        "lat": "24.6463",
        "lng": "-168.8889"
      }
    },
    "phone": "(775)976-6794 x41206",
    "website": "conrad.com",
    "company": {
      "name": "Yost and Sons",
      "catchPhrase": "Switchable contextually-based project",
      "bs": "aggregate real-time technologies"
    }
  },
  {
    "id": 10,
    "name": "Clementina DuBuque",
    "username": "Moriah.Stanton",
    "email": "Rey.Padberg@karina.biz",
    "address": {
      "street": "Kattie Turnpike",
      "suite": "Suite 198",
      "city": "Lebsackbury",
      "zipcode": "31428-2261",
      "geo": {
        "lat": "-38.2386",
        "lng": "57.2232"
      }
    },
    "phone": "024-648-3804",
    "website": "ambrose.net",
    "company": {
      "name": "Hoeger LLC",
      "catchPhrase": "Centralized empowering task-force",
      "bs": "target end-to-end models"
    }
  }
]
"""
    
    

}
