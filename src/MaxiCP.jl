module MaxiCP

using JavaCall

const depsfile = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
if isfile(depsfile)
    include(depsfile)
else
    error(
        "MaxiCP not properly installed. Please run " *
        "`Pkg.build(\"MaxiCP\")` or `]build MaxiCP`",
    )
end

function __init__()
    if get(ENV, "JULIA_REGISTRYCI_AUTOMERGE", "") != "true"
        maxicp_java_init()
    end
end

"""
    maxicp_java_init(init_java::Bool=true)

Initialise the JVM with MaxiCP on the classpath.

If other parts of the application also require JavaCall, set `init_java=false`
and call this **before** `JavaCall.init()` so that the classpath is set up.
"""
function maxicp_java_init(init_java::Bool=true)
    JavaCall.addClassPath(maxicp_jar)
    if init_java
        JavaCall.init()
    end
    return
end

end # module MaxiCP
