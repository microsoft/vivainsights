test_that("workflow discovery catalogue is valid and complete", {
  skip_if_not_installed("yaml")

  catalogue_path <- system.file(
    "discovery",
    "workflows.yml",
    package = "vivainsights"
  )
  catalogue <- yaml::read_yaml(catalogue_path)
  workflows <- catalogue$workflows

  expect_identical(catalogue$schema_version, 1L)
  expect_gte(length(workflows), 10L)

  required_fields <- c(
    "id",
    "task",
    "intents",
    "r_function",
    "input_grain",
    "required_columns",
    "privacy",
    "returns",
    "example",
    "documentation",
    "related",
    "python_function",
    "parity"
  )
  expect_true(all(vapply(
    workflows,
    function(workflow) all(required_fields %in% names(workflow)),
    logical(1)
  )))

  ids <- vapply(workflows, `[[`, character(1), "id")
  functions <- vapply(workflows, `[[`, character(1), "r_function")
  parity <- vapply(workflows, `[[`, character(1), "parity")
  exports <- getNamespaceExports("vivainsights")

  expect_length(unique(ids), length(ids))
  expect_true(all(grepl("^[a-z0-9]+(?:-[a-z0-9]+)*$", ids)))
  expect_true(all(functions %in% exports))
  expect_true(all(vapply(
    workflows,
    function(workflow) all(workflow$related %in% exports),
    logical(1)
  )))
  expect_true(all(vapply(
    workflows,
    function(workflow) length(workflow$intents) >= 2,
    logical(1)
  )))
  expect_true(all(vapply(
    workflows,
    function(workflow) {
      tryCatch({
        parse(text = workflow$example)
        TRUE
      }, error = function(error) FALSE)
    },
    logical(1)
  )))
  expect_true(all(parity %in% catalogue$parity_vocabulary))
  expect_true(all(vapply(
    workflows,
    function(workflow) {
      identical(
        workflow$documentation,
        paste0(
          "https://microsoft.github.io/vivainsights/reference/",
          workflow$r_function,
          ".html"
        )
      )
    },
    logical(1)
  )))
  expect_match(catalogue$python$version, "^\\d+\\.\\d+\\.\\d+$")
  expect_match(catalogue$python$commit, "^[0-9a-f]{40}$")
})

test_that("agent guide covers every catalogued primary function", {
  skip_if_not_installed("yaml")

  catalogue <- yaml::read_yaml(system.file(
    "discovery",
    "workflows.yml",
    package = "vivainsights"
  ))
  llms_path <- system.file("discovery", "llms.txt", package = "vivainsights")
  llms <- paste(readLines(llms_path, warn = FALSE), collapse = "\n")

  functions <- vapply(
    catalogue$workflows,
    `[[`,
    character(1),
    "r_function"
  )

  expect_true(all(vapply(
    functions,
    function(fn) grepl(paste0("`", fn, "\\(\\)`"), llms),
    logical(1)
  )))
  expect_match(llms, "mingroup")
  expect_match(llms, catalogue$python$commit, fixed = TRUE)
})
