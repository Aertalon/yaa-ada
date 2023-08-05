[![Build status](https://github.com/Aertalon/yaa-ada/actions/workflows/build.yml/badge.svg)](https://github.com/Aertalon/yaa-ada/actions/workflows/build.yml)
[![Test status](https://github.com/Aertalon/yaa-ada/actions/workflows/test.yml/badge.svg)](https://github.com/Aertalon/yaa-ada/actions/workflows/test.yml)

# yaa-ada

An Ada 2012 library for autodifferentiation based on dual numbers.


## Usage

To be written

```ada

with YAA;

procedure Example is

   -- Some dual stuff types
   -- Some function stuff types
begin
   -- Example body
end Example;
```


## Dependencies

In order to build the library, you need to have:

 * An Ada 2012 compiler

 * [Alire][url-alire]

Optional dependencies:

 * `lcov` to generate a coverage report for unit tests

 * `make`

## Using the library

To be written

## Tests

Unit tests are provided in the folder `tests`.
Tests are built and run via
```
$ make tests
```

Coverage report from unit test (using `lcov`) is generated via
```
$ make coverage
```

## Contributing

To be written.

## License

The Ada code and unit tests are licensed under the [Apache License 2.0][url-apache].
The first line of each Ada file should contain an SPDX license identifier tag that
refers to this license:

    SPDX-License-Identifier: Apache-2.0

## Acknowledgements

The structure of this repo is heavily influenced by Onox' [json-ada library][url-json-ada].

  [url-alire]: https://alire.ada.dev/
  [url-apache]: https://opensource.org/licenses/Apache-2.0
  [url-json-ada]: https://github.com/Aertalon/yaa-ada

