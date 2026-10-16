# Pulls cost per AWS service for the last N days and saves it as JSON.
# Requires Cost Explorer to be enabled in your AWS account.
param(
    [int]$Days = 30
)

$start = (Get-Date).AddDays(-$Days).ToString("yyyy-MM-dd")
$end   = (Get-Date).ToString("yyyy-MM-dd")
$out   = "cost-report-$end.json"

aws ce get-cost-and-usage `
    --time-period "Start=$start,End=$end" `
    --granularity MONTHLY `
    --metrics "UnblendedCost" `
    --group-by "Type=DIMENSION,Key=SERVICE" | Out-File -Encoding utf8 $out

Write-Output "Cost report for $start to $end saved to $out"
