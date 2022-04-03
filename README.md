
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VSA_basic_model

<!-- badges: start -->
<!-- badges: end -->

The purpose of the VSA Basic Model project is to develop a basic VSA
model (VBM1), as an alternative to HRR, FHRR, BSC, MAP, etc., which is
as conceptually simple as possible, and relatively cheap
computationally. The motivation for this is that VBM1 would be the
default VSA model for my empirical projects, that is, it would be the
VSA equivalent of the geneticist’s fruit fly.

<!--
What is special about using `README.Rmd` instead of just `README.md`? You can include R chunks.
You'll still need to render `README.Rmd` regularly, to keep `README.md` up-to-date. `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots.
In that case, don't forget to commit and push the resulting figure files, so they display on GitHub. 
-->

All the work is documented in the notebook[^1] at:
<https://rgayler.github.io/VSA_basic_model/>

------------------------------------------------------------------------

Steps I used to make this project from scratch.

They assume that the notebook will be made publicly available via GitHub
Pages.

1.  Create a new project in RStudio with `renv` and a git repository.

2.  Install `devtools` and `notestar`. This takes a while because `renv`
    starts with an empty project library and there are lots of
    dependencies to install.  
    `renv::install("devtools")`  
    `devtools::install_github("tjmahr/notestar")`

3.  Create an appropriate license with `usethis::use_ccby_license()`.

4.  Create `README.Rmd` to start documenting these steps.  
    `usethis::use_readme_rmd()`

5.  Perform the first git commit.

6.  Create the `notestar` structure.  
    `notestar::use_notestar() # create directory structure and files`  
    `notestar:::use_notestar_makefile() # create makefile to enable Ctrl+B build`  
    `notestar::use_notestar_references() # adds refs.bib and apa.csl`

7.  Edit `_targets.R` to set the `title`, `author`, `bibliography`, and
    `csl` values.

    -   Do *not* edit `notebook/index.Rmd` because it is automatically
        created by `targets` from the values in `_targets.R`.

8.  Create the first notebook entry.  
    `notestar::notebook_create_page(date = "2022-04-03", slug = "design")`

    -   After the initial setup, this step is where you create new
        notebook entries and edit `_targets.R` and `R/functions.R` to
        implement the empirical work to be reported in the notebook.

9.  Build the notebook using the Build (Ctrl+B) shortcut in RStudio or
    `targets::tar_make()`.

    -   After the *first build only*, create a `docs` directory with
        contents `index.html` so the notebook is published on GitHub
        Pages. `index.html` is a hard link to the rendered notebook
        `notebook.html`.  
        `mkdir docs`  
        `ln notebook/book/docs/notebook.html docs/index.html`  
        (*Investigate whether this can be done in the `notestar` setup
        rather than as a separate shell step.*)

10. View the notebook using `notestar::notebook_browse()`.

11. Commit all the files and push the local git repository to the remote
    GitHub repository.

    -   On the *first time only* you can create the remote GitHub
        repository with `usethis::use_github()`.

        -   If prompted to store your GitHub PAT in `.Renviron` -
            [*don’t do
            it*](https://usethis.r-lib.org/articles/git-credentials.html#tldr-use-https-2fa-and-a-github-personal-access-token).

    -   On subsequent occasions just commit and push, as usual.

Iterating on steps 8–11 is the main flow for the notebook. We set up
data and modeling things in `_targets` and `R/functions.R`, then explore
and report them in notebook entries.

------------------------------------------------------------------------

<!--
How the data/modeling flow into the notebook entries and into the final
notebook:

```
{r graph, dpi = 144}
targets::tar_visnetwork(targets_only = TRUE)
```
-->

[^1]: The notebook structure is implemented with [TJ
    Mahr](https://www.tjmahr.com/)’s
    [`notestar`](https://github.com/tjmahr/notestar) package.
