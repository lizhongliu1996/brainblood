# brainblood
This is a repository of project that compare methylation correction between brain and blood, the work flow is
1. match pfc and blood samples, subset and divided whole data into two groups
2. calculate correlation for each cpgs
3. do aclust, calculate correlation for each clusters
4. use getSegment to select regions, calculate correlation for each clusters
5. compare correlation difference of these methods on different genomic and methylation regions