#!/bin/bash
if [ ! -d ../csrc ]; then
	mkdir ../csrc
fi
cocos luacompile -s ../src -d ../csrc -e --disable-compile -k test110 -b liqiang
