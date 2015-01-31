
import UIKit

class ArrayTableViewController: UITableViewController {
    
    /*
        TODO five: create an array of to do tasks inside this class
        TODO six: populate the table view with the contents of the newly created array.
        Bonus: Add delete cell on swipe feature.
    */
    
    var todoTasks: Array<String> = ["Feed the dog", "Wash the car", "Paint the house", "Do something awesome?"]
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoTasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier") as? UITableViewCell ?? UITableViewCell(style: .Default, reuseIdentifier: "CellIdentifier")
        
        // Add code to populate cells
        cell.textLabel?.text = self.todoTasks[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Remove from array
            self.todoTasks.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
