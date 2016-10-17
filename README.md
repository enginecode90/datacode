## This is a data science repository, 

#I provided in this repo all necessary codes written in R programming language. These codes play critical role for understanding the building blocks of data science and data analysing. 

Functions are a fundamental building block of R: to master many of the more advanced techniques, you need a solid foundation in how functions work. You’ve probably already created many R functions, and you’re familiar with the basics of how they work. 

The most important thing to understand about R is that functions are objects in their own right. You can work with them exactly the same way you work with any other type of object. 

## Lexical scoping

Scoping is the set of rules that govern how R looks up the value of a symbol. In the example below, scoping is the set of rules that R applies to go from the symbol x to its value 10:

#x <- 10
#x
#> [1] 10

Understanding scoping allows you to:

   * build tools by composing functions, as described in functional programming.

   *overrule the usual evaluation rules and do non-standard evaluation, as described in non-standard evaluation.

   R has two types of scoping: lexical scoping, implemented automatically at the language level, and dynamic scoping, used in select functions to save typing during interactive analysis. We discuss lexical scoping here because it is intimately tied to function creation. Dynamic scoping is described in more detail in scoping issues.

Lexical scoping looks up symbol values based on how functions were nested when they were created, not how they are nested when they are called. With lexical scoping, you don’t need to know how the function is called to figure out where the value of a variable will be looked up. You just need to look at the function’s definition.

The “lexical” in lexical scoping doesn’t correspond to the usual English definition (“of or relating to words or the vocabulary of a language as distinguished from its grammar and construction”) but comes from the computer science term “lexing”, which is part of the process that converts code represented as text to meaningful pieces that the programming language understands.

There are four basic principles behind R’s implementation of lexical scoping:


  *  name masking
  *  functions vs. variables
  *  a fresh start
  *  dynamic lookup

You probably know many of these principles already, although you might not have thought about them explicitly. Test your knowledge by mentally running through the code in each block before looking at the answers.
Name masking

The following example illustrates the most basic principle of lexical scoping, and you should have no problem predicting the output.

# f <- function() {
#  x <- 1
# y <- 2
#  c(x, y)
#}
#f()
#rm(f)

If a name isn’t defined inside a function, R will look one level up.

#x <- 2
#g <- function() {
#  y <- 1
#  c(x, y)
#}
#g()
#rm(x, g)

The same rules apply if a function is defined inside another function: look inside the current function, then where that function was defined, and so on, all the way up to the global environment, and then on to other loaded packages. Run the following code in your head, then confirm the output by running the R code.

#x <- 1
#h <- function() {
#  y <- 2
#  i <- function() {
#    z <- 3
#    c(x, y, z)
#  }
#  i()
#}
#h()
#rm(x, h)

The same rules apply to closures, functions created by other functions. Closures will be described in more detail in functional programming; here we’ll just look at how they interact with scoping. The following function, j(), returns a function. What do you think this function will return when we call it? 

#j <- function(x) {
#  y <- 2
#  function() {
#    c(x, y)
#  }
#}
#k <- j(1)
#k()
#rm(j, k)

This seems a little magical (how does R know what the value of y is after the function has been called). It works because k preserves the environment in which it was defined and because the environment includes the value of y. Environments gives some pointers on how you can dive in and figure out what values are stored in the environment associated with each function.