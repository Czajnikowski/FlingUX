FlingUX
=======

Flinging user experience for iOS UITableView.
[This short video shows current implementation in action](http://www.youtube.com/watch?v=FV4HN8kdoJk)

Intention
------

Basically almost all of the iOS applications uses UITableView component. Many of those offers the possibility to rearrange it's cells (prioritizing, organizing things). Many times I experienced the rearranging of cells uncomfortable. One thing that I really hate about the rearranging of the table view is that I need to move the rearranged cell to the edge of the screen, and drag it directly to the desired place - sometimes it takes even a few seconds until you achieve your goal, and leads to insecure grasp of your device. Sometimes your goal is just to drop your cell on top, move it slightly up or down, precision isn't the life or death.

My idea is to implement solution, which will enhance rearranging with "fling" gesture.

I’m starting with a very simple project, which is showing 30 cells. You can switch editing mode by long tap on any cell. Sample project include DCIntrospect pod for debug purposes.

Known issues:
------

Not very often, but application crashes. The problem is taking place between the start of the fling (<code>- tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:</code>) and landing in destination (<code>- tableView:moveRowAtIndexPath:toIndexPath:</code>).

Development path:
------

  1. Make it stable
  2. Optimize it
  3. Make it reusable
  4. Make it work in real projects
