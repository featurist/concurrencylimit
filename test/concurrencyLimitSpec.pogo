expect = require 'chai'.expect
_ = require 'underscore'
limitTo = require '..'

describe 'concurrcyLimit'
  it 'limits to 3 outstanding tasks'
    limit = limitTo 3

    outstanding = 0
    outstandingLog = []

    results = [
      n <- [1..10]
      limit!
        ++outstanding
        outstandingLog.push(outstanding)
        setTimeout ^ 10!
        --outstanding
    ]

    expect(_.max(outstandingLog)).to.eql 3

  it 'returns results in order they were started'
    limit = limitTo 3

    outstanding = 0

    results = [
      n <- [1..10]
      limit!
        setTimeout ^ 10!
        n
    ]

    expect(results).to.eql [1..10]

  it 'throws exceptions in order they were started'
    limit = limitTo 3

    outstanding = 0

    results = [
      n <- [1..10]
      try
        limit!
          setTimeout ^ 10!
          throw (n)
      catch (e)
        e
    ]

    expect(results).to.eql [1..10]
