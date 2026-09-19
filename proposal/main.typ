#show link: set text(fill: blue)

#set page(paper: "us-letter", margin: (x: 1in, y: 1in, top: 0.5in))
#set document(title: "Congressional Campaign Finance Data Analysis", author: "Noah Schiro")
#set par(spacing: 0.8em)
#set enum(spacing: 0.55em)
#set list(spacing: 0.55em)
#show heading: set text(size: 11pt)
#show heading: set block(above: 0.75em, below: 0.35em)

#align(center, text(size: 14pt, weight: "bold")[Congressional Campaign Finance Data Analysis])

Noah Schiro (#link("mailto:noahschiro@g.harvard.edu")[noahschiro\@g.harvard.edu])

= Background and motivation
Every campaign cycle, congressional candidates raise hundreds of millions of dollars to fund their elections; this money must be reported to the Federal Election Commission (FEC), which publishes it for the public. This data shows how money influences both our representatives and the policies they vote on.

= Data
The FEC releases bulk data #link("https://www.fec.gov/data/browse-data/?tab=bulk-data")[here]. As US government data it is public domain and freely shareable. Key files:

- *Candidate master file* (`cn.txt`): name, party affiliation, election year, office (House, Senate, President), district.
- *Committee master file* (`cm.txt`): name, designation (candidate's committee, lobbyist, leadership PAC, etc.), party, interest group.
- *Candidate--committee linkage file* (`ccl.txt`): maps committees to the candidates they support.
- *Individual contributions* (`itcont.txt`): every itemized individual-to-committee contribution: committee ID, amount, date, donor name, employer, occupation.
- *Committee contributions* (`itpas2.txt`, `ototh.txt`): transactions between committees (transfers, PAC-to-party, etc.).

= Problem
Key questions we hope to answer:

+ Does an individual donor's employer or occupation predict which party they donate to?
+ How are donations distributed across states and districts, in total amount, average size, and the ratio of individual to PAC donations?
+ Given a donor's history, can we predict whom they will donate to next, evaluated by top-$k$ hit rate on donations held out from the final months of the cycle?

= Scope and methods
The project focuses on candidates currently in office (the 119th Congress): FEC cycles 2023--2024 for the House and 2019--2024 for the Senate (covering all three six-year Senate classes). The project will proceed in the following steps:

+ Build a deterministic and reproducible extract, transform, load (ETL) pipeline in Python (`pandas` / `polars`) to extract and clean the raw CSVs.
+ Load the cleaned data into a `postgres` relational database to allow for easy joins between tables (i.e. mapping candidate data to transaction data).
+ Perform exploratory data analysis with SQL queries and `matplotlib`, reporting answers to the non-modeling questions above.
+ Build models for the predictive questions: logistic regression or gradient-boosted trees to predict a donor's party, and a two-tower recommender system (separate embeddings for donors and for committees / candidates) to predict future donations.

= Concerns and limitations
The FEC data contains gigabytes of _text_ data that is difficult to parse and will require many cleaning steps; subsampling and memory-conscious tooling (`polars`, `postgres`) should keep computation manageable. The data is also structurally incomplete: loopholes and obfuscation techniques allow donations to go unreported. Finally, the individual contributions file contains personal information (donor names, employers, occupations); we will analyze aggregate patterns rather than profile identifiable individuals.

= Citations
- Federal Election Commission, #link("https://www.fec.gov/data/browse-data/?tab=bulk-data")[fec.gov/data/browse-data]. Accessed September 2026.
- I wrote the first draft; GLM-5.3-Flash used for grammar, spelling, and flow edits.
