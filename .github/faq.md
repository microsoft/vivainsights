# Frequently Asked Questions

## General

### Why should I use R for Viva Insights?

R is an open-source statistical programming language and one of the most popular toolkits for data analysis and data science. There are four key reasons why a Viva Insights analyst might choose to use R instead of other alternatives:

1.	R has an **immense package eco-system** with over [17,000 packages](https://cran.r-project.org/web/packages/) for advanced applications from building random forest models to Organizational Network Analysis (ONA) graph visualizations. This enables analysts to perform specialized and more in-depth analysis for specific Viva Insights use cases, such as predicting employee churn by analyzing Viva Insights metrics. 
2.	There are **no licensing costs** with R, which enables analysts to leverage the powerful functionality with no additional cost.  
3.	R has a code-oriented workflow (as opposed to point-and-click), which promotes **reproducibility**. This is valuable for improving the quality of the analysis and for efficiently replicating analysis with different data samples.
4.	R also has a **substantial user community**, which analysts can access to support and augment their analysis capabilities.

## Installation and Setup

### I cannot install the package with `install.packages()`. Why is that?

Since 4th October 2022, `install.packages()` should work with **vivainsights** as it is made available on CRAN on that date. If you continue to experience issues, please create an issue at https://github.com/microsoft/vivainsights/issues/, and install with the development version in the mean time: 

```R
remotes::install_github(repo = "microsoft/vivainsights", upgrade = "never") 
```
If the above does not work, please also try:

```R
remotes::install_git(url = "https://github.com/microsoft/vivainsights.git", upgrade = "never")
```

For more information regarding installation, please see our [Getting Started](https://microsoft.github.io/vivainsights/analyst_guide_getting_started.html) page.

### I see a warning message about the installation of Rtools. What should I do?

You may see the following message during installation:
```
WARNING: Rtools is required to build R packages, but is not currently installed.
```
This message appears when R is trying to install or update packages that require compilation from binaries, which requires the installation of Rtools. To get around this, we recommend selecting `No` when prompted the question `Do you want to install from sources the packages which needs compilation?` when updated the packages. Alternatively, you can also choose to install [Rtools](https://cran.r-project.org/bin/windows/Rtools/). 

The reason why you may be prompted the _install from sources_ question is because one of the packages that **vivainsights** is dependent on has updated recently on CRAN, but the binary is not available for your operating system (yet). If you choose `No`, you will not get the most recent version, which in most cases will not be a problem. If you choose `Yes`, the package will be built from source locally, and you will need **Rtools** to do that. [^1]

[^1]: This answer references Jenny Bryan's original response [here](https://community.rstudio.com/t/meaning-of-common-message-when-install-a-package-there-are-binary-versions-available-but-the-source-versions-are-later/2431/2) on RStudio Community.

### I'm still having trouble installing the package. What can I do?

The most common cause for package installation failures is when users try to install the package when some of the dependent packages are loaded. As a best practice, you should always install or update packages in a _fresh_ R Session (no packages loaded and a clear workspace). In RStudio, you can refresh your session with the shortcut `Ctrl + Shift + F10`. You can try the installation command again in a new R Session. 

Make sure you follow the recommend installation steps listed on our [Getting Started](https://microsoft.github.io/vivainsights/analyst_guide_getting_started.html) page. If installation problems persist, please create an issue at <https://github.com/microsoft/vivainsights/issues/> and describe the error message that you see on your console. 

### Which version of R should I use?

You are recommended to use the latest stable version of R. You can find the latest version on <https://www.r-project.org/>. 

### How do I install from a development / experimental branch of the package?

If you wish to install a version of the package from any branch **other than the main branch**, you can run the following code:
```R
devtools::install_git(url = "https://github.com/microsoft/vivainsights.git",
                      branch = "<BRANCH-NAME>", # Replace
                      build_vignettes = TRUE)
```
You should replace the `<BRANCH-NAME>` with the name of your target branch, such as `"feature/network-functions"`.

### Should I install R to my OneDrive or a cloud folder? 

No, you should not. You should never install the default directory for R to OneDrive, as R is a program and you are likely to experience significant cloud syncing issues if you do so. If you use Windows and have experienced this issue, please uninstall and follow the below steps for re-installation:

1. Install RStudio to the default directory, e.g. `C:\Program Files\R\R-4.X.X\library\base\R\Rprofile` 
2. Change the default RStudio package installation location so that it does not save to OneDrive, or another cloud drive. This ensures that OneDrive doesn’t attempt to upload the thousands of files that will be downloaded via the installation of the packages. The R folder where these packages install to is by default created in the Documents folder, which by automatically syncs with OneDrive. We will be moving the installation path to our local `C:` drive instead to prevent this.
3. Create a local folder. Open `File Explorer` -> `C:` drive -> `Create New Folder` -> Name it `"R"`
4. Change permissions:
    - If you installed RStudio in the default directory, the path to your RProfile file is `C:\Program Files\R\R-4.X.X\library\base\R\Rprofile`
    - Navigate to `C:\Program Files\R\R-4.X.X\library\base\`
    - Double-click the base folder so that you’re looking at its contents, which include the R subfolder.
    - Right-click on the R subfolder and select Properties.
    - Click on the `Security` tab.
    - Click on the `Edit` button.
    - Scroll down the Group or user names pane and click on the Users line near the bottom of that list.
    - In the `Permissions for users` pane, click on the `Full Control` checkbox under `Allow`.
    - Click OK and OK again to save and exit these windows.
5. Edit the `Rprofile` file:
    - Ensure that RStudio is closed.
    - Navigate to `C:\Program Files\R\R-4.X.X\library\base\R\`
    - Open the `Rprofile` file with your preferred text editor.
    - Save a copy of the file in the same directory and name it `"RProfileBackup.txt"`.
    - Reopen the `Rprofile` file with your preferred text editor.
    - Replace the string `Sys.getenv("R_USER")` with the string `"C:/R"`
      - Ensure you are replacing the string `Sys.getenv("R_USER")` and NOT the string `Sys.getenv("R_LIBS_USER")`
      - The string `"C:/R"` should align with the directory where you created the folder in step 3a
      - Reference the `RProfileBackup.txt` as a backup if OneDrive uploads the package files after installation
    - Save the file and close out of your text editor and File Explorer.

You should then be able to install the **vivainsights** library by opening RStudio and running the following code:
```R
# Check if remotes is installed, if not then install it
if(!"remotes" %in% installed.packages()){
  install.packages("remotes")
}
remotes::install_github(repo = "microsoft/vivainsights", upgrade = "never")

```

You can then restart RStudio with `Ctrl` + `Shift` + `F10` in Windows.

## Import / Export

### Which flexible queries can I use with the R package?

Currently, you can use the Person Query with the R package. In **vivainsights**, you can call up a demo person query dataset with `pq_data`, which becomes available once you have loaded the package. 

### How do I export the outputs of my analysis to Excel?

The `export()` function allows you to export the outputs of your analysis to Excel in two ways.   
1. By setting `method` to `"clipboard"` and passing a data frame through to `export()` , the results will be copied to your clipboard and you can paste it through to Excel. 
2. By setting `method` to `"csv"`, a CSV file will be saved in the specified path relative to your current working directory. The CSV file can then be opened in Excel. 

If you would like to export a _list_ of data frames to Excel where (i) each data frame in the list corresponds to a _Worksheet_ and (ii) the name of each list member corresponds to the _Sheet name_, you can use `writexl::write_xlsx()`.  **vivainsights** does not depend on functions from **writexl**, so you may need to load and install it separately. 

## Analysis and Visualization

### How do I filter by specific date ranges?

We recommend using **dplyr** (which is loaded in as part of **tidyverse**) for data manipulation. To filter down to a specific date range in a Person Query, you can run:

```R
library(vivainsights)
library(tidyverse) # Or load dplyr

# Read Standard Person Query from local directory
# Assign it to `raw_spq`
raw_spq <- import_query("data/standard person query.csv")

# Assign filtered data frame to `clean_spq`
clean_spq <-
	raw_spq %>%
	filter(Date >= as.Date("08/30/2020", "%m/%d/%Y")) %>%
  	filter(Date <= as.Date("12/19/2020", "%m/%d/%Y"))
```

The above example filters the date range from the week commencing 30th of August 2020 to the week ending 19th of November 2020 inclusive. Note that the first date is a Sunday (beginning of the week) and the second date is a Saturday (end of the week). If you query is run by **day**, you should specify the _after_ filter as the exact last day, rather than the Saturday of the week. 

In some scenarios, you may also want to exclude a particular week from the data. You can use a similar approach:

```R
clean_spq2 <-
	clean_spq %>%
	filter(Date != as.Date("11/22/2020", "%m/%d/%Y"))
```

The above line of code excludes the week of 22nd of November 2020, using the operator `!=` to denote _not equal to_. Conversely, you can isolate that single week by replacing `!=` with `==`.

### How do I create a custom HR variable?

The most common way to create a 'custom HR variable' is to create a categorical variable from one or more numeric variables. You may want to do this if you are trying to _bin_ a numeric variable or create a custom rule-based segmentation with Viva Insights metrics. 

Here is an example of how to create a categorical variable (`N_DirectReports_NET`) with a numeric variable representing  the number of direct reports, using `dplyr::mutate()` and `dplyr::case_when()` .

```R
library(vivainsights)
library(tidyverse) # Or load dplyr

clean_spq_with_new_var <-
  clean_spq %>% # Standard Person Query
  mutate(N_DirectReports_NET =
         case_when(NumberofDirectReports == 0 ~ "0",
                   NumberofDirectReports == 1 ~ "1",
                   NumberofDirectReports <= 5 ~ "2 to 5",
                   NumberofDirectReports <= 10 ~ "6 to 10",
                   NumberofDirectReports <= 20 ~ "Up to 20",
                   NumberofDirectReports >= 21 ~ "21 +",
                   TRUE ~ "Not classified"))
```

`dplyr::mutate()` creates a new column, whereas `dplyr::case_when()` runs an if-else operation to classify numeric ranges to the right hand side of the `~` symbol. When the expression on the left hand side evaluates to `TRUE`, the value on the right hand side is assigned to the new column. At the end of the code, you will see that anything that doesn't get classified gets an 'error handling' value. If a value ends up as "Not classified", you should check whether there may be gaps in your `dplyr::case_when()` chunk that is not capturing all the values. 

Once you have created this new variable and checked that the classifications are correct, you can further your analysis by using it as an HR attribute, such as:

```R
clean_spq_with_new_var %>%
	keymetrics_scan(hrvar = "N_DirectReports_NET")
```

### How do I customize a visual generated from a **vivainsights** function?

With a few exceptions, most plot outputs returned from **vivainsights** functions are `ggplot` objects. What this means is that you can edit or add layers to the outputs. 

### How do I create a bar chart with a custom metric?

Sometimes you may wish to create an equivalent bar chart of `email_sum()`, but for a custom metric or another Viva Insights metric that does not form part of the `*_sum()` family. This is where **flexible functions** are helpful, where you can use `create_bar()` to produce the same visualization by supplying the custom metric name to the `metric` argument. For instance, a bar chart for `"Generate_workload_email_hours"` could be run with:
```R
create_bar(sq_data, metric = "Generate_workload_email_hours")
```
The same person-average computation is used and the same minimum group threshold argument is also available with `create_bar()`. The same is equivalent for the other visualizations:

  - `email_line()` --> `create_line()`
  - `email_trend()` --> `create_trend()`
  - `email_dist()` --> `create_dist()`
  - `email_fizz()` --> `create_fizz()`
  - `email_rank()` --> `create_rank()`

Some functions also act as wrappers around **ggplot2** code where the data is directly plotted without additional person average computation. Examples include `create_bar_asis()` and 
`create_line_asis()`.

### How do I reorder HR attributes when creating a plot in the package? 

Some functions, such as `create_bar()` , offer an argument (`rank`) for ordering the categorical variable, i.e. the HR attribute when creating the visualisation. Other functions by default perform no ordering, so they show up in the same order as the data is presented. 

For instance, the following code would yield a stacked bar plot with no ordering applied: 
```R
library(vivainsights)
library(tidyverse)

#### NO REORDERING ####
pq_data %>%
  create_dist(hrvar = "LevelDesignation",
              metric = "Email_hours")
```

To apply an ordering manually, the best way is to convert the HR attribute into a **factor** variable, where you can specify the _levels_. You can understand _levels_ as a way to specify the order in which the values of your HR attribute should be ranked. The following code will yield an ordered stacked bar plot: 
```R
#### ORDERING APPLIED ####
ld_order <-
  c( # Order levels
    "Executive",
    "Director",
    "Manager",
    "Senior IC",
    "Junior IC",
    "Support") %>%
  rev() # Reverse if necessary


pq_data %>%
  mutate(LevelDesignation = factor(
    LevelDesignation, 
    levels = ld_order # Specify order
  )) %>%
  create_dist(hrvar = "LevelDesignation",
              metric = "Email_hours")
```
Note that the `levels` argument within `factor()` accepts a character vector which matches the values in your HR attribute. 

### Can I use visuals from the package within Power BI? 

_Note: this is not a Power BI documentation and therefore will not contain the most recent information on Power BI's capabilities. This information is accurate to the extent of the author's knowledge at the time of writing._ 

To use visuals from the **vivainsights** R library within Power BI, there are two pre-requisites beyond having R and the package installed:

- R home directories set. Follow the steps described in [Create Power BI visuals using R - Power BI](https://docs.microsoft.com/en-us/power-bi/create-reports/desktop-r-visuals#enable-r-visuals-in-power-bi-desktop). 
- Query data imported to Power BI 

Only visuals generated from the package of the `ggplot` object type can be embedded within Power BI. In most cases, what this means is that the visual will only display if the value passed to the `return` argument in your function is `"plot"`. For instance, the following is code returns a valid object: 

```R
pq_data %>% email_dist(return = "plot")
```
Note that there are some exceptions to the `"plot"` rule, as some functions return a HTML widget, such as `create_sankey()`. You will also not be able to return data frames, HTML reports, or DataTables objects (the output of `create_dt()`).

The documentation [here](https://docs.microsoft.com/en-us/power-bi/create-reports/desktop-r-visuals#enable-r-visuals-in-power-bi-desktop) provides more details on the limitations of the R visuals. 

Here are a series of steps, slightly abridged, taken from the Power BI documentation, last updated July 6th 2021: 

1.	Select the R Visual icon in the Visualization pane to add an R visual.
2.	In the`Enable script visuals` window that appears, select `Enable`.
3.	In the `Values` section of the `Visualization` pane, drag fields from the `Fields` pane that you want to consume in your R script, just as you would with any other Power BI Desktop visual. 
    - Alternatively, you can also select the fields directly in the `Fields` pane.
    - Only fields that you've added to the `Values` section are available to your R script.
    - You can add new fields or remove unneeded fields from the `Values` section while working on your R script in the R script editor. Power BI Desktop automatically detects which fields you've added or removed.
    - The generated dataframe is named `dataset`, and you access selected columns by their respective names.
    - Make sure to use OrderDate instead of Date Hierarchy.
    - Ensure that you have `PersonId`, `Date`, any relevant metrics, and HR attributes included as required as inputs to the R function. 
4.	In the R script editor, below the line `"# Paste or type your script code here:,"` paste or type: 
`library(vivainsights)`
5.	Continue pasting or typing the scripts
CAUTION: You can run functions in PBI R visual only when the output is visual `= "plot"`. Otherwise, there will be an error in the R visual placeholder on the report canvas when you run the script.
6.	Run the script by clicking `Run script` icon in the script editor.
7.	When you modify the script or change the visual area size, you can refresh the visual by clicking Run script icon.
8.	You may apply filters just like other Power BI visuals using Filter pane.

A minimal example that you could try on your R script editor is: 
```R
library(vivainsights)
dataset %>% email_sum()
```

## Contributing and Engaging

### How do I find help if I have questions about using the package?

You can create an issue at <https://github.com/microsoft/vivainsights/issues/> if you have questions about using the R package. There are no silly questions: chances are that other users have the same question as you, and creating an issue helps us make the package documentation more user-friendly and help other users such as yourself. 

### Uh-oh, I've noticed a bug with the package. How do I report this?

You can create a bug report at <https://github.com/microsoft/vivainsights/issues/> if you think you have found a bug with our package. We really appreciate user feedback and we will credit all contributions on our package website. 

### I have some ideas regarding a new feature for the R package. How can I get involved?

If you have an idea in which you would like to collaborate, you can create an issue at <https://github.com/microsoft/vivainsights/issues/>. If there is code that is ready to be reviewed, you can also fork our repository and create a pull request. We'd like to ask you to read our [Contributor Guide](https://microsoft.github.io/vivainsights/CONTRIBUTING.html) and [Developer Guide](https://microsoft.github.io/vivainsights/developer_guide.html) prior to contributing. We will credit your contributions accordingly when your contribution is successfully merged with the package. 

