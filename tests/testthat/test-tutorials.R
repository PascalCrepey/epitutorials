tut_paths <- tutorial.helpers::return_tutorial_paths("epitutorials")

test_that("All tutorials can be knit without error", {
  expect_null(
    tutorial.helpers::knit_tutorials(tut_paths)
  )
})


test_that("All tutorials have the expected components", {
  expect_null(
    tutorial.helpers::check_tutorial_defaults(tut_paths)
  )
})