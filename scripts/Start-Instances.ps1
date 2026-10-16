# Starts all stopped EC2 instances tagged Project = CloudCostOptimization
$ids = aws ec2 describe-instances `
    --filters "Name=tag:Project,Values=CloudCostOptimization" "Name=instance-state-name,Values=stopped" `
    --query "Reservations[].Instances[].InstanceId" --output text

$ids = $ids -split "\s+" | Where-Object { $_ }

if ($ids) {
    aws ec2 start-instances --instance-ids $ids | Out-Null
    Write-Output "Started instances: $($ids -join ', ')"
} else {
    Write-Output "No stopped instances found."
}
