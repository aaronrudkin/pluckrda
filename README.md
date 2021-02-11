# pluckrda

R has two built-in formats for object serialization: `.rda` (also referred to as `.RData`) files, which can store multiple objects at a time, and which loaded are added to an environment; and `.rds` files, which store one object at a time and which when loaded can be stored in a variable of the user's choice. This presents a problem: what if you want to save a bunch of objects, and then only load *some* of them later? You can either load all the objects and use `rm()` to delete them, or you can use *pluckrda*:

```{r}
load_rda("file.rda", objects=c("var1", "var2", "var3"))
```

Running this line of code will load only the objects you specify. Want to store an object in a specific variable? Give it a name:

```{r}
load_rda("file.rda", objects=c("new_var_name" = "var1"))
```

You can mix and match named and unnamed variables. Want to load the objects into an environment other than the calling environment?

```{r}
my_other_environment <- new.env()
load_rda("file.rda", envir=my_other_environment)
```

Not sure what objects are inside a `.rda` file?

```{r}
list_objects("file.rda")
```

This package requires zero external R libraries and should work with any version of R on any operating system.

Hope this helps.

## Installation instructions

To install from GitHub, run the following code:

```{r}
remotes::install_github("aaronrudkin/pluckrda")
```
