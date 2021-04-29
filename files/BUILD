load(":files.bzl", "append_file", "count_file")

append_file(
    name = "append",
    file = "hello.txt",
    text = "1",
)

count_file(
    name = "count",
    file_target = ":append",
)
