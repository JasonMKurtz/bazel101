def _append_file_impl(ctx):
    data = ctx.actions.declare_file(ctx.attr.file)
    ctx.actions.write(
        output = data,
        content = ctx.attr.text,
    )

    return DefaultInfo(
        files = depset([data]),
    )

def _count_file_impl(ctx):
    data = ctx.file.file_target
    out = ctx.actions.declare_file("size")
    
    ctx.actions.run_shell(
        command = "wc -l {} > {}".format(data.path, out.path),
        inputs = [data],
        outputs = [out],
    )

    return DefaultInfo(
        files = depset([out])
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
        'file_target': attr.label(
            allow_single_file = [".txt"],
        ),
    },
)
