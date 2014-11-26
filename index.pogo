module.exports (n) =
  i = 0
  queue = []

  runTask(task) =
    ++i
    try
      task()!
    finally
      --i

      @{
        nextTask = queue.shift()
        if (nextTask)
          runTask(nextTask)!
      }()

  limit (block) =
    if (i < n)
      runTask(block)!
    else
      promise @(result, error)
        queue.push @{
          try
            result(block()!)
          catch(ex)
            error(ex)
        }
