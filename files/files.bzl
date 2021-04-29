FileWriteProvider = provider(
    "A rule provider to pass the hash information along",
    fields = {
        "hash": "The hash in question.",
        "filename": "The filename we wrote to.",
        "content": "The content we wrote.",
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

    hashout = ctx.actions.declare_file("hash.txt")
    ctx.actions.write(
        output = hashout,
        content = "{}".format(hash(ctx.attr.text)),
    )

    return FileWriteProvider(
        hash = hash(ctx.attr.text),
        filename = ctx.attr.file,
        content = ctx.attr.text,
    )

def _count_file_impl(ctx):
    data = ctx.attr.file_target[FileWriteProvider] # the data from the above struct

    out = ctx.actions.declare_file("size")
    
    ctx.actions.run_shell(
        command = "wc -l {} > {}".format(data.filename, out.path),
        inputs = [data.filename, data.content],
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
