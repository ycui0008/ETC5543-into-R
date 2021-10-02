mtcars %>%
  ggplot(aes(x = cyl, y = hp)) +
  geom_jitter()

b <- mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()

c <- mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()

grade_this({
  pass_if_equal(y = mtcars[, "mpg"],
                x = mtcars)
})

grade_this_code()(
  mock_this_exercise(
    .user_code     = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()", # user submitted code
    .solution_code = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()"  # from -solution chunk
  )
)


print(pass_if_equal(y = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()", # user submitted code
              x = "mtcars %>% ggplot(aes(x =  cyl , y =  disp )) + geom_point()"  # from -solution chunk
              ))


disp_hist_base <- function() hist(mtcars$disp)
disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()

vdiffr::expect_doppelganger("test1.png", b)
vdiffr::expect_doppelganger("test1.png", b)

b
ggsave(filename = "test1.png")

testthat::test_that("base histogram works", {
  p <- function() hist(mtcars$disp)
  expect_doppelganger("base histogram", p)
})
