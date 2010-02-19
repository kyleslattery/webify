Webify
======

The aim of webify is to make it easy to convert a directory of Markdown files into a browsable website.

Options
-------

* `--source` - The source directory to pull files from (defaults to current directory)
* `--glob` - Can be used instead of `--source` and `--extension` to specify files to parse. Standard Ruby Glob format.
* `--target` - Where to put the outputted files (defaults to `./webify/`)
* `--extension` - Extension of files to webify (defaults to `md`)

Examples
--------

* `webify --source ./ --target ../output` - Takes files from `./` and puts outputted HTML files into `../output/`
