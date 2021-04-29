load(":files.bzl", "append_file", "count_file")

append_file(
    name = "append",
    file = "hello2.txt",
    text = "11",
)

count_file(
    name = "count",
    file_target = ":append",
)
