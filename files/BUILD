load(":files.bzl", "append_file", "count_file")

append_file(
    name = "append",
    file = "test_2.txt",
    text = "2",
)

count_file(
    name = "count",
    file_target = ":append",
)
