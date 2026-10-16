# Stops all running EC2 instances tagged Project = CloudCostOptimization
$ids = aws ec2 describe-instances `
    --filters "Name=tag:Project,Values=CloudCostOptimization" "Name=instance-state-name,Values=running" `
    --query "Reservations[].Instances[].InstanceId" --output text

$ids = $ids -split "\s+" | Where-Object { $_ }

if ($ids) {
    aws ec2 stop-instances --instance-ids $ids | Out-Null
    Write-Output "Stopped instances: $($ids -join ', ')"
} else {
    Write-Output "No running instances found."
}
