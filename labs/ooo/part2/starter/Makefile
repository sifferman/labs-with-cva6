#
# File: Makefile
# Description: Makefile for running the fifo testbench.
#

CORE_FILE = ucsbece154b_fifo.core
VENDOR	= ucsbece154b
LIBRARY	= ooo
CORE	= fifo
VERSION	= 1.0.0
PROJECT = ${VENDOR}:${LIBRARY}:${CORE}:${VERSION}

TESTS = $(shell find tests -type f)

# ======================================================= #

.PHONY: init build sim view lint clean

# ======================================================= #
# Targets

tb: fusesoc.conf
	fusesoc run --target $@ --tool ${TOOL} ${PROJECT}
tb_resized_small: fusesoc.conf
	fusesoc run --target $@ --tool ${TOOL} ${PROJECT}
tb_resized_big: fusesoc.conf
	fusesoc run --target $@ --tool ${TOOL} ${PROJECT}

init: fusesoc.conf

lint: fusesoc.conf
	fusesoc run --target $@ ${PROJECT}
lint_resized_small: fusesoc.conf
	fusesoc run --target $@ ${PROJECT}
lint_resized_big: fusesoc.conf
	fusesoc run --target $@ ${PROJECT}

clean:
	rm -rf build fusesoc.conf

# ======================================================= #
# Files

fusesoc.conf: ${CORE_FILE}
	@pip3 install --user -r requirements.txt > /dev/null
	rm -f fusesoc.conf
	fusesoc library add ${VENDOR}_${LIBRARY}_${CORE}_${VERSION} . --sync-type=local

# ======================================================= #
