#!/bin/bash

cd "$( dirname "$0" )"

case "$1" in
"--clean")
	rm -vf ../gen/com/google/fpl/liquidfun/*.java
	rm -vf ../gen/cpp/liquidfun_wrap.*
	;;
"--help")
	echo "Generate Java/JNI wrappers using SWIG. Use the --clean \
		switch to remove the generated files."
	;;
*)
	swig -java -c++ \
		-v \
		-package com.google.fpl.liquidfun \
		-outdir ../gen/com/google/fpl/liquidfun/ \
		-o ../gen/cpp/liquidfun_wrap.cpp \
		liquidfun.swig
	;;
esac

