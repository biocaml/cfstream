.PHONY: all
all:
	jbuilder build @install

.PHONY: clean
clean:
	rm -rf _build
	rm -f cfstream.install lib/.merlin app/.merlin
