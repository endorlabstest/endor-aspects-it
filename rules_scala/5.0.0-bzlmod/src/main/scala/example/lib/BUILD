load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")

scala_library(
    name = "parser_lib",
    srcs = ["Parser.scala"],
    visibility = ["//visibility:public"],
    deps = [
        "@maven//:com_lihaoyi_pprint_2_13",
        "@maven//:org_scalameta_scalameta_2_13",
    ],
)
