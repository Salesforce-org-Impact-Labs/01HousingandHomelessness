# Scoring Metrics

All of the scoring metrics that affect the relevancy scores live in CustomMetadata.

For each metric, there is a weighting field that you can modify...it's a unitless measure, relative to the other weights.

Set a weight to 0 to cause it to be ignored.

## Org-based metrics

Some weights are based on your org's data and are calculated.  
For example, ratings quantity and ratings average.
The score is based on how a service compares to the other services tracked in your org, so the min/max for the org are calculated and stored to avoid running all that in real-time.

You can manually trigger this calculation by running `Scoring.ScoreAll();` in the developer console/execute anonymous.
