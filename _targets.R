library(targets)
library(tarchetypes)
library(notestar)
# options(tidyverse.quiet = TRUE)
# library(tidyverse)

source("R/functions.R")



tar_option_set(
  packages = c(
    # "tidyverse",
    "notestar"
  ),
  imports = c("notestar")
)


# Develop your main targets here
targets_main <- list(

)


# To modify the notebook theme or the locations of the files used by notestar,
# edit config.yml.
targets_notebook <- list(
  tar_notebook_index_rmd(
    title = "VSA Basic Model",
    author = "Ross W. Gayler",
    # notestar::use_notestar_references() will provide these files
    # in the notebook folder. then uncomment these lines and modify
    # files as needed:
    bibliography = "references.bib",
    csl = "apa.csl"
  ),
  tar_notebook_pages(),
  tar_notebook(
    ## We can tell notestar to make the notebook depend on any extra targets by
    ## creating the targets and passing them through here:
    # extra_deps = list(...)
  ),

  # Remove the following three targets to disable spellchecking
  # or add new exceptions here
  tar_target(
    spellcheck_exceptions,
    # add new exceptions here
    c("tibble")
  ),

  tar_target(
    spellcheck_notebook,
    spelling::spell_check_files(notebook_rmds, ignore = spellcheck_exceptions)
  ),

  # Prints out spelling mistakes when any are found
  tar_force(
    spellcheck_report_results,
    print(spellcheck_notebook),
    nrow(spellcheck_notebook) > 0
  )
)

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
