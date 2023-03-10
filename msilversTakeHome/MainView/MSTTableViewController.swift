//
//  MSTTableViewController.swift
//  msilversTakeHome
//
//  Created by Mike Silvers on 2/24/23.
//

import UIKit
import Combine

class MSTTableViewController: UITableViewController {
    
    /// the cancellable for memory management when using combine
    private var cancellable: Set<AnyCancellable> = []
    /// The view model to access users and provide them ot the table view
    var viewModel: MSTMainViewModel = MSTMainViewModel()

    /// The activity indicatoe used when the network call is occurring
    private var activityIndicator = UIActivityIndicatorView()
    
    /// The data source of users
    private var users = [User]()

    // MARK: View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // the auto height for cell and labels
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        // this is the connector to update the table when the new list of users are displayed
        viewModel.$userList
            .sink(receiveValue: { [weak self] (userList) in
                
                guard let strongSelf = self else { return }
        
                // make the activity indicator disappear
                strongSelf.activityIndicatorShow(false)
                
                // set the new user list
                strongSelf.users = userList ?? [User]()
                strongSelf.tableView.reloadData()
                
                // make sure the refresh control is no longer refreshing - if this was from a refresh
                strongSelf.refreshControl?.endRefreshing()
                
            })
            .store(in: &cancellable)
        
        // this is the connector for when an error occurs
        viewModel.$userError
            .sink(receiveValue: { [weak self] (error) in
                
                guard let strongSelf = self else { return }

                // make the activity indicator disappear
                strongSelf.activityIndicatorShow(false)

                if error == nil { return }
                
                // clear out the existing values on the table
                strongSelf.users.removeAll()
                strongSelf.tableView.reloadData()

                // make sure the refresh control is no longer refreshing - if this was from a refresh
                strongSelf.refreshControl?.endRefreshing()

                // the error message
                let message = """
There was an error while retrieving the user list.\n
Please refresh the list to try again.\n\n
\(error?.localizedDescription ?? "Unknown Error")
"""
                
                // display the error to the user
                let dialog = UIAlertController(title: "User List Error",
                                               message: message,
                                               preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                let retry = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
                    guard let strongSelf = self else { return }
                    strongSelf.viewModel.getUserList()
                }
                
                dialog.addAction(ok)
                dialog.addAction(retry)
                
                self?.present(dialog, animated: true)
                
            })
            .store(in: &cancellable)
        
        // process the user
        refreshUsers()
        
    }
    
    // MARK: - UITableView data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // We are only using a single section for this display
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        // only process the cell if the call is able to be cast into the `MSTTableViewCell` - should never fail
        if (cell as? MSTTableViewCell) != nil {
            
            setupCell(&cell, user)

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

    // MARK: - UITableViewCell support functions
    
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

    // MARK: - Supporting functions
    
    private func refreshUsers() {
        
        // turn on the activity indicator
        activityIndicatorShow()

        // for the purposes of this app, clear the data and refresh
        // if this were production - we would check with product to see how they want this handled
        // if you use the network analyzer and slow down the network link - this will be apparent
        // for a normal network speed, the values appear to flash
        users.removeAll()
        tableView.reloadData()

        // do the lookup for the users
        viewModel.getUserList()
    }
    
    @IBAction func refreshControlAction(_ sender: UIRefreshControl) {
        
        // just refresh the user list
        refreshUsers()
    }
    
    // MARK: Activity Indicator functions
    
    ///  Adds the Activity Indicator to the table view
    private func activityIndicatorAdd() {
        
        // set some of the defaults to the activity indicator
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true

        // center the activity indicator
        activityIndicator.center = CGPoint(x: tableView.bounds.midX, y: tableView.bounds.midY)
        
        // add the activity indicator
        tableView.addSubview(activityIndicator)
        
    }
    
    /// Controls the activity indicator.  Makes sure the indicator is added as a subview if it does not exits and animates/stops animation.
    /// - Parameter show: A `Bool` where `true` starts the animation of the activity indicator.  `false` stops the animation.
    private func activityIndicatorShow(_ show: Bool = true) {
        
        if show {
            
            // make sure the activity indicator was displayed
            if activityIndicator.superview == nil {
                activityIndicatorAdd()
            }
            
            // make sure we can see the activity indicator and start it spinning
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            
            // stop the animator from spinning.  Automatically hides when it is stopped.
            activityIndicator.stopAnimating()
        }
        
    }
    
}
