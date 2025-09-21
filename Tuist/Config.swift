import ProjectDescription

let config = Config(
    project: .tuist(
        generationOptions: .options(
            additionalPackageResolutionArguments: ["-scmProvider", "system"]
        )
    )
)
