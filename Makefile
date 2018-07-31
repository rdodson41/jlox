src := src
src_paths := $(shell find "$(src)" -type f -name *.java)

build := build
build_paths := $(patsubst $(src)/%.java,$(build)/%.class,$(src_paths))

.PHONY: default
default: $(build_paths)

$(build)/%.class: $(src)/%.java
	mkdir -p "$(build)"
	javac -classpath "$(src)" -d "$(build)" "$(<)"

.PHONY: clean
clean:
	rm -R "$(build)"
