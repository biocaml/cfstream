.PHONY: all test
all:
	jbuilder build @install

test:
	jbuilder runtest

.PHONY: clean
clean:
	rm -rf _build
	rm -f cfstream.install lib/.merlin app/.merlin
