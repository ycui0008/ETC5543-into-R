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
ggsave(filename = "test1.svg")

testthat::test_that("base histogram works", {
  p <- function() hist(mtcars$disp)
  expect_doppelganger("base histogram", p)
})


diamonds %>%
  ggplot(aes(x = cut, y = carat)) +
  # geom_boxplot() +
  geom_jitter(alpha = 0.5) +
  geom_boxplot()

diamonds %>%
  head(1000) %>%
  ggplot(aes(x = color, y = cut)) +
  # geom_boxplot() +
  geom_jitter(alpha = 0.5)

mtcars %>%
  ggplot(aes(x = disp, y = mpg)) +
  geom_point()

mtcars %>%
  ggplot(aes(x = cyl, y = hp, colour = factor(vs))) +
  geom_point()
