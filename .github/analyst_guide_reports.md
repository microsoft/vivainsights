# Reports

**vivainsights** comes with a number of functions that allow you to generate automated HTML reports that are based off Viva Insights flexible queries. You can find a list of the reports available below.

Text in _italics_ indicate the required flexible query to run the report:

- _PQ_ - Person Query
- _MQ_ - Meeting Query

### Reports for Data Validation

- Automated Data Validation Report - `validation_report()` - [Demo](https://microsoft.github.io/wpa/report-demo/validation-report-demo.html) - _PQ_ + _MQ_ (Optional)

- Meeting Text Mining Report - `meeting_tm_report()` - [Demo](https://microsoft.github.io/wpa/report-demo/meeting-text-mining-report.html) - _MQ_


## Example Code

You can generate a report on collaboration by running the following code:

```R
library(vivainsights)
pq_data %>% validation_report()
```

This will generate an HTML report in the location of your working directory, and can take a few minutes to run if you have a large dataset loaded. The resulting HTML report can be opened with any web browser. 

For best and consistent results, please ensure that your dataset is loaded in using the `import_query()` function, which ensures that your variables are loaded in as the correct types required for **vivainsights** functions. 