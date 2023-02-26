# msilversTakeHome
iOS Take Home test for Mike Silvers

// TODO: Add/update these items
// 1. Add refresh control
// 2. Add and check errors when users are deformed
// 3. Add commenting
// 4. Clean up code
// 5. Add more tests
// 6. Add the README - explain what was done and why


Explain about the errors in constraints in the table cell - due to the auto-expanding labels.

Add a note that the VM will always be on the main thread in this case since there is only one main view.  If there were other views (ie: a detail view), then the sink for the users and the error would need to be wrapped in a DispatchQueue.main.async to assure the actions are not on a background thread
