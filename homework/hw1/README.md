# Homework 1

## Logistics

- This homework is due by Feb. 23 at 11:59PM
- You should submit it on Blackboard (under Assignments) and include both your final `hw_1.Rmd` and `hw_1.pdf` files
- Make sure you compile your very final version of `hw_1.Rmd` to produce `hw_1.pdf` before submitting
- Note that you can also submit `hw_1.Rmd` and `hw_1.html` if compiling to a PDF does not work -- [see below](https://github.com/jdstorey/asdscourse/tree/master/homework/hw1/README.md#note)

## Some installations you need to do

First, install R, RStudio, and LaTeX; [links are provided](https://jdstorey.github.io/asdscourse/software/) on the course web site.

Open RStudio and type the following in the R console:

```
install.packages("tidyverse", dependencies=TRUE)
```

If this returns any errors that you're unable to resolve, please contact us ASAP.

Next, you need to have LaTeX installed on your computer.

- If you are a Mac user, download and install the MacTeX software: https://www.tug.org/mactex/mactex-download.html
- If you are a Windows user, download and install MiKTeX: http://miktex.org/download
- If you are a Linux user, install TeX Live: https://www.tug.org/texlive/

## Getting started

1. Go to https://github.com/jdstorey/asdscourse/tree/master/homework/hw1 and download all files to the directory you've created on your computer for this homework assignment
2. Do not rename any files or move any files from the directory on your computer
3. Double click the `hw_1.Rmd` file and it should open in RStudio
4. Click the `Knit PDF` button
5. Step 4 should compile and produce a PDF called `project_1.pdf` without any errors -- please contact us ASAP if you get any errors that you're unable to resolve

## NOTE

If you're having trouble getting `hw_1.Rmd` to compile into `hw_1.pdf`, then we suggest that you instead compile `hw_1.Rmd`into an HTML file, which will be called `hw_1.html`.  To do this, change this line in the `hw_1.Rmd` YAML header

```
output: pdf_document
```

to 

```
output: html_document
```

The `Knit PDF` button should now show `Knit HTML`.  If not, save `hw_1.Rmd`, quit RStudio, and then reopen it.
