[![Build Status](https://travis-ci.org/adam-phillips/letter_lines_live.svg?branch=master)](https://travis-ci.org/adam-phillips/letter_lines_elixir)

# LetterLinesLive

LetterLinesLive is the next iteration of the Mix project [LetterLinesElixir](https://github.com/adam-phillips/letter_lines_elixir). The `LetterLinesElixir` was built to handle the logic behind a word game similar to Wordscapes (© Copyright 2017 Peoplefun, Inc.), and includes some rudimentary ASCII interactions.

`LetterLinesElixir` is now a dependency that drives the logic behind an interactive Phoenix LiveView application, which presents the game for play in browser.

## Stability

Please keep in mind that while free to fork or simply clone and play with, both `LetterLinesElixir` and this app `LetterLinesLive` are under development and have not reached a state that's ready for a v1 release. As such, there will be moving targets and potentially breaking changes.

But please - have fun! This is an evolving labor of love based on the enjoyment I've derived from the original game these past few years.

## Setup

There are a few prerequisites which must be installed and working to achieve a successful setup.

### Proper Language Versions
`LetterLinesLive` was developed with the use of the fantastic [asdf version manager](https://asdf-vm.com/#/core-manage-asdf-vm), which I strongly recommend for managing many, if not all your languages. The source of truth for determining the correct language versions will always be `.tool-versions`, which is used by `asdf` to ensure version accuracy. Current version requirements are:
* Erlang 22.3.1
* Elixir 1.10.2
* Node 14.7.0

If these versions need to be updated or another language added, please either make the update using `asdf` following the documentation, or if you make the change locally another way be sure to also manually update this file.

You will also need a running instance of PostgreSQL. Please reference the [GitHub page](https://github.com/PostgresApp/PostgresApp) to find links to the Postgres.app download page, documentation, and plenty of helpful pointers. Once the necessary languages are installed and you've got a running instance of Postgres, it's time to initialize the app and fire it up!

Finally, and most importantly, ensure you have a working version of Phoenix installed. Currently this project uses Phoenix v1.5.4 and a number of libraries that help power LiveView. You can review the libraries and their version in the private function `deps/0` in `mix.exs`.

## Initialization and Running

Run the following commands from a command line in your terminal, ensuring your current working directory is `letter_lines_live/`.

  * ```bash
    $ mix deps.get
    ```
    * This pulls in the dependencies for app as specified in `mix.exs`.
    * **Please Note:** The dependency [LetterLinesElixir](https://github.com/adam-phillips/letter_lines_elixir) is not completely stable and currently referenced by a commit ref for the last changes merged to `master`. Updating versions and updating deps should be expected as work continues on that library and it stabilizes with a v1 release.
  * ```bash
    $ mix ecto.setup
    ```
    * This tells Ecto to create your database, run any migrations, and populate it with DB seed data if such data is present. Otherwise you still have a created database ensured not to be behind on migrations.
  * ```bash
    $ cd assets && npm install && cd ..
    ```
    * This drops you down into the `assets` directory, runs `npm install` to install any Node.js dependencies, then navigates back up to the root level of the project.
  * ```bash
    $ mix phx.server
    ```
    * This will start your Phoenix server locally in `development` mode, but otherwise quite similar to a production server.
  * Alternatively you can run the server inside IEx, giving you access to application code without the use of debuggers or interrupting the server:
  * ```bash
    $ iex -S mix phx.server
    ```
However you choose to start your Phoenix server, it will utilize port 4000 by default. Once running, you can visit `localhost:4000` in a browser and see the app live!

## Testing
Testing is key for the long term stability and maintainability of of any application. `LetterLinesLive` uses the [ExUnit](https://hexdocs.pm/ex_unit/ExUnit.html) testing framework for most tasks, but other libraries are leveraged for more nuanced cases. For example [Mox](https://hexdocs.pm/mox/Mox.html) is ideal for mocking external service calls. A few other potential gotchas and things to keep in mind are listed below.

* `mix test.watch`: This command starts MixTestWatch, which constantly monitors test files. When a file is saved, it will automatically rerun all tests.
  * If you're looking for more granularity than running the entire test suite, simply provide a path to the file you want watched, and a line number can also be supplied so only that particular test runs.
  * ```bash
    $ mix test.watch test/letter_lines_live_web/live/page_live_test.exs:7
    ```
    * This will constantly monitor the test in the given file at the given line, and run the test any time the file is saved. Granularity is easily controlled. For example omitting the line number only would result in all tests just on that page to run automatically when anything in the file is saved.

  * To terminate `mix test.watch` simply press Control+C twice and you will return to the command prompt.

## Collision Avoidance

In development, both the Phoenix server and ExUnit test want to run on port 4000. Clearly this is problematic if one or the other is already running and you start the alternate process. Give that `mix test.watch` is quite helpful and helps speed up test development, and the Phoenix server constantly running in IEx is equally helpful, you may notice a change in `/config/test.exs`.

The Phoenix server for `LetterLinesLive` still runs on port 4000 as is the default. However, the port assignment for test running has been changed to 4002. In this way, both services can run non-stop without interfering with one another. This is not in keeping with convention, so bears pointing out to hopefully prevent confusion.
