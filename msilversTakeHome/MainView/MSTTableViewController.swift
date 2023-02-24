//
//  MSTTableViewController.swift
//  msilversTakeHome
//
//  Created by Mike Silvers on 2/24/23.
//

import UIKit

class MSTTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // the auto height for cell and labels
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // We are only using a single section for this display
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        
        // only process the cell if the call is able to be cast into the `MSTTableViewCell` - should never fail
        if (cell as? MSTTableViewCell) != nil {
            
            setupCell(&cell, User(id: 1,
                                  name: "This is a funny long name line and should make it two lines",
                                  email: "m@m.com",
                                  phone: "(123) 222-4536 ext 120943"))

            // set the background to give us some every other rows as grey/white
            // Note: Remember that index path row is 0 for the first row.  We want white/light gray/white/etc..
            if indexPath.row.isMultiple(of: 2) {
                cell.backgroundColor = .white
            } else {
                cell.backgroundColor = .lightGray
            }

        }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Supporting functions
    
    /// Process the cell and setup the cell labels
    /// - Parameter cell: A `UITableViewCell` as an `inout` variable containing the cell to process
    /// - Parameter user: The `User` object containing the information to display in the cell
    private func setupCell(_ cell: inout UITableViewCell, _ user: User) {
        
        // set the cell to process
        guard let processCell = cell as? MSTTableViewCell else {
            // if the cast can not be done, we can do nothing - should never occur
            return
        }

        defer {
            // reset the cell according to the updated cell
            cell = processCell
        }
        
        // Set the fields - if the field was not passed the value is nil
        // If the value is nil, the label will not appear and the size is adjusted accordingly
        processCell.nameLabel.text = user.name
        processCell.emailLabel.text = user.email
        processCell.phoneLabel.text = user.phone

    }
    

    
}
