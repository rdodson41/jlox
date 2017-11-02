src := src
build := build

src_file_paths := $(shell find "$(src)" -type f -name *.java)
build_file_paths := $(patsubst $(src)/%.java,$(build)/%.class,$(src_file_paths))

default: $(build_file_paths)

$(build)/%.class: $(src)/%.java
	mkdir -p "$(build)"
	javac -classpath "$(src)" -d "$(build)" "$(<)"


