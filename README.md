
<!-- README.md is generated from README.Rmd. Please edit that file -->

# VSA_basic_model

<!-- badges: start -->
<!-- badges: end -->

The purpose of the VSA Basic Model project is to develop a basic VSA
model (VBM1), as an alternative to HRR, FHRR, BSC, MAP, etc. , which is
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

2.  Install `notestar`. This may take a while because `renv` starts with
    an empty project library and there are lots of dependencies to
    install.  
    `renv::install("tjmahr/notestar")`

3.  Create an appropriate license.  
    `usethis::use_ccby_license()`.

    -   `usethis` should have been automatically installed as a
        dependency of `notestar`.

4.  Create `README.Rmd` to start documenting these steps.  
    `usethis::use_readme_rmd()`

    -   If you’re not planning to create figures in `README.Rmd` then
        you should delete the R code chunks. This will stop the
        directory `README_files` being created unnecessarily.

5.  Create the `notestar` directory structure and files.  
    `notestar::use_notestar()`

    -   Optionally, edit `config.yml` if you want to change the file
        locations.

6.  Configure `notestar` to use a Makefile.  
    `notestar:::use_notestar_makefile()`

    -   The “Build” tab and “Build All” button will not be displayed
        immediately. They will appear *after* the project has been
        closed and re-opened.

7.  Create the reference files, `refs.bib` and `apa.csl`.  
    `notestar::use_notestar_references()`

    -   **WARNING** If you use the RStudio visual editor citation tool,
        the bibliography name in the citation tool defaults to
        `references.bib`. You *must* change the bibliography name in the
        citation tool to `refs.bib`.
    -   **WARNING** If you use the RStudio visual editor citation tool
        to add a citation to a notebook page `.Rmd` file, the citation
        tool will add a `bibliography:` line to the YAML header in that
        file. This will cause the `notestar` document build to fail. You
        *must* delete the `bibliography:` line from the YAML header of
        the notebook page `.Rmd` file.

8.  Edit `_targets.R` to set the `title`, `author values`, and uncomment
    the `bibliography`, and `csl` lines.

    -   Do *not* edit `notebook/index.Rmd` (which contains these
        values)because it is automatically created by `targets` from the
        values in `_targets.R`.

9.  If you are publishing the notebook to GitHub Pages:

    1.  Edit `_targets.R` to add a new target to create a new directory
        and file `./docs/index.html` which is a hard link to the
        rendered notebook. It needs to be in this location so GitHub
        Pages can find it. The final list of \_targets.R is:

            list(
              targets_main,
              targets_notebook
            )

        Edit it to be:

            list(
              targets_main,
              targets_notebook,
              # link rendered notebook to ./docs/index.html for GitHub Pages
              tar_target(
                publish_to_github_pages,
                {
                  if(fs::dir_exists("docs")) fs::dir_delete("docs")
                  fs::dir_create("docs")
                  fs::link_create(tar_read(notebook), "docs/index.html", symbolic = FALSE)
                },
                format = "file"
              )
            )

    2.  Later, when the GitHub rempte repository has been created,
        remember to enable GitHub Pages for the repository and to set
        the source to be the `./docs` directory.

10. Create the first notebook page (i.e dated entry), choosing
    appropriate values for the `date` and `slug` arguments.  
    `notestar::notebook_create_page(date = "2022-04-03", slug = "design")`

    -   After the initial setup, this step is where you create new
        notebook entries.
    -   Edit `_targets.R` and `R/functions.R` to implement the empirical
        work to be reported in the notebook page. The assumption is that
        notebook pages will import (`targets::tar_read()`) the results
        of work carried out by `targets`.

11. Build the notebook using `targets::tar_make()` or the “Build All”
    button (or Ctrl+Shift+B shortcut) in RStudio.

    -   After the *first build only*, create a `./docs` directory
        containing the rendered notebook as the file
        `./docs/index.html`, so the notebook is published on GitHub
        Pages. `./docs/index.html` is created as a hard link to the
        rendered notebook `./notebook/book/docs/notebook.html`. The
        following shell code assumes the working directory is the
        project directory.  
        `mkdir docs`  
        `ln notebook/book/docs/notebook.html docs/index.html`

12. View the notebook using `notestar::notebook_browse()`.

13. Knit README.Rmd if necessary.

14. Commit all the files to the local git repository.

15. Push the local git repository to the remote GitHub repository.

    -   On the *first time only* you can create the remote GitHub
        repository with `usethis::use_github()` before pushing.

        -   If prompted to store your GitHub PAT in `.Renviron` -
            [*don’t do
            it*](https://usethis.r-lib.org/articles/git-credentials.html#tldr-use-https-2fa-and-a-github-personal-access-token).

    -   On subsequent occasions just commit and push, as usual.

Iterating on steps 8–14 is the main flow for the notebook. We set up
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
