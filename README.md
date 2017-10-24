# Lua Learning Resources (`lua-learning`)

This repository contains Lua scripts, and Lua related code, designed to help educate in the use(s) of Lua.

This is by no means comprehensive.  To start with I'm pushing a basic type check/identity system, but intend to extend this over time with more examples and useful test cases.

## Style

This repository adopts the same style guide as is maintained in [lua-core](https://github.com/ReversingSpace/lua-core).

[Style information](https://github.com/ReversingSpace/lua-core/wiki/Style) shall be stored in [the related wiki](https://github.com/ReversingSpace/lua-core/wiki/).

Comments should generally be of the form `--[[comment]]` rather than end of line comments `--comment`, as the former allows copying and pasting into interpreters without fear of missing line breaks.  It increases the total size of the file more than somewhat, but it is a cost worth accepting considering the benefits.

## Licence

Apache 2.0 or MIT (your choice); see `COPYRIGHT` for full statement.

This means you are free to use the code in your commercial projects if you so choose.  Contributions are assumed to be made under the above licence; pull requests which deviate from this will typically be rejected (unless they are public domain).

Individual files may contain headers indicating their origin.  See `HEADER` for the default header used here (or more information).