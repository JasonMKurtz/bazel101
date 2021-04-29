def _append_file_impl(ctx):
    out = ctx.actions.declare_file(ctx.attr.file)
    ctx.actions.write(
        output = out,
        content = ctx.attr.text + " " + ctx.attr.file,
    )

    return [DefaultInfo(files = depset([out]))]

def _count_file_impl(ctx):
    filename = ctx.file.file_target # ctx.file.<attr> gives us a File type, which has a .path member
    out = ctx.actions.declare_file("size")
    ctx.actions.run_shell(
        command = "wc -l {} > {}".format(filename.path, out.path),
        inputs = [filename],
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
        'file_target': attr.label(
            allow_single_file=[".txt"],
        ),
    },
)
