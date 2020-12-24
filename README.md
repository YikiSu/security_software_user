
# Security software users by income groups testing analysis

-   Author: Zhanyi Su (Yiki)

## About

In this project, I am interested in finding whether there is a
difference between the ratio of security software users by different
income groups.

The data set in this project is from the Statistics Canada called
“Internet security software use, by household income, age group and
level of education,” which can be found
[here](https://open.canada.ca/data/en/dataset/6e45b085-1fbf-4ba4-881b-f4eebbb3764e).
This data set consists of the responses from the 2018 Canadian Internet
Use Survey (CIUS), which aims to collect information regarding the use
of digital technologies and the online behaviors for Canadians who are
over age 15 (2018 Canadian Internet Use Survey 2012). This field sample
consists of 45,400 units of data and this data set is a summary data set
from all survey responses. This data set has 400 observations with 18
attributes. Each observations represents a survey response with certain
attribute regarding the year of the security software usage status, the
education level, whether security software is used, income level, the
proportion of users and etc. In this project, only two features will be
used: `Security software use`, `Household income quartile`, `VALUE`. The
information regarding these features are:

-   **Security software use**:
    `Internet users that currently use security software` or
    `Internet users that currently use free versions of security software`.

-   **Household income quartile**:

    -   Highest quartile household income: $87,000 or higher for 2010
        data and $94,000 or higher for 2012 data

    -   Third quartile household income: $50,000 to $87,000 for 2010
        data and $55,000 to $94,000 for 2012 data

    -   Second quartile household income: $30,000 to $50,000 for 2010
        data and $30,000 to $55,000 for 2012 data

    -   Lowest quartile household income: less than or equal to $30,000

-   **Value**: Percentage of all individuals aged 16 years old and over
    who responded to have used the Internet for personal non business
    use in the past twelve months from any location

## Usage

The replication of this project can be done by installing the following
dependencies and running the following commands from the root directory
of this project:


    # Download the raw data:

    Rscript script/download_data.R --url="https://www150.statcan.gc.ca/n1/tbl/csv/22100010-eng.zip" --out_path="data"

    # Clean the raw data file:

    Rscript script/clean_data.R --input="data/22100010.csv" --out_path="result"

## Dependencies

-   R version 3.6.1 and R packages:

    -   docopt==0.7.1

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-data" class="csl-entry">

2018 Canadian Internet Use Survey. 2012. “Statistics Canada.”
<https://open.canada.ca/data/en/dataset/6e45b085-1fbf-4ba4-881b-f4eebbb3764e>.

</div>

</div>
