FileWriteProvider = provider(
    "A rule provider to pass the hash information along",
    fields = {
        "hashout": "The file object of the file with our hash.",
        "filename": "The filename we wrote to.",
        "content": "The content we wrote.",
        "fh": "The file object of the file we wrote to.",
    },
)

def _append_file_impl(ctx):
    """
    out = ctx.actions.declare_file(ctx.attr.file)
    ctx.actions.write(
        output = out,
        content = ctx.attr.text,
    )
    """

    hashout = ctx.actions.declare_file("{}".format(hash(ctx.attr.text)))
    ctx.actions.write(
        output = hashout,
        content = ctx.attr.text,
    )

    data = ctx.actions.declare_file(ctx.attr.file)
    ctx.actions.write(
        output = data,
        content = ctx.attr.text,
    )

    info = DefaultInfo(
        files = depset([data, hashout]),
    )

    metadata = FileWriteProvider(
        hashout = hashout,
        filename = ctx.attr.file,
        content = ctx.attr.text,
        fh = data,
    )

    return [info, metadata]

def _count_file_impl(ctx):
    data = ctx.attr.file_target[FileWriteProvider] # the data from the above struct

    out = ctx.actions.declare_file("size")
    
    print(data)
    print(data.hashout.path)
    ctx.actions.run_shell(
        command = "wc -l {} > {}".format(data.fh.path, out.path),
        inputs = [data.hashout],
        outputs = [out],
    )

    return struct(
        size = out,
    )


append_file = rule(
    implementation = _append_file_impl,
    attrs = {
        'file': attr.string(),
        'text': attr.string(
            default = "foobar",
        ),
    },
)

count_file = rule(
    implementation = _count_file_impl,
    attrs = {
        'file_target': attr.label(),
    },
)
