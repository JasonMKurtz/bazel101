load(":files.bzl", "append_file", "count_file")

append_file(
    name = "append",
    file = "test.txt",
    text = "9\n",
)

count_file(
    name = "count",
    file_target = ":append",
)
