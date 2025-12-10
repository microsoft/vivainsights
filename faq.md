# Frequently Asked Questions

## General

### Why should I use R for Viva Insights?

R is an open-source statistical programming language and one of the most
popular toolkits for data analysis and data science. There are four key
reasons why a Viva Insights analyst might choose to use R instead of
other alternatives:

1.  R has an **immense package eco-system** with over [22,100
    packages](https://cran.r-project.org/web/packages/) for advanced
    applications from building random forest models to Organizational
    Network Analysis (ONA) graph visualizations. This enables analysts
    to perform specialized and more in-depth analysis for specific Viva
    Insights use cases, such as predicting employee churn by analyzing
    Viva Insights metrics.
2.  There are **no licensing costs** with R, which enables analysts to
    leverage the powerful functionality with no additional cost.  
3.  R has a code-oriented workflow (as opposed to point-and-click),
    which promotes **reproducibility**. This is valuable for improving
    the quality of the analysis and for efficiently replicating analysis
    with different data samples.
4.  R also has a **substantial user community**, which analysts can
    access to support and augment their analysis capabilities.

## Installation and Setup

### Which version of R should I use?

You are recommended to use the latest stable version of R. You can find
the latest version on <https://www.r-project.org/>.

### How do I install from a development / experimental branch of the package?

If you wish to install a version of the package from any branch **other
than the main branch**, you can run the following code:

``` r
devtools::install_git(url = "https://github.com/microsoft/vivainsights.git",
                      branch = "<BRANCH-NAME>", # Replace
                      build_vignettes = TRUE)
```

You should replace the `<BRANCH-NAME>` with the name of your target
branch, such as `"feature/network-functions"`.

### Should I install R to my OneDrive or a cloud folder?

No, you should not. You should never install the default directory for R
to OneDrive, as R is a program and you are likely to experience
significant cloud syncing issues if you do so. If you use Windows and
have experienced this issue, please uninstall and follow the below steps
for re-installation:

1.  Install RStudio to the default directory,
    e.g. `C:\Program Files\R\R-4.X.X\library\base\R\Rprofile`
2.  Change the default RStudio package installation location so that it
    does not save to OneDrive, or another cloud drive. This ensures that
    OneDrive doesn’t attempt to upload the thousands of files that will
    be downloaded via the installation of the packages. The R folder
    where these packages install to is by default created in the
    Documents folder, which by automatically syncs with OneDrive. We
    will be moving the installation path to our local `C:` drive instead
    to prevent this.
3.  Create a local folder. Open `File Explorer` -\> `C:` drive -\>
    `Create New Folder` -\> Name it `"R"`
4.  Change permissions:
    - If you installed RStudio in the default directory, the path to
      your RProfile file is
      `C:\Program Files\R\R-4.X.X\library\base\R\Rprofile`
    - Navigate to `C:\Program Files\R\R-4.X.X\library\base\`
    - Double-click the base folder so that you’re looking at its
      contents, which include the R subfolder.
    - Right-click on the R subfolder and select Properties.
    - Click on the `Security` tab.
    - Click on the `Edit` button.
    - Scroll down the Group or user names pane and click on the Users
      line near the bottom of that list.
    - In the `Permissions for users` pane, click on the `Full Control`
      checkbox under `Allow`.
    - Click OK and OK again to save and exit these windows.
5.  Edit the `Rprofile` file:
    - Ensure that RStudio is closed.
    - Navigate to `C:\Program Files\R\R-4.X.X\library\base\R\`
    - Open the `Rprofile` file with your preferred text editor.
    - Save a copy of the file in the same directory and name it
      `"RProfileBackup.txt"`.
    - Reopen the `Rprofile` file with your preferred text editor.
    - Replace the string `Sys.getenv("R_USER")` with the string `"C:/R"`
      - Ensure you are replacing the string `Sys.getenv("R_USER")` and
        NOT the string `Sys.getenv("R_LIBS_USER")`
      - The string `"C:/R"` should align with the directory where you
        created the folder in step 3a
      - Reference the `RProfileBackup.txt` as a backup if OneDrive
        uploads the package files after installation
    - Save the file and close out of your text editor and File Explorer.

You should then be able to install the **vivainsights** library by
opening RStudio and running the following code:

``` r
# Check if remotes is installed, if not then install it
if(!"remotes" %in% installed.packages()){
  install.packages("remotes")
}
remotes::install_github(repo = "microsoft/vivainsights", upgrade = "never")
```

You can then restart RStudio with `Ctrl` + `Shift` + `F10` in Windows.

### How do I export the outputs of my analysis to Excel?

The
[`export()`](https://microsoft.github.io/vivainsights/reference/export.md)
function allows you to export the outputs of your analysis to Excel in
two ways.  
1. By setting `method` to `"clipboard"` and passing a data frame through
to
[`export()`](https://microsoft.github.io/vivainsights/reference/export.md)
, the results will be copied to your clipboard and you can paste it
through to Excel. 2. By setting `method` to `"csv"`, a CSV file will be
saved in the specified path relative to your current working directory.
The CSV file can then be opened in Excel.

If you would like to export a *list* of data frames to Excel where (i)
each data frame in the list corresponds to a *Worksheet* and (ii) the
name of each list member corresponds to the *Sheet name*, you can use
`writexl::write_xlsx()`. **vivainsights** does not depend on functions
from **writexl**, so you may need to load and install it separately.

## Analysis and Visualization

### How do I filter by specific date ranges?

We recommend using **dplyr** (which is loaded in as part of
**tidyverse**) for data manipulation. To filter down to a specific date
range in a Person Query, you can run:

``` r
library(vivainsights)
library(tidyverse) # Or load dplyr separately

# Read a Person Query from local directory
# Assign it to `raw_pq`
raw_pq <- import_query("data/person query.csv")

# Assign filtered data frame to `clean_pq`
clean_pq <-
    raw_pq %>%
    filter(Date >= as.Date("08/30/2024", "%m/%d/%Y")) %>%
    filter(Date <= as.Date("12/19/2024", "%m/%d/%Y"))
```

The above example filters the date range from the week commencing 30th
of August 2024 to the week ending 19th of November 2024 inclusive. Note
that the first date is a Sunday (beginning of the week) and the second
date is a Saturday (end of the week). If you query is run by **day**,
you should specify the *after* filter as the exact last day, rather than
the Saturday of the week.

In some scenarios, you may also want to exclude a particular week from
the data. You can use a similar approach:

``` r
clean_pq2 <-
    clean_pq %>%
    filter(Date != as.Date("11/22/2024", "%m/%d/%Y"))
```

The above line of code excludes the week of 22nd of November 2024, using
the operator `!=` to denote *not equal to*. Conversely, you can isolate
that single week by replacing `!=` with `==`.

### How do I create a custom HR variable?

The most common way to create a ‘custom HR variable’ is to create a
categorical variable from one or more numeric variables. You may want to
do this if you are trying to *bin* a numeric variable or create a custom
rule-based segmentation with Viva Insights metrics.

Here is an example of how to create a categorical variable
(`N_DirectReports_NET`) with a numeric variable representing the number
of direct reports, using
[`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)
and
[`dplyr::case_when()`](https://dplyr.tidyverse.org/reference/case_when.html)
.

``` r
library(vivainsights)
library(tidyverse) # Or load dplyr

clean_pq_with_new_var <-
  clean_pq %>% # Standard Person Query
  mutate(N_DirectReports_NET =
         case_when(NumberofDirectReports == 0 ~ "0",
                   NumberofDirectReports == 1 ~ "1",
                   NumberofDirectReports <= 5 ~ "2 to 5",
                   NumberofDirectReports <= 10 ~ "6 to 10",
                   NumberofDirectReports <= 20 ~ "Up to 20",
                   NumberofDirectReports >= 21 ~ "21 +",
                   TRUE ~ "Not classified"))
```

[`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)
creates a new column, whereas
[`dplyr::case_when()`](https://dplyr.tidyverse.org/reference/case_when.html)
runs an if-else operation to classify numeric ranges to the right hand
side of the `~` symbol. When the expression on the left hand side
evaluates to `TRUE`, the value on the right hand side is assigned to the
new column. At the end of the code, you will see that anything that
doesn’t get classified gets an ‘error handling’ value. If a value ends
up as “Not classified”, you should check whether there may be gaps in
your
[`dplyr::case_when()`](https://dplyr.tidyverse.org/reference/case_when.html)
chunk that is not capturing all the values.

Once you have created this new variable and checked that the
classifications are correct, you can further your analysis by using it
as an HR attribute, such as:

``` r
clean_pq_with_new_var %>%
    keymetrics_scan(hrvar = "N_DirectReports_NET")
```
