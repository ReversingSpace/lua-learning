--[[---------------------------------------------------------------------------
Copyright (c) 2017 A.W. Stanley

See the COPYRIGHT file at the top-level directory of this distribution and in
the repository: https://github.com/ReversingSpace/lua-learning

Licensed under the Apache License, Version 2.0 <LICENSE-APACHE or
http://www.apache.org/licenses/LICENSE-2.0> or the MIT license
<LICENSE-MIT or http://opensource.org/licenses/MIT>, at your
option. This file may not be copied, modified, or distributed
except according to those terms.
-------------------------------------------------------------------------------
This file looks at the usage of the basic Lua types, as well as the
underpinned definitions.

`lua.h` houses the following definitions (as of Lua 5.3); tabs have been 
replaced with spaces to ensure consistent formatting:

    #define LUA_TNIL              0
    #define LUA_TBOOLEAN          1
    #define LUA_TLIGHTUSERDATA    2
    #define LUA_TNUMBER           3
    #define LUA_TSTRING           4
    #define LUA_TTABLE            5
    #define LUA_TFUNCTION         6
    #define LUA_TUSERDATA         7
    #define LUA_TTHREAD           8

---------------------------------------------------------------------------]]--

--[[ Simple test setup code to remove any obscuring caused by it inline.]]

local test_count = 0
local test_set = ""

local function notify_test(alias)
    print(([[%s tests (set %d): %s ]]):format(test_set, test_count, alias))
    test_count = test_count + 1
end

local path = {...}

print(([[
    
Initialising type tests.  See the comment blocks in %s.
]]):format(path[1] or "this file"))

--[[---------------------------------------------------------------------------
Type 0: Nil

The nil value is a special value used to indicate nothing is there.  It can be
interpreted as roughly equal to the C type NULL (though the concept is 
semi-portable and can be seen in other languages).  It is generally safer than
the C NULL or C++ nullptr, in that it can be used and tested against reliably,
and there should be no debugger related issues.

There are a few things that are fun with nil.
---------------------------------------------------------------------------]]--

--[[ Reconfigure test print information. ]]
print("\n\n")
test_count = 0
test_set = "nil"

notify_test("Booleans")

--[[ false ]]
print("\nnil == false:")
print(nil == false)

--[[ false ]]
print("\nnot nil == false:")
print(not nil == false)

--[[ true ]]
print("\nnot not nil == false:")
print(not not nil == false)

--[[ false ]]
print("\nnil == true:")
print(nil == true)

--[[ true ]]
print("\nnot nil == true:")
print(not nil == true)

--[[ false ]]
print("\nnot not nil == true:")
print(not not nil == true)

print("\n\n")

notify_test("nil and type tests")

--[[ true ]]
print("\nnil == nil:")
print(nil == nil)

--[[ false ]]
print("\nnot nil == nil:")
print(not nil == nil)

--[[ not not nil is not equal to nil, because not not nil is a boolean test now! ]]
print("\nnot not nil == nil:")
print(not not nil == nil)

--[[ type(nil) = nil ]]
print(([[

type(nil) = %s
]]):format(type(nil)))

--[[ type(not nil) = boolean ]]
print(([[
type(not nil) = %s
]]):format(type(not nil)))

--[[ type(not not nil) = boolean ]]
print(([[
type(not not nil) = %s
]]):format(type(not not nil)))


--[[---------------------------------------------------------------------------
Type 1: Boolean (LUA_TBOOLEAN)

True and False types.  Fairly easy to test, some has already been done.
---------------------------------------------------------------------------]]--

--[[ Reconfigure test print information. ]]
print("\n\n")
test_count = 0
test_set = "boolean"

notify_test("Booleans (self-compare)")
print(([[

type(true) = %s
]]):format(type(true)))


print(([[
type(false) = %s
]]):format(type(false)))

print(([[
type(1 == 1) = %s
]]):format(type(1 == 1)))

--[[ true ]]
print("\ntrue == true:")
print(true == true)

--[[ false ]]
print("\ntrue == not true:")
print(true == not  true)

--[[ true ]]
print("\nnot true == not true:")
print(not true == not true)

--[[ false ]]
print("\nnot true == not not true:")
print(not true == not not true)

--[[ true ]]
print("\ntrue == not not true:")
print(true == not not true)

--[[---------------------------------------------------------------------------
Type 2: Light user data

Skipped as it requires C API to really make use of it.  We'll have to cover
this elsewhere.

This is actually a C-API thing.
---------------------------------------------------------------------------]]--

--[[---------------------------------------------------------------------------
Type 3: Numbers

Numbers are defined in `luaconf.h`.  All of the information specific to the
compiled virtual machine should be stored there, including the underlying type
(typically int or double).

In Lua 5.3, integers and floating point types have different storage, which
means that they are now stored in a different value type from Lua 5.2.
However, in what I can only assume is to do with compatibility, they are both
stored as LUA_TNUMBER (which is what they were prior).

Internally they are LUA_INTEGER and LUA_NUMBER.  The change from Lua 5.2 to
Lua 5.3 can be seen in the following one-liners taken from `luaconf.h`:

5.2: LUA_INTEGER is the integral type used by lua_pushinteger/lua_tointeger.
5.3: LUA_INTEGER is the integer type used by Lua.

The change shows an elevation of the integral value usage.

There isn't a huge amount to show here, save boolean comparisons and basic
tonumber vs. integer storage.
---------------------------------------------------------------------------]]--

--[[ Reconfigure test print information. ]]
print("\n\n")
test_count = 0
test_set = "number"

notify_test("Integers and Numbers")

print("1, tonumber(\"1\"), 1 == tonumber(\"1\")")
print(1, tonumber("1"), 1 == tonumber("1"))

print("\n1, tonumber(\"1\"), 1 + tonumber(\"1\")")
print(1, tonumber("1"), 1 + tonumber("1"))

print("\n1.0, tonumber(\"1\"), 1 + tonumber(\"1\")")
print(1.0, tonumber("1"), 1.0 + tonumber("1"))

print("\n\n")

notify_test("Booleans")

print("\n1 == true") --[[ false ]]
print(1 == true)

print("\n0 == true") --[[ false ]]
print(0 == true)

print("\n0 == false") --[[ false ]]
print(0 == false)

print("\n1 == 1.0") --[[ true, despite being different types-ish ]]
print(1 == 1.0)

--[[---------------------------------------------------------------------------
Type 4: String
---------------------------------------------------------------------------]]--
--[[ Reconfigure test print information. ]]
print("\n\n")
test_count = 0
test_set = "string"

notify_test("Numbers are strings, ish")
print("1 == \"1\"")
print(1 == "1")

print("\n1 == \"1.0\"")
print(1 == "1.0")

print("\n1.0 == \"1.0\"")
print(1.0 == "1.0")

print("\n1 == tonumber(\"1.0\")") --[[ true ]]
print(1 == tonumber("1.0"))

print("\ntype(1.0)")
print(type(1.0))

print("\ntype(1)")
print(type(1))

print("\ntype('1')")
print(type('1'))

print("\ntype(\"1\")")
print(type("1"))

print("\n\nAnd yet ...\n")
print("5 + \"1.0\"")
print(5 + "1.0")

--[[---------------------------------------------------------------------------
Type 5: Table

This is the plain-old-data (POD) type, as well as the OOP backbone.  It's
a total powerhouse, and it deserves its own file.
---------------------------------------------------------------------------]]--

--[[ Reconfigure test print information. ]]
print("\n\n")
test_count = 0
test_set = "table"


--[[---------------------------------------------------------------------------
Type 6: Functions

Functions also deserve their own file, so we won't touch them here.
---------------------------------------------------------------------------]]--

--[[---------------------------------------------------------------------------
Type 7: User Data (full userdata)

The full user data type belongs in the C realm of Lua.  We'll have to do
this as its own C-based example.
---------------------------------------------------------------------------]]--

--[[---------------------------------------------------------------------------
Type 8: Threads

Skipping threads for now, it's a bit too complex and not really within the
scope of "basic".
---------------------------------------------------------------------------]]--