#!/bin/bash

gzip_compress () {
	# $1 -> target, $2 -> source
	tar -czvf "$1" "$2"	
}

gzip_decompress () {
	# $1 -> target
	tar -xvf "$1"
}

