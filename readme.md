# Concurrency Limit

Limit the concurrency of certain operations. Uses promises.

## Usage

    var concurrencyLimit = require('concurrencylimit');

    // returns a function that limits to <= 3 concurrent tasks
    var limit = concurrencyLimit(3);

    var resultPromises = [1, 2, 3, 4, 5].map(function (n) {

      // limit will make there are at most only 3
      // outstanding tasks at any given moment
      return limit(function() {

        return new Promise(function (result, error) {
          console.log('task started');
          setTimeout(function () {
            console.log('task finished');
            result(n + 1);
          }, 1000);
        });
      });
    });

    Promise.all(resultPromises).then(function (results) {
      console.log(results);
    });

## API

    var concurrencyLimit = require('concurrencylimit');

    var limit = concurrencyLimit(n);

`n`, the maximum number of oustanding tasks allowed by `limit`

    limit(function);

Given `function` returns a promise, makes sure that at most only `n`
functions have been called, but have not returned yet. As soon as one
of the function calls have returned the next is executed.
