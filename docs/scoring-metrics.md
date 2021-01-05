# Scoring Metrics

All the scoring metrics that affect relevancy scores are in CustomMetadata. For each metric, you can modify the weighting field. Relative to the other weights, it’s a unitless measure. To ignore a weight, set it to 0.


## Customized metrics

Some weights are based on your Salesforce org's data and are calculated. For example, ratings quantity and ratings average  scores are based on how a service compares to the other services tracked in your org. So the minimum and maximum for the org are calculated and stored to avoid running them in real-time.

To manually trigger this calculation, you can run Scoring.ScoreAll(); in the developer console/execute anonymous.

