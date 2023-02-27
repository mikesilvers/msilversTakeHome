# Takehome Coding Test For Michael Silvers
This repository contains the take home coding exam for Michael Silvers.  The exam code must contain comments to allow other developers to easily follow the code.  The requirements for this exam are as follows:
* The app is placed in a public repo
* The app must use native iOS and be written in Swift
* The app must be pulled down from the repo and run with no additional configuration
* Tests are required
* The README should explain the app, what and why the app was coded as it was coded

The instructions are as follows:
1. Create a new iOS project using the Single View App template
2. Add a UITableView to the main View and use it to display the list of contacts
3. Use the endpoint [https://jsonplaceholder.typicode.com/users](https://jsonplaceholder.typicode.com/users) for the list of users
4. Each table cell should display the name, email, and phone number of a contact
5. Add a refresh control to the table view to allow for refreshing the list of contacts by pulling down on the table
6. Use the 3rd party library or libraries (CocoaPods) to make the request and parse the JSON response
7. Add error handling for cases where the API request fails

## Overview of requirements

1. Creation of a new project using the Single View App template.  Completed - no additional notes.
2. Adding a UITableView to the existing view.  Completed - modified though - changed the UIView to a UTTableView and changed the controller to a UTTableViewController.  This change makes it more efficient as the required functions are automatically added.  A UITableViewController is an extension of the UIViewController so the base functions are also accessible. If I were to be completing this task in any manner my selection would be to use a List for the table rows and an individual view for the table view cell.  This is the simple solution as there is no navigation required for this project.
3. Using the endpoint to retrieve users - done.
4. Display of the name, email, and phone number in the table cells.  The labels in the table view cells are dynamic.  If the name or email or phone number are not returned, the label automatically adjusts the size.  If the data for any of the labels spans more than one line the label will break at the end of a word and the next word is continued on the next line.  
5. Adding a refresh control.  The refresh control is automatically in the table view - I had ti enable it and add the appropriate function - done.
6. Use third party libraries for networking and JSON decoding.  I used the AlamoFire - this has both functions available.
7. Error handling for network problems.  Added a modal display when there is a network issue or if the JSON is malformed.  The modal allows the user to dismiss it or retry the request.

## Additional notes
In this section a few concepts and issues are addressed.

### Warnings on the storyboard
* The warnings from AlamoFire will not be addressed or discussed as they are out of our control and do not provide any problems.
* The warnings for constraints on the table view cells are displayed but not an issue.  They are due to the auto-sizing nature of the labels in the cell and do not impact the display at all.

### Using Combine rather than delegates
There was a choice on how to process data that was returned from the API call.  The API call is completed in the view model.  Combine was used in place of delegates.  Combine is the reactive programming methodology.  When the API call results are returned, two Published variables are used.  One contains the user list and the other contains errors.

The network calls are completed using the Service class.  This is done to encapsulate API calls.  the view model uses the Service class to perform the API call.

### DispatchQueue.main.async within the view model variables
In the `MSTTableViewController`, the endpoint for the view model published variables are processed.  Because this is a single view project, this view controller will always be on the main thread.  Within the processing of the published values, the processing will always be in the main thread.  If there is another view added, then the processing of actions that require to be on the main thread needs to be surrounded by `DispatchQueue.main.async { }`.  Functions that show the activity indicator, refresh the table view and display the alert view for errors must be completed on the main thread.  If there was a different view available, timing could have these functions being called from a background thread.  But, since this will not occur, surrounding the code with `DispatchQueue.main.async { }` is not needed.

### Testing external calls
Testing the external calls was not limited to mocking the AlamoFire requests as manual tests will provide a better "real world" test.  mocking the calls is also a good thing to perform, but is not as effective as real world manual testing.

To perform tests for malformed JSON, no JSON returned, and an empty JSON return as well as network speeds was done manually with ProxyMan proxy.  Simulation of the slow network speeds shows the display of the activity indicator when the network calls are completed.  Normal network speeds are so quick that the activity indicator is added and removed too fast for the user to notice.  In addition, testing for no network was completed by turning off the network itself.

The malformed JSON is included in the project in the SampleJSON folder:
* `SampleJSON->modified-json-1.json` : JSON response is malformed.  Error is displayed.
* `SampleJSON->modified-json-2.json` : JSON response is empty.  Error is displayed.
* `SampleJOSN->modified-json-3.json` : JSON returns an empty array.  No entries are displayed on the user table

### Unit tests
`UserCodableTests` - this tests the decoding of JSON with multiple condition.  Some of the fields are missing and these tests make sure the decoding processes correctly.

`ServiceTests` - this tests the functions of the `MSTMainViewModel`, the `Service`, and the `MSTTableViewController` as far as the API call and communications between them.

### UI Tests
There are no UI Tests at this point.  The unit tests have covered the entire communications between the table view controller and the API call itself.  The options that would be available for UI Tests are to determine if the data is displayed and if the error message is displayed correctly.  The reason there are no UI tests right now is because the UI is manually tested, as described above, and additional tests could be added in the future.
